# Raspberry Pi Pico 2 (RP2350) への移植

## ステータス: **hello world 完了**

`pico2/hello.tc` が `./pico2/build.sh` でビルドでき、`pico2/hello.uf2` を
BOOTSEL モードの Pico 2 に書き込むと GPIO0/1 の UART0 に
"Hello, Pico 2!\r\n" を出力する。詳細な実装経緯は
`docs/task/pico2_tc_runtime.md` 参照。

次のマイルストーン: TinyC **コンパイラ自体** を Pico 2 (SRAM 520KB
+ PSRAM 8MB) で動かす。これには 8MB PSRAM の初期化と typecheck/
asm.tc のメモリ要件解決が必要 (以下の議論を参照)。

## 背景

TinyC コンパイラが生成する RV32IM ELF を Raspberry Pi Pico 2 上でベアメタル実行する。
現在は Linux user-mode (qemu-riscv32) をターゲットとしている。

## ハードウェア

- **CPU**: Hazard3 RISC-V コア x2, 150MHz
- **ISA**: RV32IMAC（現プロジェクトは RV32IM → そのまま動く。C拡張は不使用で問題なし）
- **SRAM**: 520KB @ 0x20000000（10バンク）+ SCRATCH_X 4KB + SCRATCH_Y 4KB
- **PSRAM**: 8MB（外付け）
- **Flash**: 0x10000000〜（Pico 2 は 4MB フラッシュ搭載）
- **UART0**: GPIO0(TX), GPIO1(RX), ペリフェラル 0x40070000
- **ブート**: UF2 形式を USB 経由で書き込み。IMAGE_DEF メタデータで RISC-V モード指定

## RP2350 ハードウェア詳細

### メモリマップ

| 領域 | ベースアドレス | サイズ | 備考 |
|------|-------------|------|------|
| Flash XIP | 0x10000000 | 4MB | Execute-in-Place |
| PSRAM (QMI CS1) | 0x11000000 | 8MB | 外付け、要QMI設定 |
| SRAM (bank 0-3) | 0x20000000 | 256KB | 4x64KB, striped |
| SRAM (bank 4-7) | 0x20040000 | 256KB | 4x64KB |
| SCRATCH_X | 0x20080000 | 4KB | |
| SCRATCH_Y | 0x20081000 | 4KB | |
| SRAM 末尾 | 0x20082000 | | SP 初期値に使う |

### 主要ペリフェラルアドレス

| ペリフェラル | アドレス | 用途 |
|------------|---------|------|
| RESETS | 0x40020000 | リセット制御 |
| IO_BANK0 | 0x40028000 | GPIO 機能選択 |
| PADS_BANK0 | 0x40038000 | パッド設定 (ISO, IE 等) |
| XOSC | 0x40048000 | 12MHz 水晶発振器 |
| PLL_SYS | 0x40050000 | システム PLL |
| **UART0** | **0x40070000** | シリアル通信 |
| SIO | 0xD0000000 | CPU ID 等 |

全ペリフェラルにアトミックアクセスエイリアスあり:
- `+0x1000`: XOR, `+0x2000`: SET, `+0x3000`: CLR

### Boot ROM の挙動

- ROSC (~6.5MHz, 不正確) で起動。**XOSC/PLL は未設定**
- Flash 先頭 4KB 内の IMAGE_DEF ブロックを読んで CPU アーキテクチャを判定
- IMAGE_DEF にエントリポイントがあればそこにジャンプ
- ペリフェラルは全てリセット状態。ユーザコードが初期化する必要あり

### IMAGE_DEF ブロック (RISC-V, エントリポイント付き, 32 bytes)

```asm
.word 0xFFFFDED3          # PICOBIN_BLOCK_MARKER_START
.word 0x11010142          # IMAGE_TYPE: type=0x42, flags=0x1101
                          #   flags: bit 0=EXE, bit 8-10=RISC-V, bit 12-14=RP2350
.word 0x00000344          # ENTRY_POINT: type=0x44, size=3 words
.word _start              # エントリポイントアドレス
.word 0x20082000          # 初期スタックポインタ (SRAM 末尾)
.word 0x000004FF          # LAST item + ブロックメタデータ
.word 0x00000000          # loop link (自己参照 = 単一ブロック)
.word 0xAB123579          # PICOBIN_BLOCK_MARKER_END
```

