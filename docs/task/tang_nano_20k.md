# Tang Nano 20K 上の自作 RISC-V CPU で MTOS を動かす計画

作成: 2026-08-28。状態: **計画のみ (未着手)**。

## 1. ゴール

Sipeed Tang Nano 20K (Gowin GW2AR-18) に自作の RV32IM ソフトコア + 最小
SoC を実装し、その上で本リポジトリの OS (kernel + sh + coreutils) を
起動する。最終形は **PC から独立したスタンドアロン機**: 電源を
入れると SPI flash から kernel が SDRAM に載り、pico2 と同じ
**ILI9488 LCD (320x480 SPI) + 5x12 マトリクスキーボード** を
コンソールにして `console` タスクが立ち上がる。UART は開発・
デバッグ用の副次経路に留める。その上で pico2 と同じ
**self-replicate (実機上でコンパイラ + kernel を再生成し byte-exact 一致)**
を目指すが、マイルストーンは「UART で sh プロンプト」→「LCD +
キーボードで sh」の順に置く。

「作る」のは CPU コア本体。SDRAM コントローラなど周辺は既存 IP /
Gowin プリミティブを使ってよい (自作 CPU が主題であり、周辺は手段)。

## 2. 前提: ボードの事実 (要確認は ★)

| 項目 | 値 |
|---|---|
| FPGA | GW2AR-LV18QN88C8/I7 — 20,736 LUT4 / 15,552 FF |
| BSRAM | 828 Kbit ≒ **103 KB** (18 Kbit × 46 ブロック) |
| SDRAM | 64 Mbit = **8 MB** (パッケージ内蔵、32-bit バス) |
| 発振 | 27 MHz 水晶 (PLL で逓倍可) |
| USB | BL616 が JTAG + **UART** ブリッジ (115200〜数 Mbps) |
| ストレージ | microSD スロット (SPI モード可)、**SPI flash 64 Mbit = 8 MB** (bitstream 用。GW2AR-18 の bitstream は ~0.7 MB なので **~7 MB が空く**、正確な空きは Phase 0 で実測 ★) |
| その他 | HDMI、LED×6、ボタン×2、PMOD、RGB LED |

★ は着手時に実測/データシートで確定させ、この表を更新する。

## 3. 前提: OS 側の要件 (コードから確定した事実)

CPU に要求される最小仕様は、このリポジトリの asm エンコーダ
(`compiler/src/asm_common.tc` / `asm_pass2.tc`) が出力する命令と、
`kernel/src/trap_common.s` + `kernel/platform/*/platform_*.s` が使う
CSR で決まる。

- **ISA: RV32IM**。bc2asm は `mul / mulhu / div / divu / rem / remu` を
  emit する (`compiler/src/bc2asm.tc`)。A / C / F 拡張は不使用、
  `fence` / `wfi` も不使用。
- **特権: M-mode のみ**。使う CSR は 6 本:
  `mstatus (0x300)`, `mie (0x304)`, `mtvec (0x305)`, `mscratch (0x340)`,
  `mepc (0x341)`, `mcause (0x342)`。命令は `csrrw / csrrs / csrrc /
  csrr / csrw`、`ecall`、`mret`。trap は direct mode (mtvec 下位 2 bit = 0)。
- **割り込み: タイマのみ**。`kernel/src/kernel.tc` (virt) は CLINT
  互換の `mtime` / `mtimecmp` (64-bit、10 MHz 想定でも可) を使う。
  外部割り込み / PLIC は不要 (UART はタイマ tick 内で poll)。
- **UART**: `kernel/platform/virt/platform_virt.tc` は 16550 の
  `DR (+0)` と `LSR (+5) bit0 (Data Ready)` しか触らない。TX は
  FIFO full を見ずに書く (qemu 前提) ので、実機では **TX ready bit の
  追加 + poll** が必要。
- **ブロックデバイス**: mtfs (読み取り専用、`/bin/*` 入り) と、あれば
  FAT (`/sd`)。pico2 と同じく mtfs イメージを kernel.bin に埋め込み
  (`.incbin`)、XIP 相当で `loader.tc` が直接実行する方式が最も簡単。
  virtio は使わない。
