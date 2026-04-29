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
parse → sigscan → tcheck → codegen → bc2asm → asm_pass1 → asm_pass2
を全段完走させ、生成された `/sd/HW` を実行して `Hello, World!`
を出力 (合計 127 秒)。

決め手は 3 つの組み合わせ:

1. **SD カード SPI ストレージ追加** (commit 37c99c7):
   `block_sd.tc` + MBR 対応 fatfs。中間ファイル (1.ast / 2.tast /
   3.bc / 4.s / full.s / lab.s / p2.in / HW) を `/sd/` に書くこと
   で 480 KB SRAM tmpfs 制約を回避。
2. **PLL_SYS で CPU を 150 MHz 化** (commit cf22718):
   それまで PLL 未使用で clk_sys ≈ 12 MHz だったため asm_pass1 単独
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

**統合対処案: PL011 RX interrupt + カーネルリングバッファ**
- PL011 RX interrupt を有効化。割り込みハンドラが FIFO → kernel in_buf
  (kmalloc, 例 4 KB) に移す
- sys_read は in_buf から読む。空なら yield して次のスケジュールで再試行
- K8 解消: ecall 内の spin-wait がなくなり、割り込み無効のまま停止しない
- K9 解消: FIFO が interrupt で即座に drain されるので overflow しない
- バッファ溢れ対策: 4 KB あれば sh 対話用途で十分。大量 streaming は
  mux + tmpfs 経由で回避済み

**回避策 (実装済)**:
- K8: tmpfs 経由の入力で spin-wait を回避
- K9: pico2_hw_driver.py で 4 byte / 20ms ペーシング