Flash 先頭 4KB 以内に配置する必要あり。

### UF2 フォーマット

- **RP2350 RISC-V family ID: 0xE48BFF5A**
- ターゲットアドレス: 0x10000000 (Flash XIP base)
- 512B ブロック単位、データ 256B/block
- picotool で変換可能: `picotool uf2 convert input.bin output.uf2 --family rp2350-riscv --abs-block`

### RESETS レジスタ

| ビット | ペリフェラル | 用途 |
|-------|------------|------|
| 6 | IO_BANK0 | GPIO |
| 9 | PADS_BANK0 | パッド設定 |
| 14 | PLL_SYS | システム PLL |
| 26 | UART0 | シリアル |

リセット解除: `RESETS + 0x3000` (CLR エイリアス) に書き込み
完了待ち: `RESETS + 0x08` (RESET_DONE) をポーリング

### UART0 レジスタ (0x40070000)

| レジスタ | オフセット | 説明 |
|---------|---------|------|
| UARTDR | 0x00 | データ (読み書き) |
| UARTFR | 0x18 | フラグ (bit5=TXFF, bit4=RXFE) |
| UARTIBRD | 0x24 | ボーレート整数部 |
| UARTFBRD | 0x28 | ボーレート小数部 |
| UARTLCR_H | 0x2C | ライン制御 (bit6:5=WLEN, bit4=FEN) |
| UARTCR | 0x30 | 制御 (bit0=UARTEN, bit8=TXE, bit9=RXE) |

ボーレート計算: `BRD = UARTCLK / (16 * baudrate)`
- 12MHz / (16 * 115200) = 6.5104 → IBRD=6, FBRD=33
- 150MHz / (16 * 115200) = 81.38 → IBRD=81, FBRD=24

### GPIO 設定

IO_BANK0 の各 GPIO: `0x40028000 + pin * 8 + 0x04` (CTRL レジスタ)
- FUNCSEL = 2 → UART

PADS_BANK0 の各 GPIO: `0x40038000 + 0x04 + pin * 4`
- **bit 8 (ISO)**: パッド分離。RISC-V モードではデフォルト=1。**必ず CLR する**
- bit 6 (IE): 入力イネーブル。RX ピンで SET 必要
- bit 7 (OD): 出力ディスエーブル

### クロック設定

**最小構成 (XOSC のみ, 12MHz, UART に十分):**
1. XOSC 有効化: CTRL=0xAA0 (range 1-15MHz), STARTUP=0xC4, SET ENABLE
2. STATUS bit31 (STABLE) をポーリング
3. CLK_PERI_CTRL (0x40010048) = ENABLE | AUXSRC=xosc

**フル構成 (PLL, 150MHz):**
1. XOSC 有効化 (上記)
2. PLL_SYS リセット解除 (RESETS bit14)
3. FBDIV=125 → VCO=1500MHz
4. PD, VCOPD クリア → LOCK 待ち
5. POSTDIV1=5, POSTDIV2=2 → 150MHz
6. CLK_REF を XOSC に、CLK_SYS を PLL に切替

### UART0 初期化シーケンス (アセンブリ)