- **メモリ**: pico2 は SRAM 520 KB を kernel `__arena` 508 KB + stack
  8 KB で使い切る (`kernel/platform/pico2/crt0_pico2_data.s`)。
  コンパイラ各段の peak は最大 ~280 KB (`docs/task/pipeline_100kb.md`)。
  したがって **BSRAM 103 KB では足りず、8 MB SDRAM が主記憶**。
  kernel.bin (mtfs 込み、EXTRA 込み) は pico2 で ~3.5 MB なので
  SDRAM に丸ごと載る (XIP 不要)。
- **LCD / キーボード / SD / タッチ** (`kernel/platform/pico2/
  display_ili9488.tc`, `keyboard_matrix.tc`, `block_sd.tc`,
  `touch_xpt2046.tc`) は **全部 GPIO bit-bang** で、触るのは SIO の
  `OUT_SET / OUT_CLR / OE_SET / OE_CLR / IN` と pad の pull-up 設定
  だけ (LCD の SCK/MOSI のみ PIO で高速化)。SoC に同じ流儀の GPIO
  ブロックを置けば、レジスタ定数の差し替えで移植できる。
  pico2 の pin 割当は `docs/pico2_hardware.md`。
- **ロード方法**: pico2 は flash XIP、virt は qemu loader。tn20k では
  BSRAM 上のブート ROM が kernel.bin を SDRAM `0x8000_0000` に
  コピーして jump する。**本番は SPI flash** (スタンドアロン起動)、
  開発中は **UART** (焼かずに試す) の 2 経路を同じローダに持たせる。
  flash 8 MB − bitstream ~0.7 MB ≒ 7 MB の空きに対し kernel.bin
  (EXTRA 込み) は ~3.5 MB なので **pico2 の 4 MiB 制約より余裕がある**。
  DOOM (gcc_doom 4.5 MB) を同居させると溢れるので、その場合だけ
  DROP_TASKS か「/bin を SD から」で逃げる。

## 4. 設計方針

### 4.1 メモリマップは qemu virt を踏襲する

virt と同じアドレスに同じ種類のデバイスを置くと、**`kernel.tc` +
`platform_virt.tc` の CLINT / UART コードが無改造で動く**うえ、
Verilator シミュレーションで `virt_kernel.bin` 相当 (mtfs 埋め込み版)
をそのまま流せる。

| 領域 | アドレス | 実体 |
|---|---|---|
| Boot ROM | `0x0000_0000` | BSRAM 4〜8 KB (UART ローダ) |
| CLINT | `0x0200_0000` (`mtimecmp` +0x4000, `mtime` +0xBFF8) | 64-bit カウンタ + コンパレータ |
| UART | `0x1000_0000` | 16550 サブセット (DR / LSR + TX ready) |
| GPIO | `0x1001_0000` (新規) | SIO 風: IN / OUT / OUT_SET / OUT_CLR / OE_SET / OE_CLR / PULLUP。32 本 |
| SPI master | `0x1002_0000` (新規) | 8-bit xfer + clkdiv + CS。LCD の SCK/MOSI (pico2 で PIO の代替) と SPI flash 読み出しに使う。SD / touch は最初 GPIO bit-bang のまま |
| SDRAM | `0x8000_0000` 〜 8 MB | kernel + mtfs + arena + task |
| exit/LED | `0x0010_0000` (SiFive test 互換) | `_park` の書き込みを LED 表示に流用 |

kernel はロードアドレス `0x8000_0000`、sp 初期値は virt の
`0x8800_0000` (128 MB) から `0x8080_0000` (8 MB 末尾) に変える必要が
あるので、platform は `kernel/platform/tn20k/` として新設し、
`platform_virt.tc` の UART/CLINT 部分を import で共有する
(`docs/task/kernel_platform_split.md` の作法どおり)。

### 4.2 CPU コア

- **RV32IM、M-mode、マルチサイクル (非パイプライン) から始める**。
  1 命令 3〜5 cycle でも 27〜50 MHz なら sh 操作には十分。性能は
  Phase 6 で 5 段パイプライン + キャッシュに置き換える。
