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

### K7. pico2 で phase 7 コンパイラを完走させる (limitation)

**part 1+2 完了**: pico2 で spawn/wait/exec + sh が動く。
**compile 段 byte-exact verify 完了 (2026-04-17)**: parse→bc2asm の
7 段がホスト参照とバイト完全一致。

**part 3 — SD カード経由で進行中 (2026-04-29)**:
SD カード SPI ドライバ + MBR 対応 fatfs を導入 (commit 37c99c7) し、
中間ファイルを `/sd/` に書く形に切替えた。`/tmp/` (480 KB SRAM
tmpfs) ではなく SD ストレージなのでパイプラインのメモリ要件は緩和。
parse → sigscan → tcheck → codegen → bc2asm までは実機で正常動作
を確認 (`tests/pico2_pipeline_drive.py` で `sh$` プロンプト同期)。

**残件 1: ~~asm_pass1 が遅い~~ → 解決 (2026-04-29)**:
真因は **CPU clock 12 MHz** (PLL_SYS 未使用)。`kernel/platform_pico2.s`
で PLL_SYS を bring-up し clk_sys を 150 MHz に切替えた結果、asm_pass1
単独実行が 310s → 27s (11.5×) に短縮。SD write 速度自体は ~5 KB/s
のままだが、asm_pass1 の出力は 11 KB なので影響なし。

**残件 1b: full pipeline での task 連続 spawn 時の OOM**:
parse → sigscan → cat → tcheck → ... と 7 タスク連続 spawn したあと
asm_pass1 が `OOM: 327684` (= asm_pass1 の task arena 320 KB ぴったり)
で落ちる。単独 spawn では同じ asm_pass1 が問題なく完走するので、
**spawn 間で kernel arena が leak してる** 強い疑い。
`free_last_alloc` または `slot_free_allocs` の cleanup path を疑う。

**残件 2: UART RX FIFO オーバーラン**:
PL011 の FIFO は 32 byte。sh が `sys_wait` 中は誰も draining しない
ので、fixed-sleep でコマンドを送ると後半が捨てられる。回避策として
`tests/pico2_pipeline_drive.py` が `sh$ ` プロンプトを見て次行を
送る方式にしてある (`--per-char-delay 0.005` 併用)。pico2 kernel に
UART RX 割り込み + ring buffer を入れれば本質的に解決する。

**残件 3: arena サイズの絶対値**:
sh (32 KB) + asm_pass2 (512 KB) + stacks ≈ 570 KB で 480 KB arena に
収まらない。`/sd` 化によって中間ファイル分は解放されたが、各 task
の arena 自体は変わらないので限界はそのまま。task arena を縮める
別の最適化が必要 (small-payload optimization, etc.)。

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