```asm
# 1. リセット解除 (IO_BANK0 + PADS_BANK0 + UART0)
li t0, (1<<6)|(1<<9)|(1<<26)
li t1, 0x40023000          # RESETS + CLR
sw t0, 0(t1)
# 2. RESET_DONE 待ち
li t1, 0x40020008
1: lw t2, 0(t1)
   and t2, t2, t0
   bne t2, t0, 1b

# 3. GPIO0 (TX): FUNCSEL=2 (UART)
li t0, 0x40028004          # IO_BANK0 + GPIO0_CTRL
li t1, 2
sw t1, 0(t0)
# 4. GPIO1 (RX): FUNCSEL=2
li t0, 0x4002800C          # IO_BANK0 + GPIO1_CTRL
sw t1, 0(t0)

# 5. PAD ISO クリア (GPIO0, GPIO1)
li t1, (1<<8)
li t0, 0x4003B004          # PADS_BANK0 + CLR + GPIO0
sw t1, 0(t0)
li t0, 0x4003B008          # PADS_BANK0 + CLR + GPIO1
sw t1, 0(t0)
# 6. GPIO1 入力イネーブル
li t1, (1<<6)
li t0, 0x4003A008          # PADS_BANK0 + SET + GPIO1
sw t1, 0(t0)

# 7. ボーレート設定 (12MHz → 115200bps)
li t0, 0x40070000          # UART0
li t1, 6
sw t1, 0x24(t0)            # IBRD
li t1, 33
sw t1, 0x28(t0)            # FBRD
# 8. 8N1 + FIFO
li t1, (3<<5)|(1<<4)       # WLEN=8, FEN=1
sw t1, 0x2C(t0)            # LCR_H
# 9. UART 有効化
li t1, (1<<9)|(1<<8)|(1<<0) # RXE|TXE|UARTEN
sw t1, 0x30(t0)            # CR
```

### 参考ベアメタルプロジェクト

