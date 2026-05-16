# I/O デバイス計画: RTC / ディスプレイ / キーボード / /dev / console

**ステータス: 設計のみ (未実装、2026-05-16)**

Pico 2 に RTC・SPI ディスプレイ (ILI9488)・GPIO マトリクスキーボードを
追加し、ローカルコンソールを実現するための設計方針。実装はまだ無い。
この文書は決定事項とその根拠を残すためのもの。

---

## 1. 全体方針

- **ドライバはすべてカーネル内**に置く。既存の `block_*` / `fatfs` /
  UART と同じパターン。userspace ドライバプロセスにするには MMIO の
  userspace マッピングと割り込みフォワーディングが必要で、どちらも
  現状存在せず、self-hosting フェーズの本筋から外れる。
- カーネルのデバイスドライバは **dumb なプリミティブ**に保つ。ポリシー
  (ターミナルエミュレーション、ウィンドウ管理) は userspace に置く。
- 公開は VFS の `/dev/` 経由。

## 2. SPI バス構成

SD カードとディスプレイは **別の SPI モジュールに分ける**。

- SD カード → SPI0 (既存、`kernel/block_sd.tc`)
- ディスプレイ → SPI1 (新規)

共有も技術的には可能 (CS 別 + トランザクションごとに baud 切り替え)
だが、ILI9488 は SD の 6 MHz では実用にならず (フルフレーム ~600 ms)、
分離すればディスプレイを高クロック固定でき、DMA で SD I/O と並行
できる。

### SD SPI クロックの上限 (参考)

現状 SD は 6 MHz。これは `platform_pico2.s` が `clk_peri` を XOSC
(12 MHz) に固定しているため (PL022 の CPSDVSR 最小 2 → 12/2=6 MHz)。
上げるには `clk_peri` を PLL_SYS (150 MHz) に切り替え、UART の
IBRD/FBRD を 150 MHz 用に再計算する必要がある。ただし self-replicate
の支配項はバス帯域ではなく per-sector オーバーヘッド + SD program
latency + FAT 更新なので、クロック引き上げの効果は限定的
(`docs/scaling.md` 参照)。本当に効くのは CMD25 マルチブロック書き込み。

## 3. `/dev` の導入

現在 VFS のルーティングは `/tmp/`→tmpfs、`/proc/`→procfs、それ以外
→mtfs の 3 つのみ。`/dev` は未実装 (`vfs.tc` に予定地のコメントあり)。
UART は `fd 2` 直行というパスでない経路で絡んでいる。

### `/proc` と `/dev` の使い分け

| | 用途 | 書き込み |
|---|---|---|
| `/proc` | システム状態の読み取り専用スナップショット (introspection) | **不可** |
| `/dev` | ハードウェアへの I/O エンドポイント | 可 |

**invariant: `/proc` は絶対に read-only**。書きたくなったらそれは
`/dev` 側。procfs を `O_WRONLY` で open したら弾くことで機械的に守る。

### 実装方式

procfs と同じ「特別扱い」パターンで `vfs.tc` に `is_dev_path()` を
足し、`/dev/` を `devfs.tc` (新規) に振る。デバイスが数個なら if 分岐
の羅列で十分。`g_mount` テーブルによる本格的マウント機構はオーバー
キルなので作らない。

### `/dev` の住人

| ノード | 内容 |
|---|---|
| `/dev/uart` | 生の serial ストリーム (PL011 / 16550)。read/write |
| `/dev/fb` | フレームバッファ (ILI9488)。framed write (§5) |
| `/dev/kbd` | キーボード。生キーコードを read (§6) |
| `/dev/rtc` | RTC。read で現在 datetime、write でセット (§4) |

**`/dev/console` は作らない** (§7 参照)。

## 4. RTC

- 配置: `/dev/rtc` (read+write)。read で現在の datetime、write で設定。
  `/proc/uptime` (mtime hex) は free-running なので別物。RTC は
  バッテリバックの実時計で「設定できる」のが本質 → 書ける `/dev` 側。
- qemu virt は goldfish-rtc、pico2 は AON timer と実装が分かれる。

## 5. ディスプレイ (ILI9488) と `/dev/fb`

### ハード前提

- ILI9488 320×480。**SPI 経由では 3 バイト/ピクセル (18-bit) 固定** —
  シリアル接続では RGB565 16-bit フォーマットが使えない。
