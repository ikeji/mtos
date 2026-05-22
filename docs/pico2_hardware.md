# Raspberry Pi Pico 2 開発基板ガイド

本プロジェクトの実機ターゲットである Raspberry Pi Pico 2 の **ハード
ウェア構成と運用手順** をまとめたもの。OS / コンパイラのソフト側
移植記録は `docs/task/pico2_port.md` と
`docs/task/pico2_tc_runtime.md` を参照。

## ボード概要

| 項目 | 値 |
|---|---|
| MCU | RP2350B (Raspberry Pi 製) |
| CPU | Hazard3 RISC-V dual-core (RV32IMA + Zicsr 等)。本 OS は core0 のみ使用 |
| クロック | XOSC 12 MHz (本プロジェクトは PLL_SYS 未使用、CPU も周辺もずっと 12 MHz) |
| 内蔵 SRAM | 520 KB @ `0x20000000` (10 バンク + SCRATCH_X/Y) |
| 外付 Flash | 4 MB @ `0x10000000` (Execute-In-Place / QSPI) |
| USB | USB 2.0 FS (ブートローダ + BOOTSEL UF2) |
| 入力 | BOOTSEL ボタン |
| GPIO | 26 本 (UART/SPI/I2C/PIO 等を自由割り当て可) |
| デバッグ | 3 ピン SWD コネクタ (基板の短辺) |

ARM Cortex-M33 デュアルコアモードと RISC-V Hazard3 デュアルコアモード
の切替が可能。本プロジェクトは RISC-V モード固定 (UF2 family ID
`0xE48BFF5A`)。切替は IMAGE_DEF メタデータで指定し、Boot ROM が読み
取って起動コアを決める。

クロック構成 (2026-04-29 PLL_SYS 有効化):
- **clk_sys = 150 MHz** (XOSC 12 MHz × 125 / (5 × 2))
- **clk_peri = 12 MHz** (XOSC 直、UART/SPI baud 計算を維持)

`kernel/platform_pico2.s` の `_start` で XOSC 安定後に PLL_SYS bring-up
(REFDIV=1, FBDIV=125, POSTDIV1=5/POSTDIV2=2) → CLK_SYS の SRC を
AUX = PLL_SYS に glitchless 切替。phase 7 の compiler pipeline で
asm_pass2 単独実行が **310s → 27s (11.5×)** に短縮された。

## 必要な機材

| 用途 | 物 | 備考 |
|---|---|---|
| ターゲット | Raspberry Pi Pico 2 (RP2350B) | 量産品でよい |
| デバッガ + UART | Raspberry Pi Debug Probe | CMSIS-DAP 互換、ホストから `/dev/ttyACM0` (UART CDC-ACM) として見える |
| 配線 | Debug Probe 付属 3 ピンケーブル × 2 (SWD + UART) | JST-SH 1.0 mm 3 ピン |
| ホスト | Linux PC | macOS でも openocd-rpi が動けば可 |
| 電源 | Debug Probe 経由 USB | 本体の USB を別途繋いでもよい |

USB-シリアル変換器 + ジャンパでも代用できるが、Debug Probe を使うと
SWD と UART を 1 デバイスでまとめられる + openocd 経由で flash 書き
込みも 1 コマンドで終わるので推奨。

## ピン配線

### Pico 2 側

2026-05-21 の新基板からは UART を GP30/31 に移してある。SD/RTC/LCD/
キーボードのピンも従来の Pico 2 (A 系) 配置から大きく変わったので、
下の「GPIO 割り当て一覧」を参照。

| 機能 | Pico 2 | 備考 |
|---|---|---|
| UART0 TX | GP30 | funcsel 11 (UART0_TX) — kernel ログ出力 |
| UART0 RX | GP31 | funcsel 11 (UART0_RX) — host → kernel 入力 |
| GND | GND ピン | Debug Probe の GND と共通 |
| SWCLK | SWCLK | 短辺 3 ピンコネクタの中央 |
| SWDIO | SWDIO | 短辺 3 ピンコネクタの片端 |
| SWGND | GND | 短辺 3 ピンコネクタの逆端 |

