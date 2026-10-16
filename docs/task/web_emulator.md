# Web ブラウザ上で MTOS を動かす計画 (JS/TS 製 RV32IM エミュレータ)

作成: 2026-10-15。状態: **Phase 0〜5 完了 (2026-10-16)**。
`make -C web serve` → `http://localhost:8000/web/` で tn20k kernel が
xterm.js 上で sh まで起動し対話でき、SD カード (FAT32 イメージ) を
付けて `/sd` を読み書き、書き込みは IndexedDB に自動保存される。
`tn20k_kernel_extra.bin` なら 15 段のコンパイラ pipeline
(`hw.tc → Hello, World!`) が **3.4 s** で完走 (pico2 13.8 s、tn20k
実機 161 s)。**console kernel 4 種** (`tn20k_kernel_console{,_land,
_vram,_text}.bin`) は ILI9488 LCD を canvas に描き、canvas をクリック
して打鍵するとマトリクスキーボード経由で `/bin/console` の sh に届く
(実機では「配線待ち」だった LCD / キーボードドライバと vram_lcd /
text_lcd エンジンがここで先に動作確認できた)。`make -C web test`
(~17 s) で riscv-tests 49/49 + headless boot + SD 往復 + pipeline +
console 4 種 (LCD を OCR で読み戻し) + Worker コア + headless Chromium
のページ smoke test (SD 永続化 + LCD/キーボード込み) が通る。実測
**110〜120 MIPS** (Node 22 / Chromium Worker とも)。**GitHub Pages
で公開中: https://ikeji.github.io/mtos/** (`make -C web deploy-pages`、
Phase 6a)。残りは Phase 6 の wasm / wall-clock mtime / self-replicate。

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
| ブラウザ JS インタプリタ (見込み → **実測**) | 見込み 30〜80 → **実測 110〜120 MIPS** (Node 22 headless) | 見込み ~0.1 s → **実測 46 ms** | 見込み ~20 s → **実測 3.4 s** (402M 命令) | 1 時間前後 (SD が RAM なので pico2 の支配項 SD I/O は消える、CPU 律速) |
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
| 0x1004_0000 | LCD SPI | DATA / STATUS / PIX / FILL (`display_ili9488.tc`、`lcd_spi.v`)。Phase 5 (`src/lcd.js`) |
| 0x1005_0000 | vram_lcd | CTRL / BASE / DIV: enable 中は SDRAM の 480x320 RGB565 (reset BASE = 0x807A5000) を表示。Phase 5 |
| 0x1006_0000 | text_lcd | セル 1200 word + CTRL / DIV / ZBASE: 内蔵 hankaku font + SDRAM の zenkaku で描画。Phase 5 |
| 0xD000_0000 | SIO 互換 GPIO | IN / OUT_SET / OUT_CLR / OE_SET / OE_CLR (`keyboard_matrix.tc`)。Phase 5 (`src/gpio.js`) |
| 0x4002_8000 / 0x4003_A000 / 0x4003_B000 | IO_BANK0 / PADS | 書き込み無視、読み 0 |
| flash DMA / boot ROM | — | **省略**。bin を直接 RAM に置く |

Phase 1 時点では SD SPI は STATUS=idle、DATA 読みが常に 0xFF を返す
ダミーにする。これで `SD: card init failed (no card / wiring?)` を
通って `/sd` なしで起動する **はず** (未検証、§6)。

### 4.4 ページ

- xterm.js (CDN 固定バージョン or vendored) を UART に接続。
- 右に 320x480 canvas (Phase 5 から)。MADCTL の MV bit で 480x320
  に自動で向きを変える。canvas にフォーカスがあるとき keydown/keyup が
  マトリクスキーボードの scancode になる (shift 無し、小文字のみ)。
- 上に MIPS 表示、Run/Pause/Reset、kernel.bin 選択 (標準 / extra /
  console)。
- `/sd` 用 FAT イメージはファイル選択で読み込み、変更分を IndexedDB
  に保存 (Phase 4)。

## 5. フェーズ

- [x] **Phase 0 土台** (2026-10-15): `web/` + Makefile + `src/cpu.js`
  (RV32IM + Zicsr、最小ではなく全命令を最初から) + `src/soc.js` +
  `src/node_run.js` (headless ランナー、UART → stdout、`--stdin` で RX
  FIFO 事前投入、`--lenient` で unmapped MMIO を集計) +
  `tests/run_riscv_tests.sh`。`tsc` が無いので plain ES modules +
  JSDoc。`make -C web test` は root `make test` に **入れない** (Node
  依存)。
- [x] **Phase 1 CPU** (2026-10-15): riscv-tests **49/49** (`fence_i` も
  zifencei で build して含める、`ma_data` は hw と同様 skip)。初回
  実行で全通過。残: `compiler/tests/*.tc` を `; raw` + virt crt0 で
  ビルドした bin を回し qemu の出力と一致させる (test_asm.sh の
  hello2 / test_timer) — kernel が動いたので優先度低。