- フルスクリーン = 320×480×3 = 461 KB。**カーネルにピクセル
  フレームバッファは持たない** — RP2350 の SRAM は ~520 KB しかなく、
  asm_pass2 タスクが単体で ~398 KB を要求する。ILI9488 の on-chip
  **GRAM を唯一のフレームバッファ**として使う。これは一時しのぎ
  ではなく恒久アーキテクチャ (§9)。

### `/dev/fb` インターフェース: framed write()

ioctl も mmap も無いので、blit を 1 回の `write()` で表現する。
**1 blit = 1 write()** (ドライバはフレーミング状態を持たない)。

```
write(fd, [header][payload])
  header = [x:u16][y:u16][w:u16][h:u16][mode:u16]
  mode 0: 続いて w×h ピクセル (RGB565, 2 B/px)
          ドライバが各ピクセルを 18-bit に展開して SPI1 へ
  mode 1: 続いて 1 色 (RGB565 2 B) → 矩形塗りつぶし
  mode 2: 続いて [value:u16] → 垂直スクロール開始ライン設定
          (ILI9488 VSCRSADD 0x37)
```

- userspace は RGB565 (2 B/px) で扱い、18-bit 展開はドライバが flush
  時に行う。write() を渡るバイト数とタスクが確保するバッファが半減。
- mode 1 (塗りつぶし) があるので画面クリアが巨大バッファ無しで済む。

### ハードウェア垂直スクロール

ILI9488 の垂直スクロール (`VSCRDEF 0x33` で領域定義、`VSCRSADD 0x37`
で開始ライン) を使う。スクロール = 「新しい 1 行を GRAM に書く」+
「VSCRSADD を進める」だけで **O(1)**。ソフトウェア全面再 blit
(~147 ms) に対し ~1 ms。

**制約: 物理パネルを 480 軸が縦になる向きで実装する** (ポートレート)。
ハードウェア垂直スクロールは物理 480 ライン軸でしか効かず、MADCTL
回転では変わらない。6×16 フォントで 53 桁 × 30 行。

## 6. キーボード (GPIO マトリクス) と `/dev/kbd`

- GPIO マトリクスをスキャン → デバウンス → キーコード/ASCII。
- `/dev/kbd` の read は **キー無しなら `-2` (yield) を返す**こと。
  対話シェルはブロッキング read で待つので、yield しないと CPU を
  占有して他タスクを飢えさせる。UART read が既にこの挙動。
- 各デバイスは単一 reader に保つ。

## 7. コンソール: `/dev/console` は作らず userspace `/bin/console`

### 決定

カーネルにターミナルドライバ (`/dev/console`) を**置かない**。
ターミナルエミュレーション (char グリッド / フォント / カーソル /
スクロール) は userspace の `/bin/console` タスクに置く。

### 根拠

- `kputs` は既に UART に出る。UART が恒久のデバッグ/リカバリ/
  ブートログ console を務めるので、LCD をカーネル console にして
  フォールバックにする必要がない。
- GUI 世界では端末ロジックは userspace。最初から userspace に置けば
  捨て駒コードも fbcon 式の二重実装も発生しない。
- カーネルが「dumb なデバイスプリミティブ」だけになり minimalism に
  合う。

### `/bin/console` の役割 (ターミナルエミュレータ + getty)

- char グリッド (~1.6 KB) + フォント (~1.5 KB) + スクロール状態を持つ。
- `/dev/fb` + `/dev/kbd` を直接開く。スクロールは `/dev/fb` mode 2
  (ハードウェアスクロール) を使う。
- `sh` を `sys_pipe` + `sys_spawn_fds` で pipe 配線して spawn
  (既存の concurrent pipeline 機構をそのまま使う)。
- 出力経路: sh → pipe → console タスク → ターミナルエミュレーション
  → `/dev/fb`。

### init / stdio

- init / seed タスクの stdio は既定で `/dev/uart` (現状の fd 2→UART
  動作の正規化)。
- LCD コンソールが欲しいときは kern.conf で `init=/bin/console` を
  seed する。`/bin/console` が内部で自前の sh を起動する。

## 8. kern.conf

kern.conf は **seed するプログラム名を並べるだけ**。

```
# UART にシェル (既定)
init=/bin/sh

# LCD にコンソール (userspace ターミナル + 自前 sh)
init=/bin/console
```

「2 つのシェル (片方 UART・片方 LCD)」は上記 2 行を両方書くだけ。

per-init の `stdin=` / `stdout=` 設定は**不要**になった: init は UART
既定で、`/bin/console` は自分の sub-shell を pipe で内部配線する。
リダイレクトは spawn ABI と sh の `<` `>` が既に担っている。

## 9. GUI への将来展望

GUI を作る場合も**カーネル側のプランは変わらない**。

