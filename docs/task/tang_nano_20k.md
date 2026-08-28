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
| ストレージ | microSD スロット (SPI モード可)、**SPI flash 64 Mbit = 8 MB** (bitstream 用。GW2AR-18 の bitstream は実測 ~580 KB (top_blink.fs 4.6 Mbit) なので **~7.4 MB が空く**) |
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

### 4.5 電源 (エネループ 2 本運用)

pico2 は VSYS 1.8〜5.5 V を受ける内蔵 buck-boost があるので、
エネループ 2 本 (2.4 V 公称、2.0〜2.7 V) を直結できた。Tang Nano 20K は
**USB-C の 5 V 前提** で、基板上の LDO が 3.3 V / 1.8 V (★) / 0.9 V コア
を作るだけ。2.4 V を直結しても FPGA は起動しない。

対策: **昇圧 DC-DC (2 セル → 5 V) を 1 個入れて 5 V ピン (ヘッダの
5V/VBUS) に給電する**。MT3608 系や TPS61023 モジュールで足りる。
消費は pico2 より大きい見込み (GW2AR-18 + SDRAM + 50 MHz 級 CPU で
150〜300 mA @ 5 V、LCD バックライトは両機共通で +50〜100 mA) なので、
エネループ 2000 mAh で **数時間** (pico2 の数分の一)。Phase 5 で
実測して、足りなければ (a) 未使用ブロック (HDMI/BL616) を止める、
(b) CPU クロックを落とす、(c) 3 本化 (3.6 V → 昇圧効率向上) を検討。
USB 給電と電池を同時に挿さないよう、電池側はショットキー or 排他
スイッチを入れる。

### 4.6 ライセンス方針 (外部 IP)

- 取り込むのは **permissive (ISC / MIT / BSD / Apache-2.0) のみ**。
  `hw/rtl/third_party/<name>/` に元の LICENSE ごと置き、`hw/README.md`
  に一覧を書く。**GPL/LGPL 系 (OpenCores の古い IP、ZipCPU の
  wbuart32 等) は不採用** — bitstream が派生物扱いになる余地がある。
- コア: 退避先の PicoRV32 は ISC。他候補 (SERV ISC、VexRiscv MIT、
  FemtoRV/darkriscv BSD-3、Ibex Apache-2.0) も permissive。
- 周辺は結局 **全部自作** した (SDRAM コントローラ含む)。候補だった
  nand2mario の NESTang は確認したら **GPL-3** で不採用 (2026-08-28)。
  参照したのは apicula `doc/sdram.md` のピン表と SDRAM の構成
  (2M×32、row 11 / col 8 / bank 2 bit) という事実だけ。
- **Gowin 純正 IP** (IP Generator の SDRAM / PLL / DVI_TX) は EDA の
  EULA 下で生成 RTL の再配布不可 → apicula で SDRAM が動かなかった
  ときの退避先に限定し、使う場合は生成手順だけ commit して RTL は
  gitignore。プリミティブ (`rPLL`, BSRAM, `IOBUF`) の直接
  インスタンス化はこの制約に当たらない。
- 各ライセンスは着手時にリポジトリ現物で再確認する (上記は 2026-01
  時点の知識)。

### 4.7 ツールチェーン

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

- [x] Phase 0 足場 — 2026-08-28 完了。oss-cad-suite 20260827 を
  ~/opt に導入 (yosys 0.68 / nextpnr-himbaechel 0.11 / apicula /
  openFPGALoader / iverilog / verilator、sudo 不要)、`hw/` 雛形 +
  uart_tx/rx + top_blink (LED + UART echo + S1 banner)。`make -C hw
  test` (iverilog 2 本) PASS、`make -C hw bit` → LUT4 303、実機で
  `hw/tests/test_blink.sh` PASS (JTAG 書き込み → UART echo)。
  bitstream 実測 ~580 KB。得られた知見は §9
