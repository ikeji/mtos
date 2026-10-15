# Web ブラウザ上で MTOS を動かす計画 (JS/TS 製 RV32IM エミュレータ)

作成: 2026-10-15。状態: **計画のみ (未着手)**。

## 1. ゴール

ブラウザで URL を開くだけで MTOS (kernel + sh + coreutils、できれば
コンパイラ pipeline と LCD console まで) が動く静的ページを作る。
ホスト PC・実機・qemu のいずれも不要にし、「このリポジトリの OS を
触ってもらう」最短経路にする。

マイルストーン順:
1. **UART で `sh$`** (xterm.js)
2. **コンパイラ pipeline** (`tn20k-extra` kernel で `hw.tc → Hello, World!`)
3. **LCD console + マトリクスキーボード** (canvas 320x480)
4. (余力) `/sd` を FAT イメージで永続化して self-replicate

## 2. 方針: tn20k カーネルをそのまま動かす

エミュレートする対象は **Tang Nano 20K 版 (`kernel_tn20k.tc` +
`hw/` SoC)** にする。qemu virt 版でも RP2350 (pico2) 版でもない。
理由はコードから確定した次の事実:

| 項目 | tn20k (`hw/` SoC) | qemu virt | pico2 (RP2350) |
|---|---|---|---|
| CPU | RV32IM + Zicsr、M-mode のみ、CSR 6 本 | 同左 | 同左 (Hazard3) |
| RAM | SDRAM 8 MB @ 0x8000_0000 | 128 MB @ 0x8000_0000 | SRAM 520 KB @ 0x2000_0000 |
| UART | 16550 互換: `DR (+0)`, `LSR (+5) bit0` だけ (`platform_virt.tc` 共用) | 同左 | PL011 (FR/DR/IBRD/…) |
| タイマ | CLINT `mtime` / `mtimecmp` | 同左 | SIO MTIME @ 131.5 MHz |
| 終了 | `0x100000` に `0x5555` 書き込み (`_park`) | sifive_test | なし |
| ブロック | mtfs を kernel.bin に `.incbin` 同梱、XIP | **virtio-blk** (MMIO、queue、descriptor) | XIP flash @ 0x1000_0000 + UF2/IMAGE_DEF boot ROM |
| SD | SPI マスタ 1 個 (`0x1003_0000`、3 レジスタ) | FAT stub / virtio | SPI + SIO GPIO |
| LCD | `lcd_spi.v` (`0x1004_0000`、PIX/FILL) + SIO 互換 GPIO | — | PIO (FSTAT) + SIO |
| 初期化で触る周辺 | ほぼなし (`platform_tn20k.s` は mtvec と main) | ほぼなし | XOSC / PLL / CLOCKS / RESETS / PADS / IO_BANK0 / PL011 / XIP など **28 アドレス** (`platform_pico2.s`) + ステータス bit のハンドシェイク (XOSC stable, PLL lock) |

つまり tn20k 版は「UART 2 レジスタ + CLINT 2 レジスタ + 終了デバイス」
だけで `sh$` まで行ける。`tn20k_kernel.bin` は raw bin で、UART
ブートローダや SPI flash を経由せず **0x8000_0000 に置いて PC を向ける
だけ**。カーネル側は無改造。

### 2.1 RP2350 版をエミュレートするより楽か → **大幅に楽**

- pico2 kernel は boot 直後に XOSC / PLL / CLOCKS / RESETS / PADS /
  IO_BANK0 / PL011 の 28 アドレスを叩き、ステータス bit (XOSC stable、
  PLL lock、reset done) を poll する。全部に「それらしい応答」を書く
  必要があり、1 つでも違うと boot asm の中で無言ハングする。
- UF2 → flash 配置と RP2350 boot ROM の IMAGE_DEF 解釈、XIP 窓、
  SIO MTIME、PIO (LCD の FSTAT) も要る。
- 既存のオープンな RP2350 エミュレータは無い (rp2040js は RP2040 ARM
  のみ、Wokwi はクローズド)。
