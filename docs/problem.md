# 処理系の既知の問題

このプロジェクトの TC コンパイラ・ツールチェーンで見つかっているが
まだ直していない / 設計判断で後回しにしている問題のリスト。

凡例:
- **bug**: 明確な不具合。正しい挙動に直す必要あり。
- **limitation**: 言語 / ツールの設計上の制限。ワークアラウンドあり。
- **ergonomics**: 動作は正しいが書きにくい / デバッグしにくい。
- **後回し / 残件**: 設計 / 実装方針は決まっているが優先度で後回しにしている項目。

**意図的に残している挙動** (「バグでは?」と誤解されがちなもの) は
`docs/design_decisions.md` に集約。直す前にそちらを読む。

解決済みの問題は `docs/solved.md` を参照。

---

## 後回し

### K22 残件: DOOM autostart E1M1 が zone 不足 (limitation、2026-06-18)

`gcc_doom_pico2` は title screen (TITLEPIC) までは描画できているが、
`-warp 1 1` を渡して autostart させると `P_SetupLevel` の中で
~17 KB の blockmap (PU_STATIC) + ~7 KB の PU_LEVEL 群を要求し、
次の 1892-byte alloc で `Z_Malloc: failed` する。zone は 112 KiB しか
無く、`R_Init` の PU_STATIC residue (~30 KB) + その他の init で半分
以上が埋まっているため、新規 map がフラットに入らない。

対策候補 (どれも非自明):
- blockmap など PU_LEVEL の大物を `__gcc_sram` の .bss に固定
  (E1M1 専用サイズで pre-allocate)。`p_setup.c` 改修
- zone を 112 → 160+ KiB に拡張。`__gcc_sram` 内訳の見直し
  (DG_ScreenBuffer 64 KB をどう削るか) と、`__arena` をさらに削って
  zone に回すか
- rp2040-doom 流に renderer + level loader を WHD 風に書き換える
  本格 port (元々の K22 plan)。`docs/task/doom_port.md`

現状はタイトル画面で停止していて遊べないが、Phase 6 の目的
(DG_DrawFrame end-to-end + LCD 描画) は達成済み。

参考: `docs/solved.md` K22、`userland/gcc-bin/gcc_doom/`。

### 38. ILI9488 SPI で 12-bit / 3-bit pixel format が動かない (limitation、2026-05-24)

データシート 5.2.34 (Interface Pixel Format) では DBI[2:0] = 001
(3 bpp / 8 color) と 011 (12 bpp / RGB444) が定義されているが、
この基板の ILI9488 は両モードでフリーズ → reset 後砂嵐になる。

試行内容:
- `lcd_cmd(0x3A); lcd_dat(0x33)` (12-bit RGB444、2 px/3 byte 詰め): フリーズ
- `lcd_cmd(0x3A); lcd_dat(0x11)` (3-bit 8-color、8 px/3 byte 詰め): フリーズ

3-bit モードが動けば SPI 帯域 8× 削減 (460 KB → 58 KB / 全画面) で
スクロールが体感劇的に速くなるはずだった。

原因: ILI9488 を名乗る互換 IC はオリジナル ITM/Sitronix の機能を全部
実装していないことが多く、SPI 経由では事実上 18-bit (0x66) のみ。
データシートと挙動が乖離している典型例。

