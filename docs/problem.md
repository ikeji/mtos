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

**part 3 未解決 — EXTRA_TASKS + sh spawn で OOM**:
pico2 kernel を EXTRA_TASKS 付きでビルドすると、sh の sys_spawn で
何を spawn しても OOM (`524292`)。seeded load_task は正常。
診断では path が `/bin/\0catfile` のような不正バイト列に見え、
mtfs_lookup が誤マッチして asm_pass1 の header (arena=524288) を読み
512 KB の kmalloc → arena (480 KB) OOM。仮説:
1. mtfs_lookup が inode 数増加で誤マッチ
2. UART RX stale bytes で sh の path buffer が壊れる
3. vfs_open の path parser 誤動作

**残件 — arena サイズ問題**:
sh (32 KB) + asm_pass2 (512 KB) + stacks ≈ 570 KB で 480 KB arena に
収まらない。小さい compiler task (parse 64 KB, sigscan 32 KB) は
理論上 spawn 可能。K8/K9 の pico2 UART 問題が先にある。

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