- [wolfmanjm/RISC-V-RP2350-baremetal](https://github.com/wolfmanjm/RISC-V-RP2350-baremetal) — フル機能 (PLL, UART, GPIO, SPI, マルチコア, 割込)
- [carlosftm/Rpi-Pico2-Baremetal](https://github.com/carlosftm/Rpi-Pico2-Baremetal) — C, XOSC のみ, シンプル
- [igormichalak/bare-metal-rp2350](https://github.com/igormichalak/bare-metal-rp2350) — 純アセンブリ, PLL, Blink

## 現状との差分

| 項目 | 現在 (Linux user-mode) | Pico 2 (ベアメタル) |
|------|----------------------|-------------------|
| I/O | ecall (syscall 63/64) | UART レジスタ直接アクセス |
| 終了 | ecall (syscall 93) | 無限ループ or リセット |
| コード配置 | 0x10000 (ELF virtual) | 0x10000000 (Flash XIP) |
| データ/スタック | コード直後 (仮想メモリ) | SRAM 520KB + PSRAM 8MB |
| ヒープ | 4.4MB arena | PSRAM 活用で最大 ~8MB |
| 出力形式 | ELF32 | UF2 (or raw binary) |
| ブート | OS がロード | Boot ROM → IMAGE_DEF → ユーザコード |

## コンパイラ各ステージのメモリ要件

コードは Flash XIP 前提（コード自体は SRAM を消費しない）。
データ配列のみ SRAM/PSRAM に配置。

| ステージ | 主要配列 | データ合計 | SRAM 520KB | +PSRAM 8MB |
|----------|---------|-----------|------------|------------|
| parse.tc | tok_buf 4KB, source_reader 4KB | ~12KB | 余裕 | 余裕 |
| typecheck.tc | nodes 512KB, strtab 512KB, fntab 110KB | ~1.1MB | 不可 | 余裕 |
| codegen.tc | strtab 256KB, nodes 128KB | ~390KB | ギリギリ | 余裕 |
| bc2asm.tc | src 512KB, instrs 1MB, strtab 256KB | ~1.9MB | 不可 | 余裕 |
| asm.tc | g_lines 4MB, g_code 4MB, line_* 1MB | ~9.5MB | 不可 | 不可(※) |

### typecheck.tc のメモリ問題と対策

typecheck が厄介なのは **AST 全体（nodes 512KB + strtab 512KB）をメモリに保持** する必要があるため。
前方参照（関数Aの中で後方定義の関数Bを呼ぶ）やオーバーロード解決に全シグネチャが必要。

しかし、必要なのは **シグネチャだけ先に知ること** であり、関数本体は1つずつ処理できる。

**対策: シグネチャ事前抽出 + ストリーミング型チェック**

既存の import/.th の仕組みを自ファイルにも適用する:

```
parse foo.tc | extract-all-sigs → foo.sigs   (全 fn + 全 struct のシグネチャ)
parse foo.tc | { cat foo.sigs; cat; } | typecheck-streaming
```

1. `extract-all-sigs`: extract-sigs を拡張して export 以外の fn/struct も出力
2. typecheck-streaming: まず .sigs を読んで fntab + 型テーブルを構築、
   次に AST を関数本体ごとにストリーム処理 → 型付きAST を逐次出力

メモリ:
- fntab (~110KB) + 型テーブル + シグネチャ用 strtab → ~200KB
- 処理中の関数本体ノード → 数KB〜数十KB
- 合計: **~250KB → SRAM に収まる**

### bc2asm.tc のメモリ問題と対策

bc2asm も入力 .bc 全体 (src 512KB) + 全命令 (instrs 1MB) を一括保持している。
codegen が関数単位でストリーミング出力しているので、bc2asm も関数単位で
読み込み→変換→出力すれば src と instrs を大幅に縮小できる（数十KB で動く可能性）。

### asm.tc のメモリ問題と対策

asm.tc が突出して大きいのは **2パス設計で入力全体(g_lines 4MB)と出力全体(g_code 4MB)を同時にメモリ保持** しているため。

**対策: ファイルベース2パス + ストリーミング出力**

ファイルシステムがあれば、入力をファイルから2回読めばよい:
- パス1: ファイルから読んでラベル収集 + 総コードサイズ計算
- パス2: 同じファイルを先頭から再読込 → ELF ヘッダ出力 → 命令を逐次エンコード・出力

これで g_lines (4MB) + g_code (4MB) = **8MB が不要**になり、残るのは:
- g_line_offs/g_line_lens: 各 512KB = 1MB
- g_lab_*: ~512KB
- 合計: **~1.5MB** → SRAM 520KB には収まらないが PSRAM なら余裕

さらに g_line_offs/g_line_lens もパス2で再パースする方式にすれば ~512KB まで削減可能（SRAM のみで動く可能性）。

**対策 (推奨): アセンブラ/リンカ分離**

現在の asm.tc は全 .s を結合して一括処理するが、per-file アセンブラ + リンカに分離すれば
各段階のメモリ使用量が大幅に減る:

```
現在:  { crt0.s + runtime.s + user.s + data.s } | asm.tc → ELF (~820KB 入力)
分離:  asm.tc < runtime.s → runtime.o    (131KB 入力)
       asm.tc < parse.s   → parse.o      (590KB 入力、最大ケース)
       link.tc *.o → ELF                 (コード逐次出力)
```

per-file アセンブラのメモリ:
- 入力: 最大 590KB (parse.s)、大半は 100KB 以下
- ラベル: そのファイルのローカルラベルのみ（数百個）
- 出力: 1ファイル分のコード（~30KB エンコード後）
- 合計: **数十KB〜数百KB → SRAM のみで十分**

リンカ (link.tc) のメモリ:
- シンボルテーブル: グローバル関数名 + アドレス → 数KB
- リロケーション: 外部参照箇所のリスト → 数KB〜数十KB
- コード: .o を順番に読んで逐次出力 → バッファ不要
- 合計: **数十KB → SRAM のみで十分**

必要な追加作業:
- **.o フォーマットの設計**: コードセクション + シンボルテーブル (定義/未定義) + リロケーション
  - 簡易独自形式で十分（ELF .o は過剰）
  - 最低限: ヘッダ + コードバイト列 + シンボル一覧 + リロケーション一覧
- **asm.tc の改修**: ELF 出力を .o 出力に変更。外部シンボル参照を仮アドレスで埋めリロケーション記録
- **link.tc の新規作成**: .o ファイルを順に読み、シンボル解決 + リロケーションパッチ + ELF 出力
- **bc2asm.tc の対応**: `call func_name` 等の外部参照が正しくリロケーション可能な形式で出力されていることを確認

メリット:
- asm.tc, link.tc ともに SRAM 520KB で動作可能（PSRAM 不要）
- per-file アセンブルは並列化可能（マルチコア活用の余地）
- インクリメンタルビルドが可能（変更ファイルだけ再アセンブル）

## 実装ステップ

### Phase 1: 最小限の hello world（UART出力）

目標: Pico 2 で "Hello" を UART に出力する。

#### 1-1. ベアメタル crt0 作成

`bootstrap/crt0_pico2.s` を新規作成:

- スタックポインタ設定（SRAM 末尾: 0x20082000 付近）
- ペリフェラルリセット解除（RESETS レジスタ @ 0x40020000）
- UART0 初期化（ボーレート設定、GPIO0/1 を UART 機能に設定）
- PAD_ISO クリア（RISC-V モード固有の要件）
- `main` を呼び出し
- main 戻り後は無限ループ

注意点:
- RISC-V モードでは GPIO の PAD_ISO_REG ビットをクリアする必要あり
- IOMUX は function 5 (ARM とは異なる)
- クロック設定: Boot ROM が XOSC → PLL を設定済みかどうか要確認

#### 1-2. UART ドライバ（最小限）

`compiler/uart_pico2.tc` or アセンブリで:

```
UART0_BASE = 0x40098000
UARTDR     = UART0_BASE + 0x00   // データレジスタ
UARTFR     = UART0_BASE + 0x18   // フラグレジスタ (bit 5 = TXFF)
```

- `uart_putc(c)`: TXFF=0 を待って UARTDR に書き込み
- `uart_puts(s, len)`: putc のループ

#### 1-3. asm.tc / ELF 変更

現在の asm.tc は:
- `TEXT_BASE = 0x10054` (0x10000 + ELF header 84B)
- 1 つの PT_LOAD セグメント

Pico 2 用に変更が必要:
- **Option A**: Flash XIP — TEXT_BASE を 0x10000000 + offset に変更
- **Option B**: SRAM 実行 — コード全体を SRAM にコピー（520KB 制限）
- **Option C**: ELF ではなく raw binary 出力 → UF2 変換ツールで包む

推奨: **Option C** (raw binary + UF2 変換)
- asm.tc に `--raw` モードを追加（ELF ヘッダなしで raw 命令列を出力）
- 外部ツール (elf2uf2 or bin2uf2) で UF2 に変換
- 既存の ELF 出力はそのまま維持

#### 1-4. IMAGE_DEF メタデータ

RP2350 Boot ROM は Flash 先頭 4KB 内の IMAGE_DEF ブロックを探す。
RISC-V 実行には最低限:
- IMAGE_TYPE アイテム（architecture = RISC-V を指定）
- エントリポイント情報

pico-sdk の `image_type_item` 構造を参考に crt0_pico2.s に埋め込む。

### Phase 2: runtime.tc の移植

#### 2-1. runtime_pico2.tc 作成

現在の runtime.tc から分岐:
- `sys_write` → UART 出力に置き換え
- `sys_read` → UART 入力に置き換え（必要な場合）
- `sys_exit` → 無限ループ or LED 点滅
- `print_i32` 等の高レベル関数はそのまま使える（sys_write 経由なので）

#### 2-2. crt0_pico2_data.s（プールメタデータ）

SRAM 520KB + PSRAM 8MB を活用:
- 小バケット（16B〜4KB）は SRAM に配置（高速アクセス）
- 大バケット（8KB〜）は PSRAM に配置
- arena を PSRAM 上に確保（最大 ~7MB）
- stack は SRAM 上に 32KB〜64KB

### Phase 3: ビルドパイプライン

#### 3-1. compile-pico2.sh 作成

```bash
# .tc → raw binary → UF2
# 1. compile-gen1.sh 相当のパイプラインで .s 生成
# 2. crt0_pico2.s + runtime_pico2.s + user.s + crt0_pico2_data.s → asm.tc → raw binary
# 3. bin2uf2 で UF2 に変換
```

#### 3-2. bin2uf2 ツール

Python スクリプト or C ツールで raw binary → UF2 変換。
UF2 フォーマット:
- 512B ブロック単位
- マジックナンバー + ターゲットアドレス + データ (256B/block)
- RP2350 family ID: 0xe48bff59

### Phase 4: テスト環境

- UART シリアル (115200bps) で出力確認
- Raspberry Pi Debug Probe で UART 接続が便利
- 将来的には LED 点灯テスト（GPIO25）も有用

### Phase 5: アセンブラ/リンカ分離（Pico 2 上でコンパイラ実行用）

asm.tc を per-file アセンブラ + link.tc リンカに分離:

1. **asm.tc 改修**: 入力 .s → .o 出力（コード + シンボル + リロケーション）
   - ローカルラベル（数字ラベル、.L_*）は内部で解決
   - グローバルシンボル（関数名）は未解決のままリロケーション記録
   - 2パスは維持（ローカル前方参照の解決に必要）だが per-file なので小メモリ

2. **.o フォーマット設計**: 簡易独自形式
   ```
   header:  magic, code_size, n_syms, n_relocs
   code:    エンコード済み命令バイト列
   syms:    [ name_len, name, offset, type(定義/未定義) ] × n_syms
   relocs:  [ offset, sym_index, type(call/branch/lui+addi) ] × n_relocs
   ```

3. **link.tc 新規作成**:
   - .o ファイルを順に読み込み
   - 全シンボルのアドレス確定（コード配置順に積み上げ）
   - リロケーションパッチ（call 命令のオフセット書き換え等）
   - ELF ヘッダ + パッチ済みコードを出力

各ツールとも SRAM 520KB で動作可能。PSRAM 不要。

## 推奨開始順序

1. **まず既存のベアメタル例を動かす** — [carlosftm/RPi-Pico2-Baremetal](https://github.com/carlosftm/Rpi-Pico2-Baremetal) や [wolfmanjm/RISC-V-RP2350-baremetal](https://github.com/wolfmanjm/RISC-V-RP2350-baremetal) をクローンしてビルド・動作確認。Boot ROM の挙動とペリフェラル初期化手順を実機で把握する。

2. **手書きアセンブリで UART hello** — crt0_pico2.s を手書きして、asm.tc (or GCC) でビルドし UF2 化、実機で UART 出力確認。

3. **asm.tc に raw binary 出力** — `--raw` or `--pico2` モード追加。

4. **TinyC の hello.tc を Pico 2 で実行** — runtime_pico2.tc + compile-pico2.sh で hello.tc をコンパイルし実機実行。

5. **より複雑なプログラム** — fib.tc, fizzbuzz.tc 等を実行して安定性確認。

6. **アセンブラ/リンカ分離** — asm.tc → per-file asm + link.tc に分離。Pico 2 上でコンパイラ全体を動かすための Phase 5。

## 制約・注意事項

- **M 拡張は対応済み** — RV32IM 命令はそのまま使える。
- **C 拡張（圧縮命令）** は未使用。対応すればコードサイズ削減可能だが優先度低。
- **Flash XIP (Execute-in-Place)** を使えばコード用に 4MB Flash + データ用に SRAM+PSRAM と分離でき、メモリ効率が大幅に向上する。asm.tc の出力を Flash 配置対応させる必要あり。
- **PSRAM アクセス速度** — SRAM より遅い。頻繁にアクセスする小データは SRAM に、大配列は PSRAM に配置するのが望ましい。
- **マルチコア** — 2コアあるが当面はシングルコア使用で十分。
- **セルフホスト on Pico 2** — アセンブラ/リンカ分離(Phase 5)後、全ステージが SRAM 520KB で動作可能。ファイルシステム（Flash or SD カード）があれば中間ファイル(.ast, .bc, .s, .o)をやりとりしてフルパイプラインが動く。PSRAM は typecheck 等の大配列用に使う。