- [x] **Phase 2 sh 起動 (Node, headless)** (2026-10-15): lenient で
  流したら一発で `sh$`。unmapped は SD SPI 3 レジスタだけだったので
  「カード無し」スタブ (DATA 読み 0xFF、STATUS idle) を足して strict
  で起動。`SD: card init failed` 経路は続行する (§6 の懸念は解消)。
  `tests/test_boot.sh` が `hw/tests/test_kernel_hw.sh` と同じ 4
  チェック (echo / cat / ls /bin / neofetch) + `sh$` を検証。タイマ
  preempt の明示的な確認 (`count` 2 本) は未実施 (sh が spawn されて
  いるので scheduler 自体は回っている)。
- [x] **Phase 3 ブラウザ** (2026-10-15): `src/runner.js` (EmuRunner:
  環境非依存のスライス実行、yield / sleep を注入、targetMips で
  スロットル) + `src/worker.js` (MessageChannel yield の Web Worker
  glue) + `src/main.js` / `index.html` (xterm.js 5.5.0 vendored、
  kernel 選択 / file picker / Run / Pause / Reset / speed max・150・
  40・12 MIPS / MIPS・insns 表示 / unmapped MMIO 表示 / CPU error dump)。
  `window.__emu` (log / stats) はテスト用フック。Worker 内の実測は
  **~113 MIPS** (headless Chromium、Node の 120 とほぼ同じ)。テスト:
  `tests/test_runner.mjs` (Node、Worker コアを setImmediate yield で
  回しスロットル 12 MIPS の精度も確認) と `tests/test_browser.mjs`
  (playwright、npx キャッシュの chromium を使い boot / 入力 / Pause /
  Reset / xterm 描画を検証、無ければ SKIP)。学び: Node では
  MessageChannel yield がタイマを飢餓させる (ブラウザ Worker では page
  からの message と同じタスクソースなので問題なし)。
- [x] **Phase 4 SD + pipeline** (2026-10-16): pipeline は mtfs + /tmp
  だけで完結するので SD 無しで先に完走 (`tests/test_pipeline.sh`、
  3.4 s / 402M 命令。pico2 の 4×、tn20k 実機の 47× 速い)。SD は
  `src/sd.js` (SPI モード状態機械: CMD0/8/55+ACMD41/58 (SDHC 申告で
  引数 = セクタ番号)/59/17/24/25 (0xFC/0xFD トークン)、CRC 無視) を
  soc.js の SPI マスタ (0x1003_0000) に接続。FAT32 イメージは
  `tools/fatimg.py` (mkfs / add / ls / cat、mtools 不要、superfloppy
  で BPB@0 / FSInfo@1 / backup@6 / root=cluster 2 / 512 B クラスタ) と
  ブラウザ用の `src/fat32.js` (空イメージの format のみ)。
  `node_run.js --sd IMG --sd-out IMG` で headless、`tests/test_sd.sh`
  が OS で書いたファイルを fatimg.py で読み戻して検証 (12 セクタ
  書き込み)。ブラウザは SD 行 (file / New 33 MB / Download / Forget)、
  付け替えは kernel の boot 時 probe に合わせて自動 reboot、書き込み
  通知 (1 s スロットル) → 2 s 静穏後に Worker からイメージを取り
  IndexedDB に保存、次回訪問時に復元 (`tests/test_browser.mjs` で
  reload 越しの `cat /sd/p.txt` を検証)。学び: ボタン click でフォーカス
  がターミナルから外れる (全ボタンで `term.focus()` し直す)、Worker の
  `performance.now()` は 0 始まりなのでスロットルの初期値は -Infinity、
  保存完了表示は書き込み世代番号で gate しないと初期保存の遅延完了が
  「unsaved」を上書きする。
- [x] **Phase 5 LCD + キーボード** (2026-10-16): `src/lcd.js` = ILI9488
  モデル (320x480 GRAM、CASET/PASET/RAMWR、MADCTL の MV/MX/MY、
  VSCRDEF/VSCRSADD の縦スクロール、18-bit 3 byte 画素 → RGB565) を
  lcd_spi (DATA/PIX/FILL、DC は GPIO GP38) の後ろに置き、vram_lcd
  (0x1005、SDRAM の 480x320 を表示) と text_lcd (0x1006、1200 セル +
  `src/font_hankaku.js` に埋めた hankaku font ROM、zenkaku は SDRAM
  から) も `src/display.js` で合成 (優先 text > vram > spi)。
  `src/gpio.js` = SIO 互換 GPIO + 5x12 マトリクス (右半分ダイオード
  逆向き: 論理列 0〜5 は行駆動→列読み、6〜11 は列駆動→行読み) で、
  kernel の走査 (GPIO_IN 11 回 / scan) に対しキーを 22 read 保持 →
  11 read 空ける、という 1 キーずつの直列キューにした (同じ scan に 2
  キー入ると kernel は scancode 順に出す / 1 scan に収まる押下は消える
  ため、ブラウザの keydown/keyup もキューを通す)。表示は Worker が
  33 ms ごと変更時のみ RGBA を transfer、ページは `putImageData`。
  canvas (tabindex) にフォーカスで打鍵がマトリクスへ。`src/ocr.js`
  は描画結果を font で読み戻す (テスト用、`window.__emu.screenText()`
  と `node_run.js --expect-screen` / `--screen-text` / `--screen-out
  x.ppm` / `--kbd TEXT`)。`tests/test_console.sh` が 4 kernel で
  `cat /hello.txt` を打って LCD に `hello, mtfs` が出るまでを検証
  (portrait 0.6 s、landscape 2.0 s、vram 0.7 s、text 0.4 s)。学び:
  vram_lcd の BASE は RTL が reset 値 0x1E9400 (= 0x807A5000) を
  ハードコードし console は書かないので、エミュレータも同じ既定値が
  必要だった。LCD_MTIME_PER_MS = 40500 の busy-wait (init 415 ms 分 ≈
  17M 命令) は命令数 mtime でもそのまま動く。