- 対する tn20k SoC は自分で作ったもので、`hw/rtl/soc/` の Verilog が
  仕様書そのもの。LCD/SD/GPIO もレジスタ数本ずつ。riscv-tests 一式
  (`hw/tests/run_riscv_tests.sh`、48 本) もそのまま CPU テストに流用できる。

### 2.2 代替案と見送る理由

| 案 | 見送る理由 |
|---|---|
| qemu を wasm 化 (qemu-wasm) | virt kernel が無改造で動くが数十 MB、起動が重い。virtio-blk 込みで依存が大きい |
| TinyEMU (Bellard) の JS 版 | virtio-console 前提で 16550 がなく、カーネルの UART 側を直す必要 |
| iverilog / Verilator → wasm | RTL シミュレーションは命令インタプリタの ~1000 倍遅い。sh 起動が分単位 |
| v86 系 | x86 |

## 3. 速度の見込み

実測の基準値 (すべて `docs/task/tang_nano_20k.md` / `docs/scaling.md`):

| 環境 | 実効速度 | `KERN: starting → sh` | `hw.tc → Hello` 15 段 | self-replicate |
|---|---|---|---|---|
| pico2 (Hazard3 150 MHz ~1 CPI) | ~150 MIPS | 61 ms | 13.8 s | ~55 min (SD 書き込み律速) |
| tn20k (自作コア 40.5 MHz、マルチサイクル ~5 CPI、I$ 込み ~1.9x) | **~10〜15 MIPS** | 0.48 s | 161 s | 数時間 (未実施) |
| ブラウザ JS インタプリタ (見込み) | **30〜80 MIPS** | **~0.05〜0.15 s** | **~25〜60 s** | 1 時間前後 (SD が RAM なので pico2 の支配項 SD I/O は消える、CPU 律速) |
| 同 wasm 版 (Rust/C → wasm、将来) | 100〜200 MIPS | — | ~10〜20 s | — |

根拠:
- V8 上の素朴な RV32 インタプリタ (typed array + `switch` デコード、
  BigInt 不使用) は、公開されている JS 製 rv32 エミュレータの実績から
  30〜80 MIPS が相場。メモリ 8 MB は `Uint8Array` 1 本 + `DataView`
  ではなく `Int32Array` エイリアスでワードアクセスを速くする。
- tn20k 比で **3〜8 倍速**、pico2 比で **0.2〜0.5 倍**。sh 起動は
  体感ゼロ、pipeline は「待てば終わる」範囲。
- 不確定要素: (1) `mul/div` を `Math.imul` と `/` で書けるか (`mulh*` は
  32-bit 分割か BigInt)、(2) 64-bit `mtime` を u32 2 本で持つこと、
  (3) UI スレッドと分けるための Web Worker 化で UART 転送の
  `postMessage` 往復が遅くないか。

LCD: `lcd_spi.v` の PIX/FILL レジスタはピクセル単位で canvas の
`ImageData` に書くだけなので、実機の SPI 律速 (全画面 0.2 s) より
速い。console の chrome 描画 (実機 ~7 s、CPU 律速) は ~1〜2 s に。

## 4. 設計

### 4.1 配置

新サブプロジェクト `web/` (4 つ目)。ビルド不要の静的ファイル構成を
優先し、TypeScript は使うなら `tsc` 一発で ES modules を吐く程度に
留める (bundler なし)。

```
web/
  src/
    cpu.ts        RV32IM + Zicsr + trap (ecall / mret / タイマ割り込み)
    soc.ts        バスデコード、RAM、UART 16550、CLINT、exit、SPI (SD/LCD)、GPIO
    sd.ts         SD カード SPI モード状態機械 (CMD0/8/55/41/58/17/18/24/25)
    lcd.ts        lcd_spi.v 互換 (PIX / FILL) → ImageData
    kbd.ts        5x12 マトリクス (SIO 互換 GPIO) ← keydown/keyup
    worker.ts     Web Worker: run loop、UART ↔ postMessage
    main.ts       ページ: xterm.js、canvas、kernel.bin fetch、MIPS 表示
  index.html
  tests/
    run_riscv_tests.sh   hw/tests の .bin を Node で実行し 48/48 を確認
    test_boot.sh         Node で tn20k_kernel.bin を起動し "sh$" を grep
  Makefile      build (tsc) / test / serve (python -m http.server)
```