- [x] Phase 1 RV32IM コア — 2026-08-28 完了。`rtl/cpu/rv32_core.v`
  (RV32IM + Zicsr、マルチサイクル FSM、mul/div 逐次 32 cycle、M-mode
  CSR、trap、timer irq) + `rtl/soc/soc.v` (virt 互換マップ: UART
  0x1000_0000 / CLINT 0x0200_0000 / exit 0x0010_0000 / RAM 0x8000_0000)
  + `ram32.v`。**hello2.tc (compile-gen2.sh + `hw/sw/crt0_tn20k*.s`)
  が iverilog と実機 BSRAM 32 KB の両方で "Hello, World"**、
  test_timer.tc も sim で TIMER_OK (Phase 2 の CSR / timer 割り込みは
  実質できている)。`make -C hw test` = uart / top_blink / smoke /
  hello2 / test_timer (~2 s)。LUT4 ~8000 (38%) / DFF ~2000 / Fmax
  58 MHz。副産物: dead-strip の fall-through 未対応 (`docs/problem.md`
  #46) を発見、crt0 に `j _park` で回避。
  残: riscv-tests、LUT 削減 (regfile → RAM、64-bit カウンタ縮小)
- [x] Phase 2 M + CSR + trap + CLINT — 2026-08-28 完了 (Phase 1 と
  同時)。riscv-tests rv32ui/rv32um **48/48 PASS** (`hw/tests/
  run_riscv_tests.sh`、自前 env は PASS/FAIL を exit device に書く。
  ma_data は core が仕様どおり trap するので skip)、test_timer.tc が
  sim と実機で TIMER_OK。発見したバグ: `cond ? $signed(x) >>> n : y`
  は unsigned 文脈で論理シフトになる (sra/srai が riscv-tests で発覚)
- [~] Phase 3 SDRAM + GPIO/SPI + ブート ROM — 2026-08-28: **SDRAM +
  UART ブート完了**。自作 `rtl/sdram/sdram_ctrl.v` (単一ワード ACT→
  R/W→明示 PRECHARGE、CL=2、7.8 µs リフレッシュ、27 MHz 同相) +
  `sim/sdram_model.v`、実機 `top_memtest` で 8 MB 全域エラー 0。
  A10 自動プリチャージだけでは行が切り替わらず (1024 ワードのみ
  正常) 明示 PRECHARGE で解決。soc.v に `USE_SDRAM` / ブート ROM
  (BSRAM 8 KB @ 0x0、`RESET_PC=0`) を追加、`hw/sw/bootrom/bootrom.S`
  (gcc as) が `[len][data][sum32]` を UART で受けて SDRAM へ、
  `hw/tools/uart_load.py` がホスト側。**実機 `top_soc_sdram` で
  リセット → ROM → hello2.bin 25 KB を 2.3 s でロード → SDRAM 上で
  "Hello, World"** (`hw/tests/test_soc_hw.sh`)。sim は `make -C hw boot
  BIN=…` / `test-boot`。NESTang は GPL-3 だったので不採用 (§4.6)。
  注意: ROM は受信バイトを無条件に長さヘッダとして読むので、ロード前に
  UART へ余計なバイトを送らない (uart_probe.py の "ping" で 1 回
  はまった)。残: GPIO / SPI master (Phase 5 で LCD と一緒に)、SPI
  flash ブート (Phase 5 の後)
- [ ] Phase 4 kernel 移植 → UART で sh
- [ ] Phase 5 LCD + キーボード → スタンドアロン (電池運用の消費電流実測含む)
- [ ] Phase 6 SD → コンパイラ → self-replicate
- [ ] Phase 7 性能 / タッチ / HDMI

## 9. Phase 0 で得た実機の知見

- **USB は FT2232 互換 (0403:6010、product "USB Debugger")。ttyUSB0 =
  JTAG (MPSSE)、ttyUSB1 = FPGA UART**。ttyUSB0 に書くと FTDI の
  MPSSE "bad command" 応答 `0xFA + 送ったバイト` が返ってきて echo に
  見えるので騙されないこと。
- **初回接続時に BL616 の UART ブリッジが無反応** だった (JTAG は
  動き、FPGA 設計も LED で動作確認済なのに ttyUSB1 が全ボーレートで
  沈黙)。USB の物理抜き差しで復活し、以後は openFPGALoader 直後でも
  UART が生きている。sysfs の `authorized` トグルや usb driver の
  unbind/bind ではデバイスがハングして復旧できなかった (物理抜き差し
  必須)。
- FPGA UART ピンは回路図 (v1.3) の `PIN69_SYS_TX` / `PIN70_SYS_RX` で
  確定 (apicula の例と一致)。ピン/回路図の確認は Sipeed の
  `tang_nano_20k_schematic_v1.3.pdf` を pypdf で grep するのが速い。
- udev: `/etc/udev/rules.d/99-tangnano.rules` で 0403:6010 を 0666。
  ユーザは dialout 未所属でも動く。
- nextpnr-himbaechel は `--freq 27` でクロック制約が効く (top_soc で
  "PASS at 27.00 MHz")。
- **ボタン S1/S2 はアクティブ H** (idle で L、押すと H — 回路図では
  `PIN88_MODE0_KEY1` / `PIN87_MODE1_KEY2`)。`~key[0]` をリセットに
  入れた top_soc が永久リセットになり、「CPU が動かない」と 1 時間
  迷った。SoC 内部を UART に吐くデバッグモニタ
  (`boards/tang_nano_20k/top_socdbg.v`: pc / state / instr / addr /
  UART 書き込み回数を 200 ms ごと) で CPU が走っていることを確認して
  特定。LED が見えない遠隔作業ではこの手のモニタが必須。
- yosys の Gowin BSRAM 推論: **32-bit 幅 + byte enable の 1 本のメモリ
  は壊れる** (lane 1〜3 が 0、"Range select out of bounds" 警告)。8-bit
  幅 ×4 本 (`rtl/soc/ram32.v`) なら init 込みで正しく動く
  (`top_ramtest.v` で実機 hex dump 確認)。cells_sim.v の `SP` は
  blackbox なのでゲートレベル sim では BSRAM を検証できない。
- bitstream は SRAM (`make -C hw flash`、揮発) と SPI flash
  (`flash-rom`、電源投入で自動起動) の 2 経路とも動作確認済。

## 関連

- `docs/task/pico2_port.md` — 前回のハード移植 (bring-up 手順の雛形)
- `docs/pico2_hardware.md` — LCD / キーボード / SD の配線と実測値
- `docs/task/io_devices.md`, `docs/task/lcd_pio_debug.md` — /dev/fb, /dev/kbd の設計と LCD の落とし穴
- `docs/task/kernel_platform_split.md` — platform 層の分け方
- `docs/task/pipeline_100kb.md` — コンパイラ各段のメモリ要件
- `kernel/src/trap_common.s` — CSR / trap の使い方の一次資料
- `compiler/tests/test_asm.sh` — `; raw` bin を virt で回す既存テスト