### Debug Probe 側 (CMSIS-DAP)

| 端子 | 接続先 |
|---|---|
| `D` 列 SC (SWCLK) | Pico 2 SWCLK |
| `D` 列 SD (SWDIO) | Pico 2 SWDIO |
| `D` 列 GND | Pico 2 SWGND |
| `U` 列 TX | Pico 2 GP31 (RX) ← クロス接続 |
| `U` 列 RX | Pico 2 GP30 (TX) ← クロス接続 |
| `U` 列 GND | Pico 2 GND |

UART は **クロス接続** (TX → RX) になることに注意。Debug Probe 付属
の 3 ピンケーブルはコネクタ向きで自然にクロスする配線になっている。

### GPIO 割り当て一覧 (2026-05-21 新基板)

2026-05-21 の新基板 (48-GPIO 版 RP2350B、QFN-80) で全 48 ピンを使い
切る構成に再設計した。**SPI0 / SPI1 のハードウェア関数順と物理配線
の順序が一致しないため、SD と LCD は bit-bang SPI で駆動**する
(`kernel/block_sd.tc` と `kernel/display_ili9488.tc` 参照)。RTC は
GP32/33 に I2C0 のハードウェア関数がそのまま出ているのでハードウェア
I2C0 を使う。

| GPIO | 用途 | ブロック / 駆動 | 状態 |
|---|---|---|---|
| GP0 | — | 未使用 | — |
| GP1 | キーボード ROW1 | SIO bit-bang | 実装済 (実機未検証) |
| GP2 | キーボード ROW0 | SIO bit-bang | 実装済 (実機未検証) |
| GP3 | キーボード ROW3 | SIO bit-bang | 実装済 (実機未検証) |
| GP4 | キーボード ROW2 | SIO bit-bang | 実装済 (実機未検証) |
| GP5 | キーボード COL0 | SIO bit-bang | 実装済 (実機未検証) |
| GP6 | キーボード ROW4 | SIO bit-bang | 実装済 (実機未検証) |
| GP7 | キーボード COL2 | SIO bit-bang | 実装済 (実機未検証) |
| GP8 | キーボード COL1 | SIO bit-bang | 実装済 (実機未検証) |
| GP9 | キーボード COL4 | SIO bit-bang | 実装済 (実機未検証) |
| GP10 | キーボード COL3 | SIO bit-bang | 実装済 (実機未検証) |
| GP11 | スピーカー SPK− | PWM (差動駆動) | 結線済み (ドライバ未) |
| GP12 | キーボード COL5 | SIO bit-bang | 実装済 (実機未検証) |
| GP13 | タッチ CLK | SPI bit-bang / PIO | 結線済み (ドライバ未) |
| GP14 | スピーカー SPK+ | PWM (差動駆動) | 結線済み (ドライバ未) |
| GP15 | タッチ CS | GPIO 出力 (手動 CS) | 結線済み (ドライバ未) |
| GP16 | タッチ DO (パネル → MCU) | SPI MISO bit-bang | 結線済み (ドライバ未) |
| GP17 | タッチ DI (MCU → パネル) | SPI MOSI bit-bang | 結線済み (ドライバ未) |
| GP18 | — | 未使用 | — |
| GP19 | タッチ INT (ペンダウン) | GPIO 入力 | 結線済み (ドライバ未) |
| GP20 | AUX1 | 拡張用 | — |
| GP21 | AUX0 | 拡張用 | — |
| GP22 | AUX3 | 拡張用 | — |
| GP23 | AUX2 | 拡張用 | — |
| GP24 | AUX5 | 拡張用 | — |
| GP25 | AUX4 | 拡張用 | — |
| GP26 | AUX7 | 拡張用 | — |
| GP27 | AUX6 | 拡張用 | — |
| GP28 | AUX9 | 拡張用 | — |
| GP29 | AUX8 | 拡張用 | — |
| GP30 | UART0 TX | UART0 funcsel 11 | 実装済み |
| GP31 | UART0 RX | UART0 funcsel 11 | 実装済み |
| GP32 | RTC SDA | I2C0 SDA funcsel 3 | 実装済 (実機未検証) |
| GP33 | RTC SCL | I2C0 SCL funcsel 3 | 実装済 (実機未検証) |
| GP34 | SD MISO | SIO bit-bang | 実装済 (実機未検証) |
| GP35 | SD CS | SIO 出力 (手動 CS) | 実装済 (実機未検証) |
| GP36 | SD SCK | SIO bit-bang | 実装済 (実機未検証) |
| GP37 | SD MOSI | SIO bit-bang | 実装済 (実機未検証) |
| GP38 | LCD DC | SIO 出力 | 実装済 (実機未検証) |
| GP39 | LCD CS | SIO 出力 (手動 CS) | 実装済 (実機未検証) |
| GP40 | LCD SCK | SIO bit-bang | 実装済 (実機未検証) |
| GP41 | LCD MOSI | SIO bit-bang | 実装済 (実機未検証) |
| GP42 | LCD MISO | SIO bit-bang (未使用) | 実装済 (実機未検証) |
| GP43 | LCD RST | SIO 出力 | 実装済 (実機未検証) |
| GP44 | LCD BL (バックライト) | SIO 出力 | 実装済 (実機未検証) |
| GP45 | — | 未使用 | — |
| GP46 | — | 未使用 | — |
| GP47 | — | 未使用 | — |