- 乗除算は逐次 (32 cycle) 実装で十分。LUT 予算 20K に対し、
  この規模のコアは 2〜4K LUT 見込み。
- 例外: ecall / illegal instruction / misaligned は `mcause` を立てて
  `mtvec` へ。misaligned アクセスは kernel_common.tc の TRAP 表示で
  デバッグできるので hard trap にする (無音で壊さない)。
- 実装言語は **Verilog-2005 (SystemVerilog の軽い機能まで)**。yosys /
  Verilator / Gowin EDA の全部で通る範囲に留める。
- 参考実装 (bring-up の比較対象・退避先): PicoRV32 (小さい、RV32IM、
  Gowin で実績)。自作コアで詰まったら PicoRV32 を同じ SoC に差して
  「バグはコアか SoC か」を切り分ける。

### 4.3 SDRAM

- 内蔵 SDRAM (16-bit、~100 MHz 級) のコントローラは自作 CPU より
  リスクが高い。Tang Nano 20K 向けの既存オープン実装を流用し、
  CPU との間には最初 **キャッシュなし + 単純な wait 制御** で繋ぐ。
  CPU クロックと SDRAM クロックを同一にすれば CDC 不要。
- Phase 3 までは BSRAM だけで動くようにし、SDRAM は差し替え可能な
  バス slave として後から追加する。

### 4.4 ピン割当 (概略、Phase 0 で確定)

Tang Nano 20K の 2 列ヘッダ (約 40 pin) に、pico2 の 2026-05-21 ボード
と同じ配線を **配線順は自由 (FPGA 側で並べ替えられる)** で繋ぐ:

| デバイス | 本数 | 備考 |
|---|---|---|
| ILI9488 | 7 (DC/CS/SCK/MOSI/MISO/RST/BL) | SCK/MOSI は SPI master、他は GPIO |
| マトリクスキーボード | 11 (row 5 + col 6) | 全部 GPIO、内部 pull-up 必要 (FPGA の pull-up 属性で代替) |
| XPT2046 タッチ | 5 | GPIO bit-bang (任意) |
| microSD | 4 | オンボードスロット (FPGA に直結、ヘッダ不要) |
| UART | 2 | BL616 経由、ヘッダ不要 |

3.3 V I/O は両者一致。LCD/キーボード基板側の配線は pico2 用のものを
そのまま使う (ケーブル差し替えで両機を行き来できるようにする)。

### 4.5 ツールチェーン

- オープン: `yosys` + `nextpnr-himbaechel` (Project Apicula、GW2A 対応)
  + `openFPGALoader`。**現在ホストには未インストール**
  (`which yosys nextpnr-himbaechel openFPGALoader` 全部空)。
- 公式: Gowin EDA (無償版で GW2AR-18 可)。apicula で GW2AR の SDRAM
  周りに問題が出たときの退避先。
- シミュレーション: **Verilator** (kernel まで回す速度が要る) +
  iverilog (小テスト)。
- RISC-V 側は既存の `riscv32-unknown-elf-gcc` / qemu を使うが、本命の
  テスト入力は本リポジトリの Gen2 コンパイラ出力 (`; raw` bin) にする。

## 5. フェーズ

各フェーズ末に commit + `docs/task/tang_nano_20k.md` の進捗欄を更新。
ハードウェア関連は新サブプロジェクト **`hw/`** に置く:

```
hw/
  rtl/         cpu/ (core), soc/ (bus, uart, clint, spi, bootrom), sdram/
  sim/         Verilator top + UART/SD モデル, tests/*.sh
  boards/tang_nano_20k/  制約 (.cst), top.v, PLL, Makefile
  tools/       bin→hex (bootrom 初期化), UART ローダ送信スクリプト
  Makefile     make -C hw {sim,test,bit,flash}
```

### Phase 0: 足場 (1〜2 日)
- ツールチェーン導入 (yosys / nextpnr-himbaechel / openFPGALoader /
  Verilator)。Gowin EDA も入手だけしておく。
- LED 点滅 + UART エコーの bitstream を焼いて、書き込み経路と
  BL616 UART (`/dev/ttyUSB*`) を確認。ボード表の ★ を埋める。