kernel.bin は `make -C kernel tn20k` の成果物 (`kernel/build/
tn20k_kernel.bin` ~2.3 MB、extra ~4.6 MB) を `web/` にコピーするか
fetch で `../kernel/build/` を読む。リポジトリにはコミットしない
(GitHub Pages 等に出すときは CI でビルド)。

### 4.2 CPU

- デコードは `switch (opcode)` → funct3/funct7。RV32IM の全命令 +
  `csrrw/csrrs/csrrc(+i)`, `ecall`, `mret`。`fence`/`wfi`/A/C/F は
  不要 (`docs/task/tang_nano_20k.md` §3)。未知命令は illegal trap
  (mcause=2) ではなくエミュレータ停止 + ダンプ (デバッグ優先)。
- CSR: mstatus (MIE/MPIE)、mie (MTIE)、mtvec (direct)、mscratch、
  mepc、mcause。それ以外は読み 0・書き無視。
- 割り込み: 各命令後に `mtime >= mtimecmp && MTIE && MIE` を判定。
  `mtime` は **命令数ベース** (N 命令 = 1 tick、qemu の icount 相当)
  にして決定的にする。wall clock 連動は後回し (tests が安定する)。
- 実行ループは「`run(n)` で n 命令回して戻る」形にし、Worker が
  `setTimeout(0)`/`MessageChannel` で刻む。

### 4.3 SoC (hw/rtl/soc を鏡写し)

| アドレス | デバイス | 必要な挙動 |
|---|---|---|
| 0x8000_0000 + 8 MB | SDRAM | `Uint8Array` / `Int32Array` エイリアス |
| 0x1000_0000 | UART 16550 | `+0` DR: write → term、read → RX キュー pop。`+5` LSR: bit0 = RX あり、bit5/6 = 常に 1 |
| 0x0200_0000 | CLINT | `0xBFF8` mtime lo/hi、`0x4000` mtimecmp lo/hi |
| 0x0010_0000 | exit | `0x5555` で halt、他は fail 表示 |
| 0x1003_0000 | SD SPI | DATA / STATUS / CTRL (`block_sd.tc`)。Phase 4 |
| 0x1004_0000 | LCD SPI | DATA / STATUS / PIX / FILL (`display_ili9488.tc`、`lcd_spi.v`)。Phase 5 |
| 0xD000_0000 | SIO 互換 GPIO | IN / OUT_SET / OUT_CLR / OE_SET / OE_CLR (`keyboard_matrix.tc`)。Phase 5 |
| 0x4002_8000 / 0x4003_A000 / 0x4003_B000 | IO_BANK0 / PADS | 書き込み無視、読み 0 |
| flash DMA / boot ROM | — | **省略**。bin を直接 RAM に置く |

Phase 1 時点では SD SPI は STATUS=idle、DATA 読みが常に 0xFF を返す
ダミーにする。これで `SD: card init failed (no card / wiring?)` を
通って `/sd` なしで起動する **はず** (未検証、§6)。

### 4.4 ページ

- xterm.js (CDN 固定バージョン or vendored) を UART に接続。
- 右に 320x480 canvas (Phase 5 から)。
- 上に MIPS 表示、Run/Pause/Reset、kernel.bin 選択 (標準 / extra /
  console)。
- `/sd` 用 FAT イメージはファイル選択で読み込み、変更分を IndexedDB
  に保存 (Phase 4)。

## 5. フェーズ

