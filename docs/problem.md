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

## 優先対処

### K5. sh パイプラインで cat が 5 ファイルを連続読みした後の spawn が失敗 (bug, 回避済)

phase 7 M6 のセルフコンパイルパイプライン実装中に遭遇した再現性の
ある挙動:

```
parse ... > /tmp/1.ast
typecheck ... > /tmp/2.tast
codegen ... > /tmp/3.bc
bc2asm ... > /tmp/4.s
cat /rawhdr.s /crt0.s /runtime.s /tmp/4.s /task_data.s > /tmp/full.s
asm < /tmp/full.s > /tmp/hw      # ← "sh: spawn failed"
```

`cat` が **5 つの** ファイル (mtfs 4 個 + tmpfs 1 個) を読み切った
直後に `asm` を stdin redirect 付きで spawn すると、`sys_spawn_handler`
が -1 を返す。asm 単体 (redirect なし) や、他の組み合わせ (例: cat が
3 ファイルだけ) では再現しない。kernel arena / タスクスロット / vfs
fd テーブルのどれを疑っても明確な原因を特定できなかった。

**回避策 (実装済)**: `kernel/build.sh` で `task_crt0.s` + cached
`runtime.s` を事前連結した `/prelude.s` を mtfs に仕込み、OS 側の
`cat` を 3 ファイルだけ読むように減らしたら再現しなくなった。

原因不明のまま残っている。VFS fd リークの可能性があり、他のシナリオで
再発するかもしれない。**優先して原因調査する。**

### K10. pico2: multi-file cat (>2 ファイル) が hang する (bug, 回避済)

pico2 で `cat a b c > out` のように 3 ファイル以上を 1 コマンドで cat
すると hang する (virt では問題なし)。

- 観測: `cat /empty_imports.txt /self_open.txt > /tmp/w1` は OK (2 file)
  だが 3 file 以上でタイムアウト。K5 の 5-file cat 問題と関連の可能性
- **回避策**: 2-file cat chain で中間ファイルを段階的に組み立てる
  (pico2_hw_driver.py が実装済)

K5 と合わせて**優先調査**。

### K6. phase 7 デバッグトレースがデフォルト ON (ergonomics)

phase 7 M6 時点でカーネルに常時出力している debug 出力:

- `kernel/kernel_common.tc`:
  - `trap_handler` の `[sw from>to]` (タイマープリエンプトで switch したとき)
  - `sched_task_exit` の `[x slot=code]` (タスク exit 時)
  - 非タイマー trap で `[TRAP c=... e=... s=N]`
- `kernel/vfs.tc`:
  - リダイレクトされた stdout への write で `[w slot:len]`
- `kernel/tasks/task_crt0.s`:
  - タスク exit 前に `km_dump_peak` を呼び `[kmem peak=N live=M]`
- `compiler/runtime.tc`:
  - `new_array` OOM 時に `OOM: <size>\n` を stderr へ
- `kernel/kernel.tc`:
  - `TIMER_INTERVAL = 10000000` (1 秒 @ 10 MHz) でプリエンプトを
    ゆっくりにしている

mux ON なら per-task 出力が分離されるので混ざらない。mux OFF 時の
整理が要る:
- タイマー間隔を元の 1 ms (10000) に戻す
- トレース出力を mux OFF 時は抑制 or 完全削除
- OOM メッセージは残す (診断に便利)
- `km_dump_peak` はタスク exit の常時 call を外す

### 3. 整数リテラルの型が文脈を見ない (ergonomics) — 実装候補

`U8Array(256)` と書くと i32→u32 のミスマッチで overload 解決に失敗する。
配列コンストラクタが u32 になったため、リテラルは `256u32`、
変数は `(n) as u32` と毎回書かないといけない。

影響範囲: `compiler/*.tc` と `kernel/*.tc` 合わせて `as u32` が 190 箇所
前後ある。これらがほぼ消える見込み。

対処方針:
- **整数リテラルはコンテキストが指定する型で parse/typecheck する**
  のが本命。例: `fn f(x: u32) -> void;` に対して `f(256)` と書いたら
  typecheck が 256 を u32 リテラルとして確定し、そのまま overload 解決
  する。変数経由 (`var n: i32 = 256; f(n)`) は従来通りエラー。
- 文脈がないとき (e.g. `var x = 256;`) はデフォルト i32 のまま。
- tcheck.tc と bootstrap/typecheck.c の両方に変更が要る。

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