- `hw/` ディレクトリ + Makefile 雛形、Verilator でモジュール単体
  テストが回る状態。

### Phase 1: RV32I コア (BSRAM のみ、シミュレーション中心)
- fetch / decode / execute / mem / writeback のマルチサイクル FSM。
- 完了条件: `compiler/tests/hello2.tc` を `ASM_PROLOGUE='; raw'` +
  `CRT0=compiler/tests/virt_crt0.s` で compile-gen2.sh した bin が
  Verilator 上で "Hello" を UART に出す (= `compiler/tests/test_asm.sh`
  の virt 相当を hw/sim で再現)。
- 追加: riscv-tests の rv32ui を Verilator で通す (CSR 未実装分は除外)。
- 実機: 同じ bin を BSRAM 初期値として焼き、UART で確認。

### Phase 2: M 拡張 + CSR + trap + CLINT
- mul/div ユニット、上記 6 CSR、ecall / mret / illegal、CLINT タイマ割り込み。
- 完了条件: `compiler/tests/test_timer.tc` (test_asm.sh で使う CSR /
  タイマ検証) が sim + 実機で通る。riscv-tests rv32um 追加。

### Phase 3: SDRAM + GPIO/SPI + ブート ROM
- SDRAM コントローラ接続、メモリテスト (walking 1s、疑似乱数 fill)。
- GPIO ブロック + SPI master (LED / ボタンで動作確認)。
- BSRAM ブート ROM (2 経路):
  - UART: `[len][data][sum32]` フレームを受け SDRAM `0x8000_0000` に
    書いて jump。プロトコルは `mr -a` (K21) の ACK/NAK 方式を流用し、
    送信側は `integration/pico2_upload.py` を一般化する。
  - SPI flash: 固定オフセット (bitstream の後ろ) から `[len][sum32]`
    ヘッダ付き kernel.bin を SDRAM にコピーして jump。UART で数秒待って
    何も来なければ flash 起動、という優先順にする。
- 完了条件: 2 MB 級のダミーを UART / flash の両方から載せ、末尾まで
  CRC 一致。flash の実効容量を測って §2 の ★ を埋める。

### Phase 4: kernel 移植 → sh プロンプト
- `kernel/platform/tn20k/{platform_tn20k.s,platform_tn20k.tc,crt0_tn20k_data.s}`、
  `kernel/scripts/build.sh --target tn20k` (mtfs 埋め込み = pico2 経路、
  UART/CLINT = virt 経路)。`kernel/Makefile` に `tn20k` / `run-tn20k`。
- まず **Verilator 上で kernel を起動** (`KERN: starting → MTFS: mounted
  → sh spawned`)。ここが本計画の最大の検証ポイントで、実機より先に
  sim で潰す。
- 実機で sh 起動、`ls / cat /hello.txt / echo`、タイマ preempt
  (`kern_demo.conf` の A/B 可視化) が動く。`kernel/tests/test_tn20k.sh`
  を pico2 版に倣って作る (`integration/lib/pico2_hw.sh` 相当の
  `tn20k_hw.sh`)。

### Phase 5: LCD + キーボード → スタンドアロン
- `kernel/platform/tn20k/display_ili9488.tc` / `keyboard_matrix.tc`:
  pico2 版から SIO/PADS 定数を GPIO ブロックのものに差し替え、LCD の
  SCK/MOSI を PIO → SPI master に置換。`docs/problem.md` の pico2 LCD
  知見 (MADCTL、大きい fill の分割、`memory/pico2_lcd_*.md`) はそのまま
  適用。
- `make -C kernel tn20k-console-land` + flash 書き込みで、**電源投入
  だけで LCD に console + キーボード入力で sh が使える**。ここで
  「PC から独立」を達成。
- `kernel/tests/test_tn20k_hw.sh` (pico2 の `test_pico2_hw.sh` 相当)。

### Phase 6: SD カード → コンパイラ → self-replicate
- `block_sd_tn20k.tc` (最初は pico2 同様 GPIO bit-bang、遅ければ SPI
  master へ)、fatfs mount。