```
        /bin/console (テキスト端末)        ┐
        compositor (将来・GUI)             ┘  どちらも userspace、/dev/fb の消費者
                  ↓ 安定 seam
        /dev/fb  ← dumb な region-blit プリミティブ (カーネル)
                  ↓
        SPI1 ILI9488 GRAM
```

- `/dev/fb` を dumb な region-blit のまま死守すれば、`/bin/console`
  と将来の compositor は `/dev/fb` の上に乗る兄弟になる。
- **RAM フレームバッファは未来永劫作れない** (SRAM ~520 KB、フル
  スクリーン RGB565 = 307 KB)。GRAM が唯一にして恒久のフレーム
  バッファ。将来の GUI は double-buffered ではなく必然的に
  **dirty-rectangle / GRAM 直書きの region compositor** になる。
- §5 で設計した `/dev/fb` の blit インターフェースは、まさにその
  region-blit プリミティブそのもの。compositor がそのまま使える。
- compositor 起動時の画面所有調停は「display owner」変数 + 排他 seed
  程度で足りる (userspace 同士なので軽い)。
- compositor / display server を今作るのは時期尚早 (リッチな IPC が
  まだ無い)。ただし現プランは GUI への道を一切塞いでいない。

## 10. 作業計画

§9 までの設計を実作業に落とし込んだもの。ステップ ID は S0〜S8。
依存関係が許す範囲で S2 (RTC) を前倒しした — RTC は display/keyboard
と独立で virt 上でテストでき、`/dev` の write 経路を早期に固められる。

### 計画全体の注意点

- **テストの大半は実機限定**。`/dev` / `/dev/uart` / `/dev/rtc` は
  qemu virt でテストできる (UART、goldfish-rtc が存在) が、ILI9488 /
  GPIO マトリクスは virt に対応物が無く `make test` に載らない。
  S3 以降は実機 (`test_pico2.sh` 方式) で目視 + grep 検証する。
- **virt / pico2 のモジュール分割**: `display_ili9488.tc` /
  `keyboard_matrix.tc` は pico2 専用モジュール (`block_flash` vs
  `block_virtio` と同じ扱い)。virt ビルドには含めず、devfs 側は
  virt で `/dev/fb` `/dev/kbd` を ENODEV 相当で返す。
- カーネルモジュールが 4 本増える (`devfs` / `rtc` / `display_ili9488`
  / `keyboard_matrix`)。各々 asm_pass1 の input が 1 つ増えるだけで
  arena 影響はコード分のみ。pico2 の 4 MiB flash は `DROP_TASKS` で
  調整可能。

---

### S0. ハード設計・結線 (全ハードステップの前提)

- ピン割り当てを決める: SPI1 (SCK/MOSI/CS) + ILI9488 の D/C・RESET、
  GPIO マトリクスの行/列、RTC (AON timer or 外付け I2C)。
- 物理結線。`docs/pico2_hardware.md` に追記。
- openocd で GPIO トグル等の結線確認。
- リスク: 低 / 依存: なし

### S1. `/dev` ルーティング + `/dev/uart`

- 新規 `kernel/devfs.tc` — `procfs.tc` (~240 行) を雛形に。
- `vfs.tc` — `is_devfs_path()` 追加、`/dev/` を devfs に振る。
  `devfs_readdir` で `ls /dev` 対応。
- `devfs.tc` — `/dev/uart` の open/read/write/close を既存
  `do_uart_*` に転送。
- `kernel/build.sh` のカーネルモジュールリストに `devfs.tc` を追加。
- テスト: virt。`cat /dev/uart` / echo to `/dev/uart` / `ls /dev`。
  `test_os.sh` に 1 ケース追加。
- リスク: 低 / 依存: なし

### S2. `/dev/rtc`

- 新規 `kernel/rtc.tc` (または `devfs.tc` に内包)。
- platform 別 read: virt = goldfish-rtc (MMIO 既知アドレス)、
  pico2 = AON timer。
- `devfs.tc` — `/dev/rtc` read = datetime 整形、write = 解析して
  セット。
- テスト: virt の goldfish-rtc で read/write 検証。`/dev` の write
  経路の最初の実証も兼ねる。
- リスク: 低〜中 (datetime 整形/解析) / 依存: S1

### S3. ディスプレイドライバ + `/dev/fb` (mode 0/1)

- 新規 `kernel/display_ili9488.tc` (pico2 専用)。
- `platform_pico2.s` — SPI1 の reset 解除、SPI1 ピン funcsel、
  D/C・RESET・CS GPIO 設定。