- **SD カード = bit-bang SPI** (GP34-37)、**LCD = bit-bang SPI**
  (GP40-43)。RP2350 の SPI0/SPI1 funcsel 1 ピン順 (SCLK/TX/RX/SS_N)
  が基板の物理ラベル (MISO/CS/SCK/MOSI) と一致しないため、ハードウェア
  ペリフェラルを使わず SIO で軟件駆動する。SD は ~1-2 MB/s 程度、
  LCD は書き込み専用なので速度低下が体感に出にくい。
- **RTC は外付け DS3231** (GP32/33、I2C0、アドレス 0x68)。
  `kernel/rtc_ds3231.tc` が RP2350 I2C0 ハードウェアブロックで
  DS3231 の BCD カレンダーレジスタを読み書きし `/dev/rtc` を駆動する。
- **キーボードは論理 12 列 × 5 行 = 60 キー**。物理線は行 5 本 + 列 6
  本の計 11 本だけ。新基板では行/列の GPIO 番号がスクランブルされて
  いる (ROW0=GP2 / ROW1=GP1 / ROW2=GP4 / ROW3=GP3 / ROW4=GP6 と、
  COL0=GP5 / COL1=GP8 / COL2=GP7 / COL3=GP10 / COL4=GP9 / COL5=GP12)。
  ドライバ `kernel/keyboard_matrix.tc` は GP 番号を配列で持ち、マスク
  を init 時に動的に組み立てる。**左半分と右半分でダイオードの向きが
  逆**になっており、2 フェーズでスキャンする:
  - フェーズ A: 行を駆動し列を読む → 一方の半分 (例: 左 6 列) を検出。
  - フェーズ B: 列を駆動し行を読む → ダイオードが逆向きの残り半分
    (右 6 列) を検出。
- **スピーカー** は SPK−/SPK+ の差動 PWM 駆動 (GP11/14、未割当)。
- **タッチパネルは独立 SPI** (GP13/15/16/17/19、XPT2046 系想定)。
  bit-bang か PIO で駆動する。INT (GP19) はペンダウン検出。
- **AUX0–9** (GP20-29) は拡張用に引き出した未割り当てピン。
- **PSRAM** は搭載なし。
- RTC / LCD / キーボード / SD のドライバは新ピン配置で更新済だが
  **実機未検証** (SD は flash-backed MTFS まで boot 成功を 2026-05-22
  に確認)。スピーカー・タッチのドライバは未実装。