- `integration/test_phase7.sh` 相当 (parse → … → asm_pass3 → hello)
  を実機で完走。
- `pico2_self_replicate.sh` を一般化して tn20k で kernel.bin の
  byte-exact self-replicate。pico2 (150 MHz、~55 min) との比較で
  性能課題を洗い出す。

### Phase 7 (任意): 性能と周辺
- 5 段パイプライン化、I/D キャッシュ (BSRAM 利用)、クロック引き上げ。
- タッチ (`touch_xpt2046.tc` 移植)、HDMI 出力 (`/dev/fb` の第 2
  backend)、DOOM (gcc タスクは picolibc + RV32IM なので原理的に動く)。

## 6. テスト戦略

| 層 | 手段 |
|---|---|
| コア単体 | riscv-tests + 本リポジトリ `compiler/tests/*.tc` の `; raw` bin を Verilator で実行、UART 出力を golden 比較 |
| SoC | Verilator に UART / SD (SPI) モデルを付け、`make -C hw test` で 1 分以内 |
| kernel | Phase 4 以降、`kernel/tests/test_os.sh` の tn20k 版を sim と実機の両方で |
| 実機 | `hw/tests/*.sh`: bitstream 焼き → UART ローダで kernel 転送 → grep 検証 |

`make test` (root) には **sim テストだけ** を組み込み、1 分制約
(CLAUDE.md) を守る。実機テストは pico2 同様 opt-in。

## 7. リスクと対策

| リスク | 対策 |
|---|---|
| SDRAM コントローラが動かない / タイミング不良 | 既存実績のある実装を流用、CPU と同一クロック、Phase 3 で単体メモリテストを先に完了。詰まったら Gowin EDA + 公式 IP に切り替え |
| apicula (nextpnr) の GW2AR 対応不足 | Gowin EDA を並行で用意。RTL は両方で通る Verilog に限定 |
| 性能不足 (マルチサイクル 27 MHz で self-replicate が数時間) | Phase 4 の sh 起動を先に達成し、性能は Phase 6 で扱う。比較基準として pico2 の数値 (`docs/scaling.md`) を使う |
| UART ローダが大きい kernel.bin (3.5 MB) で遅い | 115200 bps では ~5 分。BL616 UART を 1〜3 Mbps で使う、または EXTRA を落として 1 MB 級に |
| コアのバグが kernel 起動時に初めて出る | Phase 1〜2 で riscv-tests + 自前 .tc bin を網羅。Phase 4 は必ず Verilator 先行、実機は最後 |
| SPI flash の空き (~7 MB) を DOOM 同居などで超える | 主記憶は SDRAM なので XIP 不要。DROP_TASKS で slim 化、または最小 kernel + `/bin` は SD から (mtfs を SD 上のイメージから読む) |
| GPIO bit-bang の LCD が遅い | SCK/MOSI は SPI master 化 (pico2 の PIO 相当)。CPU が遅い分は Phase 7 で回収 |

## 8. 進捗

- [ ] Phase 0 足場
- [ ] Phase 1 RV32I コア
- [ ] Phase 2 M + CSR + trap + CLINT
- [ ] Phase 3 SDRAM + GPIO/SPI + ブート ROM (UART / flash)
- [ ] Phase 4 kernel 移植 → UART で sh
- [ ] Phase 5 LCD + キーボード → スタンドアロン
- [ ] Phase 6 SD → コンパイラ → self-replicate
- [ ] Phase 7 性能 / タッチ / HDMI

## 関連

- `docs/task/pico2_port.md` — 前回のハード移植 (bring-up 手順の雛形)
- `docs/pico2_hardware.md` — LCD / キーボード / SD の配線と実測値
- `docs/task/io_devices.md`, `docs/task/lcd_pio_debug.md` — /dev/fb, /dev/kbd の設計と LCD の落とし穴
- `docs/task/kernel_platform_split.md` — platform 層の分け方
- `docs/task/pipeline_100kb.md` — コンパイラ各段のメモリ要件
- `kernel/src/trap_common.s` — CSR / trap の使い方の一次資料
- `compiler/tests/test_asm.sh` — `; raw` bin を virt で回す既存テスト
