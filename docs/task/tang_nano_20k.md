# Tang Nano 20K 上の自作 RISC-V CPU で MTOS を動かす計画

作成: 2026-08-28。状態: **計画のみ (未着手)**。

## 1. ゴール

Sipeed Tang Nano 20K (Gowin GW2AR-18) に自作の RV32IM ソフトコア + 最小
SoC を実装し、その上で本リポジトリの OS (kernel + sh + coreutils) を
UART コンソール付きで起動する。最終目標は pico2 と同じ
**self-replicate (実機上でコンパイラ + kernel を再生成し byte-exact 一致)**
だが、マイルストーンは「sh プロンプトが出る」を第一に置く。

「作る」のは CPU コア本体。SDRAM コントローラなど周辺は既存 IP /
Gowin プリミティブを使ってよい (自作 CPU が主題であり、周辺は手段)。

## 2. 前提: ボードの事実 (要確認は ★)

| 項目 | 値 |
|---|---|
| FPGA | GW2AR-LV18QN88C8/I7 — 20,736 LUT4 / 15,552 FF |
| BSRAM | 828 Kbit ≒ **103 KB** (18 Kbit × 46 ブロック) |
| SDRAM | 64 Mbit = **8 MB** (パッケージ内蔵、16-bit バス) |
| 発振 | 27 MHz 水晶 (PLL で逓倍可) |
| USB | BL616 が JTAG + **UART** ブリッジ (115200〜数 Mbps) |
| ストレージ | microSD スロット (SPI モード可)、SPI flash ★容量 (bitstream 用、ユーザ領域の空きは要計測) |
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
- **ロード方法**: pico2 は flash XIP、virt は qemu loader。tn20k では
  「BSRAM 上のブート ROM が UART (または SD) から kernel.bin を SDRAM
  に流し込む」方式を採る (SPI flash から読む案は容量確定後)。

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
| SPI (SD) | `0x1001_0000` (新規) | 単純 SPI master (CS / 8-bit xfer / clkdiv) |
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

### 4.4 ツールチェーン

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

### Phase 3: SDRAM + ブート ROM
- SDRAM コントローラ接続、メモリテスト (walking 1s、疑似乱数 fill)。
- BSRAM ブート ROM: UART から `[len][data][sum32]` フレームを受け
  SDRAM `0x8000_0000` に書いて jump。プロトコルは `mr -a` (K21) の
  ACK/NAK 方式を流用し、送信側は `integration/pico2_upload.py` を
  一般化する。
- 完了条件: 2 MB 級のダミーを UART 経由で載せ、末尾まで CRC 一致。

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

### Phase 5: SD カード → コンパイラ → self-replicate
- SPI master MMIO + `block_sd.tc` の SPI 層を差し替えた
  `block_sd_tn20k.tc`、fatfs mount。
- `integration/test_phase7.sh` 相当 (parse → … → asm_pass3 → hello)
  を実機で完走。
- `pico2_self_replicate.sh` を一般化して tn20k で kernel.bin の
  byte-exact self-replicate。pico2 (150 MHz、~55 min) との比較で
  性能課題を洗い出す。

### Phase 6 (任意): 性能と周辺
- 5 段パイプライン化、I/D キャッシュ (BSRAM 利用)、クロック引き上げ。
- HDMI テキストコンソール (`/dev/fb` の tn20k backend)、キーボード
  (PS/2 on PMOD)。既存の `console` タスクが動く。

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
| 4 MiB 制約の再来 (flash) | 主記憶は SDRAM 8 MB、flash は使わない設計にしたので該当なし |

## 8. 進捗

- [ ] Phase 0 足場
- [ ] Phase 1 RV32I コア
- [ ] Phase 2 M + CSR + trap + CLINT
- [ ] Phase 3 SDRAM + ブート ROM
- [ ] Phase 4 kernel 移植 → sh
- [ ] Phase 5 SD → コンパイラ → self-replicate
- [ ] Phase 6 性能 / HDMI

## 関連

- `docs/task/pico2_port.md` — 前回のハード移植 (bring-up 手順の雛形)
- `docs/task/kernel_platform_split.md` — platform 層の分け方
- `docs/task/pipeline_100kb.md` — コンパイラ各段のメモリ要件
- `kernel/src/trap_common.s` — CSR / trap の使い方の一次資料
- `compiler/tests/test_asm.sh` — `; raw` bin を virt で回す既存テスト