### SD カード (SPI0、実装済み 2026-04-29)

実装は `kernel/block_sd.tc` (CMD0/CMD8/ACMD41/CMD58 init + CMD17/CMD24
read/write) + `kernel/fatfs.tc` (MBR / superfloppy 対応 FAT32) で完成。
`/sd/<path>` で OS から読み書き可能。`tests/test_pico2_sd.sh` が永続性
を検証。詳細は `docs/solved.md` の K7 エントリ。

### SD カード フォーマット注意

我々の `fatfs.tc` は **FAT12/16/32 のみ**サポート。**exFAT 非対応**。

工場出荷フォーマット:
- 32 GB 以下 (SDSC/SDHC) → デフォルト FAT32 ✓ そのまま使える
- **64 GB 以上 (SDXC) → デフォルト exFAT** ✗ FAT32 にリフォーマット必要

SDXC カードを FAT32 で使う方法 (Linux):

```bash
# 1. SD カードを PC に接続 (USB SD リーダー等)
lsblk                                       # /dev/sdX を確認
# 2. パーティション 1 つ作成
sudo parted /dev/sdX --script mklabel msdos mkpart primary fat32 1MiB 100%
# 3. FAT32 でフォーマット (-F 32 を明示、Windows GUI は 32 GB 以下しか
#    FAT32 化できないが mkfs.fat にその制限はない)
sudo mkfs.fat -F 32 /dev/sdX1
sudo eject /dev/sdX
```

mac は `diskutil eraseDisk FAT32 SD MBR /dev/diskN`。

カード挿入後、kernel ブート時に `FATFS: mounted` が出れば OK。
`FATFS: mount failed (no FAT?)` が出る場合は exFAT または非標準
フォーマット。

### SD カード ピン配線

実装の詳細は `docs/task/sdcard.md`。ピン配線 (UART0 / SWD / 既存 GPIO
のいずれとも干渉しない):

| 信号 | Pico 2 GPIO | Pin | 物理位置 | SD モジュール側 | 備考 |
|---|---|---|---|---|---|
| MISO (SD → MCU) | GP4 | 6 | 左列上から 6 番目 | MISO | SPI0 RX (FUNCSEL=1) |
| CS (active low) | GP5 | 7 | 左列上から 7 番目 | CS | **GPIO 出力** で駆動 (HW CS は使わない) |
| GND | — | 8 | 左列上から 8 番目 | GND | 真ん中の GND を使うと配線が揃う |
| SCK | GP6 | 9 | 左列上から 9 番目 | SCK | SPI0 SCK (FUNCSEL=1) |
| MOSI (MCU → SD) | GP7 | 10 | 左列上から 10 番目 | MOSI | SPI0 TX (FUNCSEL=1) |
| 電源 5V | — | 40 | 右列上から 1 番目 | 5V | VBUS、USB 給電時のみ。モジュール側 LDO で 3.3 V を作る (推奨) |

#### 使用モジュール: Catalex 系 (AMS1117 LDO + 103 ×4 プルアップ + デカップリング ×4)

ピン並び `GND / 3V3 / 5V / CS / MOSI / SCK / MISO / GND` の 8 ピン
モジュール。基板上に以下が載っている:

- **AMS1117** (3.3 V LDO、入力 4.7〜15 V)
- **103 チップ抵抗 ×4** = 10 kΩ プルアップ。SD spec 通り CS / MOSI /
  SCK / MISO の 4 信号全部に入っている (= レベルシフタなしでも各
  ラインが Hi-Z 時に 3.3 V に保たれる)
- **デカップリング ×4** = AMS1117 リファレンスデザインの定番、
  入力側 (0.1 µF + 10 µF) + 出力側 (0.1 µF + 10 µF)。LDO の発振
  対策と過渡応答補強