回避策: 18-bit で運用継続。bit-bang 約 1 MHz 実効、scroll は diff
redraw でカバー (#37 PIO 化が動けば 5-10× 高速化見込み)。

未確認: 16-bit (0x55) は試していない。多くの ILI9488 互換が 16-bit
を受けるので 33% SPI 削減できる可能性あり。やってみるなら次回。

### 37. PIO2 で LCD SPI を駆動できない (bug、2026-05-24)

`kernel/platform/pico2/display_ili9488.tc` の SCK (GP40) / MOSI (GP41) bit-bang を
PIO2 SM0 にオフロードする実装を入れたが、LCD に画像が出ない (画面
真っ白)。`g_lcd_use_pio` フラグで切替可、デフォルトは 0 (bit-bang) で
退避。実装は in-tree に残してある。

PIO 側で確認できたこと (`/tmp/pio_*.sh` の GDB probe より):

- PIO2 は RESETS から開放できる (RESETS_RESET[13] clear → RESET_DONE[13])
- SM0 起動できる、CTRL = 1 が読み戻せる
- INSTR_MEM は write-only (読むと 0)。SM0_INSTR (現在 PC の命令) は
  0x6001 で我々の OUT 命令を実行中なのは確認できる
- TX FIFO に push したバイトは drain される (FSTAT.TXEMPTY が立つ)
- `SET PINS 1` を SM0_INSTR 経由で実行すると DBG_PADOUT bit 25 が
  立つ — PIO の中で MOSI は driven high
- だが GP41 STATUS register (= 0x40028148) は **全 0** で何も pad に
  届いていない。OUTFROMPERI / OEFROMPERI とも 0

つまり PIO2 の内部 pin 25 → GP41 のルーティングが成立していない。
原因の最有力候補は GPIOBASE register が設定できていないこと:

- RP2350 PIO2 には pin 0-31 を GPIO 0-31 か GPIO 16-47 のどちらに
  マップするかを決める GPIOBASE 1-bit register がある。GP40/41 を
  使うには GPIOBASE = 1 必須。
- pico-sdk header では offset 0x168。だがそこへの書き込みが (GDB から
  も kernel からも) 効かず読み戻すと 0 のまま。0x180 への書き込みは
  効くが、これは IRQ1_INTF register であって GPIOBASE ではない。
- 0x168 が固定 0 を返すという挙動は ACCESSCTRL のロック、OTP ヒューズ
  設定、もしくはこのチップ variant が GPIOBASE をサポートしていない
  可能性。

未確認候補:

- ACCESSCTRL_PIO2 (0x400600BC) の secure/nonsecure / master gate
- BOOT ROM が PIO2 を lock している可能性 — datasheet 確認
- 実は別のレジスタ (例えば SYSCFG 側) でマッピングを切替えるかも
- 板上のチップが RP2350A (高 GPIO 無し) で、bit-bang は他経路で動いて
  いる、というウルトラ稀ケース (要 die marking 確認)

回避策: bit-bang 動作中。SPI 実効 ~1 MHz で十分実用域。PIO 化すると
理論 ~20x 高速化 (clkdiv=4 で 18.75 MHz)。スクロールは現状 diff
redraw + per-cell fill 戦略で実用範囲内。

参考: `kernel/platform/pico2/display_ili9488.tc` の `pio_lcd_init`、in-tree。GDB
session 例は session log 参照。

### 36b. `"abc" + "def"` がポインタ加算になる (limitation、2026-05-23)

StringLiteral 同士の `+` は **ポインタ加算** (「add」命令) を emit
するだけ。コンパイル時 string concat はない。文字列リテラルを行
分割して書きたい場合は単一リテラルとして書くしかない (TC は C 風の
隣接リテラル concat も未実装)。

対処案: tcheck で StringLiteral + StringLiteral を型エラーにすれば
誤用だけは防げる (concat 実装より大幅に安い)。

なお #36 本体 (グローバル var の文字列リテラル初期化が `.word 0` に
落ちる bug) は 2026-07-05 に解決 — 定数エイリアス化。
`docs/solved.md` #36 参照。

### 5. Gen2 typecheck のエラーメッセージ: 段階 2 (AST line info) のみ残 (ergonomics)

段階 1 (関数名 + 引数型 + 直前 comment) は実装済。
段階 2 は未着手: AST に `@line` 情報を入れて `file:line: message` が
出せるようにする大規模変更。段階 1 で実用上十分なので必要性が出てから。

