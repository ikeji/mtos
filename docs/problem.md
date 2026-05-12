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

### 5. Gen2 typecheck のエラーメッセージ: 段階 2 (AST line info) のみ残 (ergonomics)

段階 1 (関数名 + 引数型 + 直前 comment) は実装済。
段階 2 は未着手: AST に `@line` 情報を入れて `file:line: message` が
出せるようにする大規模変更。段階 1 で実用上十分なので必要性が出てから。

### 10. tcheck の fntab サイズ上限 (limitation)

`compiler/tcheck.tc` の fntab は `U32Array(512)` で、1 ファイル中の
関数が 512 を超えるとコンパイル失敗。256 → 512 に暫定拡大済
(2026-04-17)。

対処: 動的配列ライブラリを先に作り、fntab を動的サイズにする。

### 11. struct フィールド名がグローバル関数名と衝突する (limitation)

struct のフィールド名は getter/setter 関数としてマングルされるため、
同名のグローバル関数があると衝突する。

回避策: フィールド名にプレフィックスをつける (`t_ram_sz` など)。
良い解決法が見つかるまで後回し。

### 6. 配列境界エラー: get の境界チェック未実装 (ergonomics)

set には境界チェックがあるが get にはない。入れようとしたら
#20 (peek/poke が遅い) のせいで `make test` が 60 秒を超えた。
**#20 の解決が先。**

### 20. `peek*` / `poke*` / `get` / `set` が関数呼び出しで遅い (ergonomics)

peek/poke は 1 命令の操作に 5-6 命令のオーバーヘッド。bc2asm で
intrinsic 化すれば解消。解決すれば #6 (get 境界チェック) も入れられる。

いつやるか: 「遅くてどうしようもない」状態になったら。現状は実害なし。

### K7. pico2 で phase 7 コンパイラを完走させる ✅ **解決 (2026-04-29)**

完成: pico2 実機上で OS 自身のコンパイラパイプラインが
parse → sigscan → tcheck → codegen → bc2asm → asm_pass2 → asm_pass3
を全段完走させ、生成された `/sd/HW` を実行して `Hello, World!`
を出力 (K7 達成時 127 秒 / 2026-05-13 再計測で **~15.5 秒**、
`docs/scaling.md` Q1)。

決め手は 3 つの組み合わせ:

1. **SD カード SPI ストレージ追加** (commit 37c99c7):
   `block_sd.tc` + MBR 対応 fatfs。中間ファイル (1.ast / 2.tast /
   3.bc / 4.s / full.s / lab.s / p2.in / HW) を `/sd/` に書くこと
   で 480 KB SRAM tmpfs 制約を回避。
2. **PLL_SYS で CPU を 150 MHz 化** (commit cf22718):
   それまで PLL 未使用で clk_sys ≈ 12 MHz だったため asm_pass2 単独
   で 310s。150 MHz 化で 27s に短縮 (11.5×)。
3. **`tests/pico2_pipeline_drive.py` でプロンプト同期 UART** (commit 5dfa631):
   PL011 RX FIFO 32 byte は sh が sys_wait 中に drain されない。
   `sh$ ` プロンプトを見て次行を送ることで FIFO overflow を回避。

残った副次的課題は別エントリへ:
- ~~part 3 OOM 中継~~: 後続テストで再現せず、最初の観測は別テストの状態残りだった疑い (要再現確認)
- UART RX FIFO に IRQ + ring buffer (本質的解決): K8+K9 と統合して別途
- arena 絶対サイズ: 各 task arena が大きいため pipeline でも依然
  ギリギリ。phase 8 で task 内コード/データ分離を再検討するなら自然に縮む

### 30. tmpfs に unlink が無い (limitation)

`kernel/vfs.tc::vfs_unlink` は `is_sd_path` (FATFS) しか扱わず、
tmpfs / mtfs / procfs では `-1` を返す。`rm /tmp/x` を実行すると
"cannot remove" が出る。rm タスク自体は正常で kernel 側に
`tmpfs_unlink` が無いだけ。

対処: `kernel/tmpfs.tc` に `tmpfs_unlink(name_addr, nlen)` を追加、
`vfs_unlink` が `is_tmp_path` ブランチで呼び出す。mtfs は read-only
なので -1 のままで良い。

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
(実機検証 2026-05-06、`tests/pico2_k11_reproduce.py` で 256 byte
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

実機検証: K11 wedge は **256 → 8 KB upload 改善 (32x)**。tests/
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

**qemu virt では再現しない** (2026-05-05 確認、`tests/qemu_mr_scale.py`)。
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
  manual cp で staging。`tests/pico2_link_kernel_run.sh` の
  `SKIP_UPLOAD=1` 経路
- self-replicate 経路は kernel_pico2.tc::dump_mtfs_to_sd で完全迂回

### K12. fatfs ファイル名 8.3 制限 (limitation)

`kernel/fatfs.tc::fatfs_open` は `nlen > 12` で -1 を返す。
basename ≤ 8 char + `.` + ext ≤ 3 char しか作れず、`kernel_nodisk.bin`
(17 char) のような名前で sh の `>` redirect は "spawn failed" になる。

**対処**: ベンチ側で `knod.bin` 等に rename (短縮) して回避。
LFN (Long File Name) サポートは fatfs 改造範囲が大きいので保留。

**確認済の制約**: pico2 self-build benches は全て 8.3 互換名で書く。