つまり SD カードプロトコル側のプルアップは **モジュール側で完結**
していて、Pico 2 の内蔵プルアップ (PUE) は不要。ただし「念のため
GP4 (MISO) だけ PUE を有効化」しておくと、SD カード未挿入時に MISO
がフローティングになるのを防げる (障害なくフェイルしたい場合に有効)。

両端の `GND` は配線対称化のための重複なのでどちらか片方だけ繋げば
よい。

#### 電源の繋ぎ方 (2 通り)

| 方法 | モジュール側端子 | Pico 2 側 | 利点 | 欠点 |
|---|---|---|---|---|
| **(推奨) 5V → 内蔵 LDO** | `5V` | VBUS (Pin 40) | SD のピーク電流 (~250 mA) を VBUS から直接供給、Pico 2 の 3V3 LDO を圧迫しない | USB 給電が前提 (バッテリ駆動なら使えない) |
| 3.3 V 直結 | `3V3` | 3V3 OUT (Pin 36) | USB 給電不要 | Pico 2 内蔵 LDO (300 mA) と SD の突入電流が競合するおそれ |

Catalex 系はモジュール側の AMS1117 が **入力 4.7 V 以上を要求** する
仕様なので、3V3 直結の場合は LDO ドロップが効かず実質 3.3 V がスルーで
SD に印加される (基板の `3V3` ピンが LDO 出力後に直結されているため
動く)。一方 `5V` ピンは LDO の入力で、ここに 3.3 V を入れても LDO は
動かない (出力 ~2.5 V 程度に落ちる) ので **5V ピンは VBUS 専用**。

#### 配線図 (推奨: 5 V 給電)

```
Pico 2                          SD カードモジュール (Catalex 系、8 ピン)
─────────────                   ──────────────────────────────────────
Pin 40 VBUS  ─────────────────  5V        ┐
Pin 38 GND   ─────────────────  GND  ←── ┴ どちらか片方の GND だけでよい
Pin 7  GP5   ─────────────────  CS
Pin 10 GP7   ─────────────────  MOSI
Pin 9  GP6   ─────────────────  SCK
Pin 6  GP4   ─────────────────  MISO
                                3V3       ← 開放 (LDO 出力なので入力しない)
                                GND       ← どちらか片方を Pico の GND に
```

#### 信号品質・初期化に関する注意

- AMS1117 の typical dropout は ~1.1 V なので **VBUS 5 V → 3.9 V**
  くらいに落ちる。SD カードは 2.7〜3.6 V 動作なので問題なし
- SCK 周波数は最初 **100〜400 kHz** で初期化 (CMD0 / CMD8 / ACMD41 /
  CMD58)。SDHC 認識後に **12 MHz** (= 本機の最大、`clk_peri` が
  XOSC のため) まで上げる。PLL_SYS を有効化すれば 25 MHz まで上げ
  られるが現状不要
- GP5 (CS) は SPI0_CSn として FUNCSEL=1 にしてもハードウェア CS が
  自動で動くが、SD カードプロトコルでは複数バイト転送中ずっと CS=L
  を保つ必要があるため **GPIO 出力 (FUNCSEL=5 = SIO) で手動制御**
  するのが定石。これは `block_sd.tc` 側の責務
- カード抜き挿し時のホットプラグは保証されない (モジュール側に
  挿抜検出スイッチがない)。OS 側で `vfs_unmount("/sd")` してから
  抜く運用にする

## ホスト側ソフトウェア環境

### 必須

```bash
# Raspberry Pi 製 fork の openocd (RP2350 RISC-V 対応版)
~/opt/openocd-rpi/bin/openocd --version
# → Open On-Chip Debugger 0.12.0+dev-... (rp2350)

# CDC-ACM デバイス確認
ls -l /dev/ttyACM0
# → crw-rw---- 1 root dialout ...
```

`openocd-rpi` は RP2350 の RISC-V コアに対応した Raspberry Pi の
fork。upstream の OpenOCD には未マージなので必ずこの fork を使う。
ビルド方法は Raspberry Pi の公式手順を参照
(`pico-sdk` の `pico-setup` か、`build_openocd_rpi` 系のスクリプト)。