- [x] **Phase 6a GitHub Pages 公開** (2026-10-16):
  **https://ikeji.github.io/mtos/** で動く。`make -C web dist` が
  `web/build/dist/` に index.html + src/ + vendor/ + `kernels/
  tn20k_kernel*.bin` (6 種、~17 MB) + MANIFEST.txt を集め、
  `make -C web deploy-pages` (`web/tools/pages.sh deploy`) が
  `tests/test_dist.sh` (dist を headless Chromium で smoke) を通して
  から **orphan 1 commit を `gh-pages` に force-push** する (バイナリ
  履歴を積まない)。push は `github` remote の https URL + `gh auth
  git-credential` (ssh remote は鍵 agent が要るため)。ページ側は
  `src/main.js` の `KERNEL_DIRS = ["kernels/", "../kernel/build/"]` を
  順に試すので、同じ index.html が Pages でも `make -C web serve` でも
  動く (`?kernel=name` も同じ探索、`/` 入りはそのまま)。Pages の
  source は gh-pages / root (`gh api -X POST repos/ikeji/mtos/pages`
  で設定済、gh-pages push で自動有効化された)。公開後は `make -C web
  test-pages-live` が実サイトを headless Chromium で smoke (boot 0.5〜2 s、
  Pages は .bin を gzip 配信: 2.3 MB → 365 KB)。kernel を更新したら
  `make -C kernel tn20k ...` → `make -C web deploy-pages` で再公開 (CI は組んでいない: kernel
  build に Gen1/Gen2 toolchain + qemu-riscv32 が要るため、host で
  build した bin を push する方式)。
- [ ] **Phase 6 残り (余力)**: wasm 化 (速度 2〜3x)、wall-clock 連動
  mtime、self-replicate。

## 6. リスク / 未確認

| リスク | 対処 |
|---|---|
| ~~SD ダミーで kernel が panic / ハング~~ | **解消** (Phase 2): 失敗経路は続行し `/sd` なしで sh が立つ |
| ~~UART TX ready bit~~ | **解消**: `soc.v` は LSR bit5/6 = ~tx_busy、DR 書き込みはバス stall。エミュレータは bit5/6 常時 1 + 即時送信 |
| ~~JS の速度が見込みを下回る~~ | **解消**: Node / Chromium Worker とも 110〜120 MIPS |
| ~~Worker ↔ UI の postMessage 往復~~ | **解消**: TX はスライス (~8 ms) ごとにまとめて 1 message。入力は keystroke ごと |
| 64-bit mtime / mulh の BigInt が遅い | u32 2 本で持つ。mulh は 16-bit 分割 |
| Worker ↔ UI の `postMessage` 往復 | UART 出力をバッチ (数 ms 単位) にする。入力は少量なので問題なし |
| 命令数ベース mtime だとタイマ量子が実機と変わる | kernel の quantum は mtimecmp の相対加算なので tick 周波数を実機の `MTIME` 想定に合わせれば同じ挙動。実測して調整 |
| xterm.js を CDN から読むとオフラインで動かない | vendored コピーを `web/vendor/` に置く (ライセンス MIT) |
| IndexedDB に 33 MB を 2 s ごとに丸ごと保存 (書き込み中) | 現状は静穏 2 s 待ちで十分軽い。大きいイメージ (DOOM WAD 入り等) で遅ければ dirty セクタ差分保存に変える |

## 7. 既存資産の流用

- `hw/tests/run_riscv_tests.sh`: riscv-tests のビルド手順と pass/fail
  規約 (exit デバイス)。Node ランナーはこの `.bin` を読む。
- `hw/tests/test_kernel_hw.sh`: sh 起動の期待文字列。
- `hw/rtl/soc/font_hankaku.hex`: text_lcd の font ROM。jpfont.dat の
  hankaku 部と byte 一致するので console の描画を OCR で読み戻せる。
- `hw/rtl/soc/*.v`: UART / CLINT / spi_master / lcd_spi / GPIO の
  レジスタ仕様 (これが唯一の仕様書)。
- `kernel/platform/tn20k/*.tc`: ドライバ側から見たレジスタの使い方。
- `integration/test_phase7.sh`: Phase 4 の pipeline 手順。