### 10. tcheck の fntab サイズ上限 (limitation)

`compiler/src/tcheck.tc` の fntab は `U32Array(512)` で、1 ファイル中の
関数が 512 を超えるとコンパイル失敗。256 → 512 に暫定拡大済
(2026-04-17)。

対処: 動的配列ライブラリを先に作り、fntab を動的サイズにする。

### 11. struct フィールド名がグローバル関数名と衝突する (limitation)

struct のフィールド名は getter/setter 関数としてマングルされるため、
同名のグローバル関数があると衝突する。

回避策: フィールド名にプレフィックスをつける (`t_ram_sz` など)。
良い解決法が見つかるまで後回し。

### 31. sh に CWD 概念が無い → 相対パスが動かない (limitation)

`cat foo.txt` のような相対パスは `/bin/cat foo.txt` として spawn
されるが、cat の `do_openat(0, "foo.txt", 0)` は `/foo.txt` ではなく
**パスそのまま** を vfs に渡す (vfs は先頭 `/` チェックで絶対パス扱い
する)。絶対パスしか解決できない。

回避策: tab 補完側で relative token の補完を skip するようにして
(2026-04-22)、ユーザを誤導しないように。

対処: kernel / loader 側に CWD を持たせて `sys_chdir` を追加するか、
vfs 側で `/` 始まりでないパスを `/` に前置する spec にする。
優先度低 (phase 8 スコープ)。

### K8+K9. pico2: UART RX の根本問題 (bug, 回避済)

**K8**: 子タスクが UART stdin を直接 spin-wait すると kernel が wedge。
`do_uart_read` が ecall ハンドラ内 (M-mode, 割り込み無効) で busy-loop
するため、バイト未着時にタイマー割り込みが入らず全停止。

**K9**: PL011 RX FIFO (32 byte) overflow で長いコマンドが欠落。
sh が 1 byte ずつ sys_read するため、ecall ラウンドトリップ (~200µs) が
baud rate (87µs/byte) に追いつかず FIFO 溢れ。

**Phase 1 (2026-05-06、commit 6d0c390)**: software ring buffer +
timer-tick drain。`g_uart_rx_buf` (1 KB) と `uart_rx_drain` /
`uart_rx_pop` を追加。`vfs_read fd=0` (mux off) と
`uart_rx_dispatch` (mux on) を ring 経由に統一。timer trap 毎に
PL011 → ring を drain。K8 (spin-wait wedge) は基本解消、sustained
input の K9 (短い ecall 経路) も大きく改善。
**ただし長時間 ecall 中 (mr → fatfs_write → SD CMD24 wait など) は
MIE=0 で timer が masked のため drain 不能 → K11 が依然再現**
(実機検証 2026-05-06、`integration/pico2_k11_reproduce.py` で 256 byte
upload 後 sh が応答せず、UARTRSR の OE flag が立つことを観測)。

**Phase 2A (2026-05-06、commits: pending)**: narrow drain hooks。
`block_sd::sd_spi_xfer` と `do_uart_try_read` (platform_pico2.s) に
処理を追加:
- `sd_spi_xfer` 末尾で `uart_rx_drain()` を呼ぶ。SD 経路 (block_read /
  block_write / fat_alloc_cluster の FAT walk / dir_create の dir
  scan) はすべてここを通るので、SPI 1 byte 毎に drain される
- `do_uart_try_read` 先頭で UARTECR (0x40070004) に書き込み、PL011
  の OE/BE/FE/PE flag を毎回 clear。stale な error flag が混乱を生む
  のを防ぐ
- ring buffer を 1 KB → 4 KB に拡大、burst 耐性を上げる

実機検証: K11 wedge は **256 → 8 KB upload 改善 (32x)**。integration/
pico2_k11_reproduce.py で 256 / 1024 / 4096 / 8192 byte 全 PASS。
16 KB はまだ fail (mr が早期 EOS 検知して残バイトが sh の入力に流れる
モード — 完全 wedge ではないが期待通りでない)。