dialout グループに自分のユーザを入れておくと毎回 sudo しなくて済む:

```bash
sudo usermod -aG dialout "$USER"
# ログインし直す
```

### あると便利

- `picotool` — UF2 ↔ ELF/bin 変換、reboot コマンド等。本プロジェクト
  のスクリプトは picotool が無くても動くようフォールバックを持つ
- `python3` — `pico2_tty.py` (双方向 UART) と `uart_demux.py`
  (UART mux フレーム解析) で必須

## 起動とメモリレイアウト

### Boot ROM の流れ

1. リセット解除直後、ROM が Flash 先頭 4 KB を走査して
   `PICOBIN_BLOCK_MARKER_START` (`0xFFFFDED3`) を探す
2. IMAGE_DEF ブロックを読んで CPU アーキテクチャ (RISC-V / ARM) と
   エントリポイントを決定
3. `_start` にジャンプ。ペリフェラルはすべてリセット状態 (XOSC /
   PLL / UART / GPIO 全部 off)

本プロジェクトの IMAGE_DEF は `kernel/platform_pico2.s` 先頭で
RISC-V + EXE フラグ付きの 32 byte ブロックとして埋め込んでいる。

### XIP Flash と SRAM

```
0x10000000 ── Flash (XIP, 4 MB) ──
              IMAGE_DEF ブロック (32 B)
              kernel text + rodata
              + 埋め込み mtfs image (タスク binary 群、/etc/kern.conf 等)
                ↑ kernel/build.sh が `_mtfs_image_addr` 経由で参照
0x10400000 ── Flash 末尾

0x20000000 ── SRAM (520 KB) ──
              kernel data + bss
              + __arena .space (480 KB、kmalloc バックエンド)
              + stack (SRAM 末尾から下方向)
0x20082000 ── SRAM 末尾 (初期 SP)
```

- text と rodata は Flash の XIP で実行 (SRAM 消費ゼロ)
- data / bss / stack のみ SRAM
- kernel arena は `kernel/crt0_pico2_data.s` の `__arena .space` で
  480 KB に固定。タスクの (arena, stack) はこの中から `make_task`
  が切り出す
- 動的 spawn したタスクは一旦 SRAM に image をコピー…ではなく、
  `vfs_xip_addr` が非 0 を返す mtfs バックエンド経由なら **Flash
  上の image をそのまま entry に渡す** (XIP 直実行) ので、text は
  Flash のまま走る

詳しくは `docs/kernel.md`「メモリ配置」と
`docs/task/pico2_tc_runtime.md` を参照。

## 書き込み方法

### 方法 A: BOOTSEL UF2 (1 回限りのテスト向け)

1. Pico 2 を USB ケーブルで PC に繋ぐ前に **BOOTSEL ボタンを押下**
2. 押したまま USB 接続。`RP2350` というマスストレージとして
   マウントされる
3. `build/kernel/pico2_kernel.uf2` をドラッグ&ドロップ
4. Pico 2 が自動再起動。BOOTSEL マウントは消える

UART を別経路 (Debug Probe 等) で開いていればログが見える。

### 方法 B: openocd SWD (開発中の高速サイクル)

`make run-pico2` が一連を自動化する。内部では:

1. `make pico2-kernel` で `build/kernel/pico2_kernel.uf2` をビルド
2. UF2 → raw bin に変換 (`run_pico2_interactive.sh` 内 Python)
3. openocd で `program $BIN 0x10000000 verify` → `reset run`
4. `tests/pico2_tty.py` で `/dev/ttyACM0` に raw mode 双方向 UART
   セッションを開く (`Ctrl-a x` で終了)

```bash
# 通常版
make run-pico2

# EXTRA_TASKS (parse/sigscan/.../asm_pass3) 込みの kernel
make run-pico2-extra
```

環境変数で上書き:

