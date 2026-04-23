# U8Array が String の代わりに使われている箇所の監査

## 前提

- `String` — 4 バイト count ヘッダ + バイト列。`len(s)` は内容の長さ。
- `StringLiteral` — コンパイル時定数。読み取り専用。
- `U8Array(n)` — 可変バイトバッファ、容量 n。`len(arr)` は**容量**で内容長ではない。

以下、`compiler/` と `kernel/tasks/` 配下 (= ユーザ空間+コンパイラ) のみ
監査する。カーネル本体 (`kernel/*.tc` トップレベル) は peek/poke で
タスクメモリを直接読む前提なので対象外。

---

## カテゴリ別

### (1) poke32 で U8Array に String ヘッダを偽造 — **解消済 (commit 0be0625)**

`libtc/libtc.tc` に `string_from_bytes(buf: U8Array, off: i32, n: i32) -> String`
を追加し、sh.tc / msh.tc の重複 `substr` を撤去。poke32 は libtc 内の
一箇所にだけ残る。hist_push も同 helper に寄せた。

### (2) NUL 終端 U8Array (= C-string) を値として持ち回る — 設計的に残したい

syscall (open, exec, spawn) はバイト列 + NUL を要求するので、
`U8Array` を「C-string bag」として保持するのは境界として正当。
ただし、**String と両立できる箇所では String に寄せる**余地がある。

| 箇所 | 状態 |
|---|---|
| `kernel/tasks/sh/sh.tc:46-47` `g_in_path/g_out_path: U8Array` | リダイレクト先パスを NUL 終端で保持 → syscall に渡す。境界ラッパーとして残したい |
| `kernel/tasks/sh/sh.tc:531-547` `subcstr` | `substr` の NUL 終端版。`g_in_path/g_out_path` への書き込み用 |
| `kernel/tasks/msh/msh.tc:32-33, 114-128` | sh と同じ |
| `kernel/tasks/libtc/libtc.tc:53-77` `to_cstr(String) / to_cstr(StringLiteral)` | **意図通り**。String ↔ C-string の正式な変換点 |
| `kernel/tasks/libtc/libtc.tc:111-142` `strlen / eq(U8Array, StringLiteral)` | C-string ヘルパ。意図通り |

**方針**: `to_cstr` / `strlen` / `eq` は「C-string API 層」として
明示的に残す。一方、`substr` と `subcstr` が両方存在するのは、
呼び出し側で「どちらを使うべきか」が不明瞭なので整理の余地あり
(例: argv は String で持ち、syscall 直前に to_cstr する、など)。

### (3) 関数引数の `(buf: U8Array, len: i32)` パターン — 中優先度

内容長を別の i32 として持ち回る。String なら 1 引数で済む。

| 箇所 | 関数 |
|---|---|
| `kernel/tasks/sh/sh.tc:87` | `hist_push(buf: U8Array, n: i32)` |
| `kernel/tasks/sh/sh.tc:106` | `erase_line(buf: U8Array, count: i32)` (count はターミナル幅、String 化とは別問題) |
| `kernel/tasks/cat/cat.tc:20` | `scan_eot(buf: U8Array, n: i32)` |
| `kernel/tasks/wc/wc.tc:14` | `count_fd(..., lines, words, bytes: U8Array)` (= 4 バイトの out-parameter 代用。String 化ではなく別問題) |
| `compiler/parse.tc:417` | `wrap_binop(left_buf, left_len, right_buf, right_len)` |
| `compiler/parse.tc:1137-1255` | `emit_type / emit_param / emit_ret / emit_cast_var_tbuf` (型名スライス) |
| `compiler/asm_common.tc:229-350` ほか | `lab_name_eq / lab_hash_name / find_label / define_label` (ラベル名スライス) |
| `compiler/asm_pass2.tc:130` | `name: U8Array` + `name_len: i32` (`.lab` 読み出しラベル名) |

**回避可能か**: 個々は String 化できる。ただし (4) の strtab
パターンと組み合わさっているケースが多く、strtab 側の設計を
同時に考える必要がある。

### (4) 文字列アリーナ + `(ss: i32, sl: i32)` インデックス — 設計上の選択