- [ ] **Phase 0 土台**: `web/` + Makefile + Node で動く最小 CPU
  (`addi`/`lui`/`sw` と exit デバイスだけ) + `hw/tests` の riscv-tests
  `.bin` を読む Node ランナー。`make -C web test` を root `make test`
  には **入れない** (Node 依存、1 分枠を守る)。
- [ ] **Phase 1 CPU 完成**: riscv-tests 48/48 (`fence_i` は hw と
  同様 skip 可)。さらに `compiler/tests/*.tc` を `; raw` + virt crt0
  でビルドした bin を回し、qemu の出力と一致させる (test_asm.sh の
  hello2 / test_timer が CSR + タイマの検証になる)。
- [ ] **Phase 2 sh 起動 (Node, headless)**: `tn20k_kernel.bin` を
  0x8000_0000 に置き、UART に `KERN: starting ... sh$` が出る。
  `ls / cat /hello.txt / echo` と、`count` 2 本でタイマ preempt を
  確認 (`hw/tests/test_kernel_hw.sh` と同じ期待値)。
- [ ] **Phase 3 ブラウザ**: Worker + xterm.js。sh と対話できる。MIPS
  を表示し §3 の見込みを実測で置き換える。
- [ ] **Phase 4 SD + pipeline**: SD SPI 状態機械 + FAT イメージ。
  `tn20k-extra` kernel で `integration/test_phase7.sh` 相当の 15 段を
  流し `/tmp/hw` → "Hello, World!"。時間を §3 に記録。
- [ ] **Phase 5 LCD + キーボード**: `lcd_spi.v` 互換 + GPIO マトリクス
  → `tn20k-console-*` kernel で `console` が canvas に出る。tn20k の
  「配線待ち」の LCD/キーボードドライバをここで先に動作確認できる。
- [ ] **Phase 6 (余力)**: wasm 化 (速度 2〜3x)、wall-clock 連動
  mtime、GitHub Pages 公開、self-replicate。

## 6. リスク / 未確認

| リスク | 対処 |
|---|---|
| SD ダミーで kernel が panic / ハング (`kernel_tn20k.tc:280` の失敗経路が本当に続行するか未検証) | Phase 2 の最初に確認。駄目なら SD SPI 状態機械を Phase 2 に前倒し |
| UART TX ready bit: tn20k 実機で「TX ready 追加 + poll」が必要だった経緯 (`tang_nano_20k.md` §3)。現在のドライバがどの bit を見るか | `platform_virt.tc` は LSR bit0 のみ。tn20k 固有の poll があれば `hw/rtl/soc/uart.v` を見て同じ bit を立てる |
| JS の速度が見込みを下回る (10 MIPS 台) | ホットパス (load/store のアドレス変換、デコード) を先に計測。wasm 化を Phase 6 から前倒し |
| 64-bit mtime / mulh の BigInt が遅い | u32 2 本で持つ。mulh は 16-bit 分割 |
| Worker ↔ UI の `postMessage` 往復 | UART 出力をバッチ (数 ms 単位) にする。入力は少量なので問題なし |
| 命令数ベース mtime だとタイマ量子が実機と変わる | kernel の quantum は mtimecmp の相対加算なので tick 周波数を実機の `MTIME` 想定に合わせれば同じ挙動。実測して調整 |
| xterm.js を CDN から読むとオフラインで動かない | vendored コピーを `web/vendor/` に置く (ライセンス MIT) |

## 7. 既存資産の流用

- `hw/tests/run_riscv_tests.sh`: riscv-tests のビルド手順と pass/fail
  規約 (exit デバイス)。Node ランナーはこの `.bin` を読む。
- `hw/tests/test_kernel_hw.sh`: sh 起動の期待文字列。
- `hw/rtl/soc/*.v`: UART / CLINT / spi_master / lcd_spi / GPIO の
  レジスタ仕様 (これが唯一の仕様書)。
- `kernel/platform/tn20k/*.tc`: ドライバ側から見たレジスタの使い方。
- `integration/test_phase7.sh`: Phase 4 の pipeline 手順。