```bash
OPENOCD=/path/to/openocd \
OPENOCD_SCRIPTS=/path/to/scripts \
UART_PORT=/dev/ttyACM1 \
make run-pico2
```

### 方法 C: 自前 openocd コマンド (デバッグ用)

```bash
~/opt/openocd-rpi/bin/openocd \
    -s ~/opt/openocd-rpi/share/openocd/scripts \
    -f interface/cmsis-dap.cfg \
    -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" \
    -c "init" \
    -c "reset halt" \
    -c "program kernel.bin 0x10000000 verify" \
    -c "reset run" \
    -c "exit"
```

`mdw` でメモリダンプ、`reset halt` で停止して step デバッグも可能。

```bash
# 接続テスト + SIO CPUID 表示
~/opt/openocd-rpi/bin/openocd \
    -s ~/opt/openocd-rpi/share/openocd/scripts \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "init; halt; mdw 0xd0000000 4; exit"
```

## UART アクセス

### 基本

- ボーレート: **115200 8N1**
- ホスト側デバイス: `/dev/ttyACM0` (Debug Probe の CDC-ACM)
- 物理層: PL011 UART0 (Pico 2 内蔵)、kernel 側ドライバは
  `kernel/platform_pico2.s` + `kernel/kernel_pico2.tc`

stty で raw モードに固定:

```bash
stty -F /dev/ttyACM0 115200 cs8 -cstopb -parenb raw -echo -crtscts
```

### 双方向対話

`tests/pico2_tty.py` がエスケープ ([Ctrl-a] x で終了)、LF → CR+LF
変換、select 駆動の双方向フォワーダを提供する。`make run-pico2`
が内部で呼ぶ。

```bash
python3 tests/pico2_tty.py /dev/ttyACM0 115200
```

### ワンショット送信

```bash
# 送信
printf 'catfile\n' > /dev/ttyACM0

# 受信 (タイムアウト付き)
timeout 5 cat /dev/ttyACM0
```

シェルが直接 stty を踏むと前回の echo 設定が残ることがあるので、
`tests/test_pico2.sh` のように都度 `stty raw -echo` を打ち直す。

### UART 多重化 (任意)

mux 有効時、kernel と各タスクの fd=1 を 1 ストリームに束ねる
0x1F フレーム形式で出力する (詳細: `docs/task/uart_multiplex.md`)。

```bash
# kernel 側で muxon を起動
muxon

# host 側でフレームをデコード
python3 tests/uart_demux.py < /dev/ttyACM0
```

タスクからは `mx` (length-prefix framing) と `mr` (decode) で
バイナリを安全に行き来できる。

## 実機テスト

`make test` には含まれない手動テスト:

| スクリプト | 内容 |
|---|---|
| `tests/test_pico2.sh` | flash → sh ↔ catfile / launcher / quit を UART で対話検証 (~98 秒) |
| `tests/pico2_verify.sh` | compile 7 段の中間ファイルを Gen2 ホスト参照と byte-exact 比較 (link 段は K7 で UART hang のため skip) |
| `tests/test_pico2_hw.sh` | UART pipeline driver 経由の end-to-end コンパイル |

すべて `GEN2_DIR=build/gen2 ./tests/test_pico2.sh` のように起動。
SKIP 条件: `GEN2_DIR` 未設定 / `openocd` 未存在 / `/dev/ttyACM0`
未存在 (Debug Probe を抜くと自動 SKIP)。

## トラブルシューティング

### `Verified OK` が出ない

- Debug Probe ↔ Pico 2 の SWD 結線確認 (特に GND)
- BOOTSEL 状態で USB マスストレージとして見えているなら openocd
  経由のフラッシュは失敗する。BOOTSEL を抜いて再接続
- `adapter speed` を下げる (5000 → 1000)
- openocd 自体が古い場合は upstream OpenOCD だと RP2350 RISC-V を
  認識しない。必ず `openocd-rpi` fork を使う

### `/dev/ttyACM0` が出ない