`compiler/tcheck.tc`, `bcrun.tc`, `codegen.tc`, `parse.tc` は
多数の識別子を一つの `strtab: U8Array` に packed 詰めして、
`(ss, sl)` = (開始オフセット, 長さ) のペアで参照する。
`String` に置き換えると小アロケーションが 1 関数あたり数百〜数千回
走ることになり、kmalloc bucket 圧で ~数十 KB のピーク上昇に直結する。

主要なシグネチャ例:
- `bcrun.tc:132` `bc_fatal(msg, strtab, ss, sl)`
- `bcrun.tc:154` `stab_eq(strtab, ss1, sl1, ss2, sl2)`
- `bcrun.tc:392` `parse_bc(src, strtab, ...)`
- `tcheck.tc:217` `read_node(atom, nodes, strtab)`
- `tcheck.tc:319` `strtab_eq(strtab, ss1, sl1, ss2, sl2)`
- `codegen.tc:71-290` `sval_eq / sv1 / sv2 / slit_find / slit_add` など多数

**回避可能か**: 理論的には StringArray / StringRef struct で
置換可能だが、自己コンパイラのピークメモリ (`docs/task/pipeline_100kb.md`
で 75〜280 KB に収めた) が再び悪化する可能性が高い。
**「strtab は type abuse ではなく、意図された文字列プール設計」として
docs に明記する方が健全** — 引数名 `(ss, sl)` が offset/length なのは
type より dimension の問題 (`String` が欲しいわけではない)。

実際 `docs/design_decisions.md` にこの設計判断を追記すべき。

### (5) syscall 直前の一時 U8Array — 構造的に必要

`sys_write(fd, buf, n)` / `sys_read(fd, buf, n)` / `sys_open(path, flags)`
は **バッファのアドレスと長さを別々に要求する**ので、呼び出し点では
`U8Array` + 長さを使うのが自然 (String のバイト列にアクセスして
ポインタを取り出せる TC API がない)。

該当例 (すべて正当、残す):
- `kernel/tasks/libtc/libtc.tc:7-48` `puts / eputs` (sys_write 直前)
- `kernel/tasks/cat/cat.tc:31,60` (read/open バッファ)
- `kernel/tasks/vi/vi.tc:68-72` `g_buf` (ファイル内容バッファ)
- その他 read/write ループで使われる固定サイズ U8Array 多数

### (6) スクラッチ / バイナリバッファ — U8Array が正しい

- `compiler/string_buffer.tc` `StringBuffer` — 伸長バッファ (位置管理別)。意図通り
- `compiler/asm_*.tc` の out_buf / g_lab_names — バイナリ/packed プール。意図通り
- `kernel/tasks/vi/vi.tc:959-961` `g_undo_buf` — バッファコピー保存

---

## 採用候補 (優先度順)

### ~~高: poke32 String 偽造をユーティリティに集約~~ 済

### 中: sh/msh の argv を String 化
今は `cmd: U8Array` + `start/len` の組から `substr` で String を
切り出して argv に詰めている。argv の型が StringArray な以上
ここは String で統一できる。副作用で `hist_push(buf, n)` も
`hist_push(s: String)` に変えられる。

### 中: `g_in_path / g_out_path` を String + to_cstr 変換点に集約
現在は U8Array (NUL 終端) で保持 → そのまま syscall に渡している。
String で持って syscall 直前に `to_cstr(g_in_path)` する形に
揃えれば `subcstr` は消せる。

### 保留: strtab の (ss, sl) パターン
意図された設計。`docs/design_decisions.md` に「strtab + (ss, sl) は
プール設計であって type abuse ではない」旨を明記して終了。

### 保留: asm_common.tc のラベル名引数
strtab と同類。g_lab_names プールに紐づくスライスなので現状維持。
ただし `asm_pass2.tc:130` の one-shot `name: U8Array + name_len`
は single-string なので String 化候補。

---

## 除外 (type abuse ではない)

- `wc.tc` の out-parameter 代用 U8Array(4) — i32 を参照渡しする手段がない言語仕様由来
- `vi.tc:g_tut_kmap / g_tut_vo` — 漢字テーブル、バイナリ blob
- `compiler/bcrun.tc:357` `heap_new_str` — ヒープ上の String 生成専用 (strtab から String オブジェクトを作る正規経路)