**Phase 2B (未着手)**: PL011 RX interrupt + ネスト trap。
trap_common.s に nested-trap 対応 (mscratch 退避 + 専用 nested 用
trap stack) を入れて、ecall 実行中も RX IRQ 駆動で drain 可能にする。
systemic + 高コスト。K11 が完全に必要な場合は実装する

**回避策 (実装済)**:
- K8/K9: Phase 1 で大きく改善
- K11: boot-time `dump_mtfs_to_sd` で大容量 UART upload を完全迂回
  (kernel_pico2.tc::dump_mtfs_to_sd、self-replicate 経路で実用化)
- 旧来: tmpfs 経由 + pico2_hw_driver.py の 4 byte / 20ms ペーシング

### K11. pico2 mr 経由の大容量 UART upload が device をハング (bug, 回避済)

**症状**: pico2 で `mr > /sd/<file>` に 1 KB 以上送ると、転送自体は
完走するが、その後 sh が応答しなくなる。openocd reset run でも
復帰せず、USB 電源サイクルが必要。

**観測**: PC は kernel 内で busy-spin 様の動きを見せる
(0x10017c00 付近を周回)。fatfs_close での FAT chain walk + dir entry
update は完了している (file は読み戻せる)。

**qemu virt では再現しない** (2026-05-05 確認、`integration/qemu_mr_scale.py`)。
qemu virt + plain `-serial stdio` で 256〜65536 byte の mr upload は
全部 OK。pico2 固有の現象。

**注意**: qemu の `-serial mon:stdio` は Ctrl-A (= 0x01) を escape
として横取りするため、framed payload に 0x01 が含まれると qemu が
食べてしまう。最初これを K11 と勘違いしたが別問題で、回避は
qemu 側で `-serial stdio` 単独 (`-monitor null`) を使うこと。

**根本原因 (2026-05-06 実機調査で確定)**: ecall_write → fatfs_write
→ block_sd CMD24 wait の経路が **長時間 (1 sector ~10 ms) M-mode
で滞在し、ハードが mstatus.MIE=0 にしている間 PL011 RX FIFO (32 byte)
が overflow** する。
- pico2_k11_reproduce.py で 256 byte upload 後 wedge を再現
- openocd halt で **UARTRSR=0x08 (OE bit set)** を確認 — overrun 発生済
- mr の framing input が破損 → sz hdr が乱数 → mr が無限 read で永続待ち
- 観測 PC は trap_handler / sched_yield_read / vfs_read を周回
  (mr が ecall→-2→yield→ecall を高速反復)

Phase 1 (kernel ring buffer + timer-tick drain) では **timer trap 自体が
ecall 中は走らないため drain 不能** で K11 は救えない。
Phase 2A (sd_spi_xfer drain hook) で 8 KB upload まで救済 (256 → 8 KB
で 32x 改善)。16 KB 以上は依然失敗 — mr が早期 EOS 誤検知して残バイトが
sh の入力に流れる別モード。詳細は K8+K9 エントリの Phase 2A 記述を参照。

**Phase 2 候補**:
- A: block_sd の SPI poll loop / sd_wait_busy で `uart_rx_drain()` を
  呼ぶ。narrow + 低コスト
- B: PL011 RX interrupt + nested trap (`trap_common.s` に nested 対応)。
  systemic だが trap entry の改修必要

**回避策 (実装済)**:
- 大容量 (>1.4 MB の disk.img 等) は host 側で SD カードを抜いて
  manual cp で staging。`pico2_link_kernel_run.sh` の
  `SKIP_UPLOAD=1` 経路 (スクリプト自体は walked-source 退役時に削除、
  commit 4fd9027)
- self-replicate 経路は kernel_pico2.tc::dump_mtfs_to_sd で完全迂回