- Debug Probe の USB ケーブルを別ポートに繋ぎ替え
- `dmesg | tail` で `cdc_acm` ドライバが ttyACM0 をアタッチして
  いるか確認
- dialout グループに入っていないと open に失敗する。`groups` で
  確認

### UART に何も出ない

- 配線方向 (TX↔RX クロス) を再確認
- ボーレート不一致 (Debug Probe は 115200 固定)
- kernel が起動していない可能性。openocd で `halt` → `mdw 0x10000000`
  で IMAGE_DEF (`0xFFFFDED3` マジック) が読めるか確認
- 既に何かが走っていて UART を消費している可能性。`stty -F
  /dev/ttyACM0 -echo` で echo を切り、ブラウザの screen / minicom
  などが残っていないか確認

### 入力した文字が反応しない

- raw mode が外れている (`stty echo` になっている等)
- mux 有効時は raw bytes ではなくフレームで送る必要がある (msh /
  mx 経由か、uart_demux.py 経由)
- sh はデフォルトで echo back する。echo back が出ないなら kernel
  か sh が hang している可能性

### kernel が永久 hang

- `~/opt/openocd-rpi/bin/openocd ... -c "halt; reg pc; bt"` で停止
  位置を確認
- `[sw N>M]` などスケジューラトレースが出ているなら kernel は生き
  ている。タスクが `do_uart_read` で待ち続けているだけかもしれない
  (sh は入力待ち)

### SPI / SD などの周辺デバイスが応答しない (信号は届いてるはずなのに)

**最初に疑え: ピンヘッダのハンダ不良。** 工場直送の Pico 2 ベア
ボードはピンヘッダが付いていない。ユーザーが後付けでハンダ付け
した場合、**端の 1〜2 ピンしか付けられていない** ことがある (位置
固定のために両端から始めて、中央を忘れたケース)。

症状:
- GPIO drive lo→read=0, hi→read=1 が成立する (ピン自体は動く)
- 外部プルアップが時々見えたり見えなかったりする
- どんな信号を送っても周辺デバイスが応答しない

中央ピン (とくに **GND ピン: Pin 28 など**) のハンダを目視確認。
未ハンダなら付ける。**全ピンに均等にハンダを盛るのが基本**。

確認方法:
- テスタでピンヘッダのオス端子と Pico 2 基板上のスルーホールの
  ランド (反対側) を導通テスト → 1 Ω 未満なら OK
- `tests/pico2_tty.py` でログ眺めながら基板を軽く押すと一瞬だけ
  動く / 動かなくなるなら接触不良確定

実際にこのプロジェクトで `hardware-check/sd_probe` 開発中、Pin 28
(GP21/GP22 の間の GND) が浮いていて、SD カードへの全コマンドが
無応答になる現象が再現した。modules / cards / wiring を全部疑った
末、ハンダ修正で一発解決 (commit 8d0a47b)。

## 参考リンク

- RP2350 Datasheet: <https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf>
- Pico 2 / Pico-series Datasheet: <https://datasheets.raspberrypi.com/pico/pico-2-datasheet.pdf>
- Debug Probe: <https://www.raspberrypi.com/products/debug-probe/>
- 公式 Hazard3 仕様: <https://github.com/Wren6991/Hazard3>
- ベアメタル参考実装:
  - <https://github.com/wolfmanjm/RISC-V-RP2350-baremetal>
  - <https://github.com/igormichalak/bare-metal-rp2350>

## 関連ドキュメント

- `docs/overview.md` — プロジェクト全体像
- `docs/kernel.md` — メモリ配置・スケジューラ・VFS
- `docs/task/pico2_port.md` — Pico 2 移植プラン (PSRAM 検討等の経緯)
- `docs/task/pico2_tc_runtime.md` — text=Flash / data=SRAM 分離の
  設計、IMAGE_DEF とクロック初期化の詳細
- `docs/task/uart_multiplex.md` — 0x1F フレーム形式の仕様