- `display_ili9488.tc` — SPI1 init、ILI9488 power-on シーケンス
  (sleep out → pixel format 18-bit → display on)、CASET/PASET/RAMWR、
  RGB565→18bit 展開。
- `devfs.tc` — `/dev/fb` の open/write、framed header (§5) を parse
  して blit。
- bring-up 補助: `kernel/tasks/fbtest` — `/dev/fb` に矩形/グラデを
  描く目視確認タスク。
- **中間マイルストーン**: まず mode 1 (全画面塗りつぶし) で
  SPI1 + init を実証 → 次に mode 0 (ピクセル)。
- 初期は **SPI1 = 6 MHz のまま**でよい (clk_peri 据え置き、低リスク)。
  1 行 blit ~20 ms でテキストコンソールは実用範囲。高速化は S8。
- テスト: 実機のみ。fbtest 目視 + `test_pico2` 拡張。
- リスク: **最高** (HW bring-up、ILI9488 init シーケンスが繊細)
  / 依存: S0

### S4. `/dev/fb` mode 2 — ハードウェア垂直スクロール

- `display_ili9488.tc` — init で `VSCRDEF` (0x33)、mode 2 で
  `VSCRSADD` (0x37)。
- パネルはポートレート向き (480 軸 = スクロール軸) で実装する。
- テスト: 実機。fbtest にスクロールケース追加。
- リスク: 低〜中 / 依存: S3

### S5. キーボードドライバ + `/dev/kbd`

- 新規 `kernel/keyboard_matrix.tc` (pico2 専用)。
- `platform_pico2.s` — マトリクス行/列 GPIO funcsel + プルアップ。
- scan 方式: **timer trap 駆動でマトリクスをスキャン → 小リング
  バッファ**に積む。`/dev/kbd` read はバッファを drain し、空なら
  `-2` (yield) を返す。
- デバウンス、ゴースト対策 (ダイオード前提か 2-key 制限)、
  keycode → ASCII マップ。
- bring-up 補助: `kernel/tasks/kbdump` — `/dev/kbd` を読んで
  scancode を UART に出す。
- テスト: 実機。kbdump で目視。
- リスク: 中 (デバウンス・ゴースト) / 依存: S0

### S6. `/bin/console` — userspace ターミナルエミュレータ + getty

- 新規 `kernel/tasks/console/console.tc` + `task.mk`。
- フォントテーブル (6×16 ASCII、~1.5 KB)。
- char グリッド (53×30) + グリフ blit + カーソル。
- ターミナル状態機械: 印字可能文字 / `\n` / `\b` / `\r`、改行時の
  スクロールは `/dev/fb` mode 2。
- getty: `sys_pipe` ×2 + `sys_spawn_fds` で `sh` を spawn し、
  pump ループ (`/dev/kbd` → sh stdin pipe、sh stdout pipe → 端末
  描画 → `/dev/fb`)。全 fd 非ブロッキング。
- `build.sh` の GUEST_TASKS に `console` を追加。
- テスト: 実機。キーボードから操作し LCD に表示されることを確認。
- リスク: 中 (pump ループの多重 fd 制御) / 依存: S3, S4, S5

### S7. kern.conf 統合 + 仕上げ

- kern.conf で `init=/bin/console` を seed。
- 「2 つのシェル (UART + LCD)」構成 (`init=/bin/sh` +
  `init=/bin/console`) を実機検証。
- docs 更新 (roadmap フェーズ9 チェック、`pico2_hardware.md`)。
- テスト: 実機 end-to-end。
- 依存: S6, S2

### S8 (任意). clk_peri を PLL_SYS に切り替えて SPI 高速化

- `platform_pico2.s` — `clk_peri` を PLL_SYS (150 MHz) に切り替え、
  UART の IBRD/FBRD を再計算、SD の SPI divider も調整。
- SPI1 を 25 MHz 化 → 全画面 blit が 6 MHz の ~600 ms から
  ~150 ms 以下へ。
- テスト: 実機回帰 (UART・SD・display を全部)。
- リスク: 中 (UART/SD がクロックに連動) / 依存: S3
- 備考: 最適化ステップ。テキストコンソールは S3 の 6 MHz でも
  実用なので後回し可。

---

### 依存グラフ

```
S0 ─┬─→ S3 ──→ S4 ─┐
    └─→ S5 ────────┼─→ S6 ──→ S7
S1 ──→ S2 ─────────┴──────────┘
S3 ──→ S8 (任意)
```

S1+S2 (virt 完結) と S0→S3/S5 (実機) は並行して進められる。
