# 処理系の既知の問題

このプロジェクトの TC コンパイラ・ツールチェーンで見つかっているが
まだ直していない / 設計判断で後回しにしている問題のリスト。

凡例:
- **bug**: 明確な不具合。正しい挙動に直す必要あり。
- **limitation**: 言語 / ツールの設計上の制限。ワークアラウンドあり。
- **ergonomics**: 動作は正しいが書きにくい / デバッグしにくい。

---

## 言語 / コンパイラ本体

### 3. 整数リテラルの型が文脈を見ない (ergonomics)

`U8Array(256)` と書くと i32→u32 のミスマッチで overload 解決に失敗する。
配列コンストラクタが u32 になったため、リテラルは `256u32`、
変数は `(n) as u32` と毎回書かないといけない。

影響範囲: `compiler/*.tc` と `kernel/*.tc` 合わせて `as u32` が 190 箇所
前後ある。これらがほぼ消える見込み。

対処方針 (後回し):
- **整数リテラルはコンテキストが指定する型で parse/typecheck する**
  のが本命。例: `fn f(x: u32) -> void;` に対して `f(256)` と書いたら
  typecheck が 256 を u32 リテラルとして確定し、そのまま overload 解決
  する。変数経由 (`var n: i32 = 256; f(n)`) は従来通りエラー。
- 文脈がないとき (e.g. `var x = 256;`) はデフォルト i32 のまま。

### 5. Gen2 typecheck のエラーメッセージ: 段階 2 (AST line info) のみ残 (ergonomics)

段階 1 (関数名 + 引数型 + 直前 comment) は実装済 (→ fixed list)。
出力例:
```
Type error: no overload for 'append' matching (StringLiteral, i32)
  near: var s: String = append("hi", a);
```

段階 2 は未着手: AST に `@line` 情報を入れて `file:line: message` が
出せるようにする。parse.tc / typecheck.tc / codegen.tc / bc2asm.tc /
extract_sigs.tc と bootstrap 各種の AST 読み取りを同期する大規模変更。
段階 1 で実用上十分に場所が特定できているので、必要性が出てから検討。

### 6. 配列境界エラー: 残件 (ergonomics)

段階 1a (bootstrap C runtime のメッセージに idx/len を入れる) と
1b (compiler/runtime.tc の **set** に境界チェック追加) は実装済
(→ fixed list)。例: `set: 10 out of bounds (len=5)`。

残件:
- **get の境界チェックは未実装** (set のみ)。読み取り側 OOB は
  silent に不正な値を返す。set と同じく入れる方が筋だが、get は
  kernel scheduler 他の hot path にあり、入れると `make test` が
  60 秒制約を超えたので保留。runtime 側の最適化か、test 制約の
  緩和が先。
- **段階 2 (大規模)**: BC に line 情報を入れて「どの TC 行」を出す。
  #5 段階 2 と共通の AST/BC フォーマット変更。必要性が出てから
  検討。

---

## asm.tc (アセンブラ兼リンカ)

### 7. asm.tc が assembler + linker 一体でメモリ消費が巨大 (limitation, 長期)

現状の `compiler/asm.tc` は 1 プロセスで .s の tokenize →
シンボル解決 → ELF 出力まで全部こなし、起動時に静的に約 **9 MB** の
バッファを確保している:

| バッファ | サイズ |
|---|---|
| `g_code` (出力) | 4 MB |
| `g_lines` (入力ソース保存、2 パス目で参照) | 4 MB |
| `g_line_offs` / `g_line_lens` (各 128K × 4B) | 1 MB |
| `g_lab_names` / `g_lab_*` 4 本 | ~500 KB |
| その他 | ~150 KB |
| **合計** | **~9 MB** |

ホストで走らせる分には問題ないが、**Pico 2 (256 KB RAM) のセルフ
ホストは全く不可能**。フェーズ 2.5 (Pico 2 セルフホスト) /
フェーズ 7 (OS 上コンパイラ) の前提として解決したい。

対処 (段階的):
- **短期 (実装済)**: trap_common.s の ecall handler プロローグ /
  エピローグをヘルパラベル (`_ecall_enter` / `_ecall_leave_advance`)
  に括り出し、`.macro` なしでも単一ソース化できることを確認。
  asm.tc には触れていない。→ fixed list 参照。
- **中期**: asm.tc の MAX_CODE / g_lines を実用値 (512 KB?) に下げる、
  入力を streaming にする、2 パス目は backpatch テーブルで済ませて
  source の再読み込みを避ける。単一プロセスのまま半分以下のメモリ。
- **長期**: `.o` ファイル形式を決めて assembler と linker を別プロセス
  に分離する。アセンブラは single-file 入力で `.o` 出力、リンカは
  複数 `.o` を読んでシンボル解決 + ELF 出力。macro サポートは分離後
  のアセンブラフェーズに入れる (今入れると分離時に移し替えが必要)。
  これで各プロセスが Pico 2 の 256 KB に収まる。

### 8. asm.tc がセクション境界を 16 バイト単位までしかアラインしない (wontfix)

`compiler/asm.tc:1148-1151` で各セクションサイズを 16 バイト
(`.align 4`) に切り上げるため、`.align 12` (4 KB 境界) 以上を
.bss に書けない。pass 1 と pass 2 で g_pos の basis が違うので、
section_base を合わせないと padding 量が drift する。

実害範囲を検討した結果 **修正不要** と判断:

- 影響するのは `kernel/block_virtio.tc` 1 箇所のみ (virtio-legacy
  の queue を 4 KB 境界に置くため、TC 側で 12 KB kmalloc して
  先頭を手動で 4 KB に切り上げ)。
- **問題になるのは qemu virt ターゲットだけ**。virt は 128 MB
  RAM なので 12 KB の waste は誤差。
- **実機 Pico 2 は virtio を使わない**。block_flash.tc で XIP
  経由、4 KB 境界の要求自体が発生しない。
- したがってこの限界を直しても減るのは qemu 上の 12 KB だけ。

もし将来 virtio-net / virtio-gpu を追加したり、実機で別のデバイスが
4 KB 境界を要求したりしたら再評価する。それまでは block_virtio.tc の
手動アラインのまま。


---

## カーネル / OS

### K2. スケジューラの最大スロット数がハードコード (limitation)

`kernel_common.tc` の `sched_init(max)` が `max` 個のスロットを確保し、
`sched_spawn` はその中から unused / done スロットを再利用する。
`max` を超える同時タスクは spawn できない (spawn が -1 を返す)。
現状 virt / pico2 とも `sched_init(8)` で 8 並列が上限。

対処案:
- スロット数を動的に増やす (U32Array の再割り当て)。
- done スロットを積極的にリサイクル (既に実装済み)。

### K3. タスクのスタック / arena サイズがハードコード (limitation)

`make_task(entry, ram_size, stack_size)` の呼び出し側でサイズを指定
するが、virt は 65536/65536、pico2 は 16384/8192、sys_exec_handler
は 16384/8192 とバラバラ。統一した "task size policy" がない。

対処案:
- ELF ヘッダで必要な BSS サイズを宣言する (現在 raw bin なのでヘッダ
  なし)。
- kmalloc ベースのタスクであれば最低限のサイズ (4KB?) で済むように
  するか、タスクの crt0 が自分の必要量を宣言する仕組みを入れる。

### K4. `do_uart_read` が無限ループで EOF を検出できない (limitation)

`kernel/platform_virt.s` / `kernel/platform_pico2.s` の
`do_uart_read` は LSR Data Ready ビットを busy-loop で待つだけで、
stdin が閉じた (EOF) 状態を区別できない。

影響:
- qemu 側でパイプ入力が尽きた後に sys_read(0, ...) すると、永久に
  ブロックする。
- `/bin/sh` をループ化する場合、EOF で抜けられず "quit" コマンドなど
  明示的な終了手段が必要。

対処案:
- UART ドライバに "non-blocking read" / "peek" を追加。
- qemu のシリアル終了条件を使う (但し実機との挙動差が出る)。

## バイトコード / ランタイム

### 20. `peek*` / `poke*` / `get` / `set` が関数呼び出しで遅い (ergonomics, 後回し)

`peek8` / `peek16` / `peek32` / `poke8` / `poke16` / `poke32` は
それぞれ `trap_common.s` / `crt0_tc.s` で `.globl` ラベルとして定義
された小さなアセンブラ関数で、中身は `lbu a0, 0(a0); ret` のような
1〜2 命令。ところが TC コードから呼ぶと BC レベルでは普通の
call 命令に展開され、bc2asm が `call peek8__u32` を吐く:

- 引数を push
- `call peek8__u32` (jal + 関数先頭 + `lbu`/`ret` + 戻り)
- 結果を pop

実質 1 命令の操作に 5〜6 命令のオーバーヘッドが付く。
`get(U8Array, i)` は内部で `peek8(o as u32 + 4 + i as u32)` を呼ぶ
ので、さらに call が入れ子になる。kernel scheduler / lexer / AST
walk のような hot path で効く。

**症状**: compiler/runtime.tc の `get` 側に境界チェックを追加
しようとしたら (#6 段階 1b) `make test` が 60 秒制約を超えた。
peek/poke の call オーバーヘッドがボトルネックの一因。

対処案:
- bc2asm (または codegen) に「peek/poke を intrinsic として認識し、
  該当 BC opcode → 直接 `lbu`/`lhu`/`lw`/`sb`/`sh`/`sw` を emit」
  する特化コードを入れる。関数 label 自体は残して宣言 fallback と
  して動くようにしておけば、codegen 以外のフロント (bcrun 等) は
  従来通り。
- 将来 get/set にも同様の展開を行えば、境界チェック付き get の
  hot-path コストが許容範囲に収まる可能性あり。

**いつやるか**: kernel/tests/pico2 実機のどれかが「遅くてどうしよう
もない」状態になったら試す。現状は特に実害なし。

---

## ビルド / テスト

### 17. `make test` の実行時間が 60 秒上限にぎりぎり (ergonomics)

現在 57-58 秒前後で 60 秒制約 (CLAUDE.md) を満たしている。スイート別
内訳 (実測):

| スイート | 時間 | 主な内容 |
|---|---|---|
| Compiler Source Tests | ~24 s | parse/codegen/bc2asm/bcrun の Gen1 vs golden、Gen2 vs Gen1、Gen2 vs Gen3 (qemu 経由 4 ファイル) |
| OS Component Tests (fs_virtio) | ~19 s | kernel + 4 task の Gen2 ビルド + qemu 起動 |
| asm.tc Virt End-to-End | ~10 s | 5 件 × compile-gen2.sh |
| その他 (unit / pipeline / import / golden) | ~5 s | |

**最有力の方向 (未実装)**: テストを「コンパイラを触ったときに必要」と
「OS / カーネルを触ったときに必要」に分割する。Makefile に
`make compiler-test` と `make os-test` (仮) を導入し、デフォルト
`make test` の意味を文脈で切り替える。

理由:
- 普段の開発で「コンパイラは触っていない、kernel/* だけ書いている」
  ときに Compiler Source Tests (24s) を毎回回す必要がない
- 逆もまた然り (compiler/* だけ触ってるときに kernel build を回す
  必要がない)。
- 単純に「全部速くする」より「触っていない部分を skip する」ほうが
  実効ターンアラウンドが短くなる
- 60 秒制約への余裕も自然に生まれる

実装メモ:
- ファイル分割: tests/test_compiler.sh (Gen2/Gen3 比較系) と
  tests/test_os.sh (kernel + asm Virt) を独立に呼べるようにする
- `make test` のデフォルト挙動は要相談。今のように全部回すか、
  どれか一方をデフォルトにするか
- CLAUDE.md の 60 秒ルールは「個別ターゲットそれぞれ 60 秒以内」と
  読み替える可能性

その他の高速化案 (副案):
- kernel/build.sh の task コンパイル並列化 (5 ファイル sequential
  → parallel で OS Tests が 19s → ~5s 期待)
- Gen2 中間出力のキャッシュ (.tc hash → .bin)
- 上記分割と独立に効くので、必要に応じて段階的に。

---

## compiler/ のリファクタ TODO

コード中に `// TODO:` で書き残した、動作は正しいが書き方が冗長 /
共通化できていない箇所のまとめ。挙動に影響しない refactor のみ。

### R1. ノードプールを struct 化する (ergonomics)

`compiler/codegen.tc` と `compiler/extract_sigs.tc` が AST ノードを
`I32Array` の 8 エントリごとに手で index している
(`n*8 + field_idx`)。`struct AstNode { kind, ss, sl, ival, first_child,
next_sibling, tass, tasl }` + `AstNodeArray` に置き換えれば
`kind(node)` のようにフィールドアクセスで書ける。scheduler を
`struct Task` に畳んだのと同じパターン。

- `compiler/codegen.tc:93` — `// TODO: Structにして。`
- `compiler/extract_sigs.tc:57` — `// TODO: struct`

### R2. extract_sigs と typecheck のノードプール処理を共通化 (ergonomics)

`extract_sigs.tc` と `typecheck.tc` が同じような node accessors
(`n_kind` / `n_ss` / `n_sl` / …) と kind classifier (`cmp2` / `cmp3`
/ `cmp4`) を各自コピーしている。R1 で struct 化すれば自然に
「AstNode は 1 箇所で定義」になる流れ。

- `compiler/extract_sigs.tc:56` — `// TODO: これ、typecheckと共通化できない？`

### R3. 文字列比較ヘルパ `cmp(U8Array, offset, StringLiteral)` を作る (ergonomics)

`strtab` やラインバッファに対する「この位置から始まる領域が特定の
リテラルと一致するか」の判定が、今は `sl==N` + 1文字ずつの `a=='s'&&
b=='h'&&c=='r'` で展開されている (bc2asm.tc, codegen.tc,
extract_sigs.tc, asm.tc)。

1 つの `cmp(buf, offset, s: StringLiteral) -> bool` ヘルパに
置き換えれば `classify_op` などが読みやすくなる。TC のオーバーロード
上は U8Array と StringLiteral の 2 引数なので素直に書ける
(StringLiteral の `len` + `get` を使ってバイト比較)。

- `compiler/bc2asm.tc:313` — `// TODO: cmp(strtab, "or") みたいなの作って。`
- `compiler/asm.tc:785` — `// TODO: compare(g_line_buf, sop_off, ".rodata")`
- `compiler/asm.tc:966` — `// TODO: compare(g_lines, p, "load_base ")`
- `compiler/extract_sigs.tc:84` — `// TODO: cmp(a, "type") でいい。`
- `compiler/codegen.tc:150` — `// TODO: 関数名は全部cmpでいい。引数はStringLiteralでいい。`

### R4. 文字列出力ヘルパ `emit_string(StringBuffer, StringLiteral)` を使い切る (ergonomics)

`bc2asm.tc` / `codegen.tc` の asm 出力が `emit_char` を 1 バイトずつ
呼んでいる箇所が多数ある (`e4(ob); emit_char('a'); emit_char('d');
emit_char('d')`)。`emit_string` は既に `string_buffer.tc` にあるので
置き換え可能。合わせて `emit_nl(ob) -> emit_char(ob, 10u8)` のような
薄いヘルパも欲しい (改行出力が至る所に散らばっている)。

- `compiler/bc2asm.tc:81` — `// TODO: emit_stirng 使えないの？`
- `compiler/bc2asm.tc:82` — `// TODO: emit_nl(ob) -> emit_char(ob, 10u8)を作ろう。`
- `compiler/bc2asm.tc:107` — `// TODO: emit_string`
- `compiler/codegen.tc:504` — `// TODO: emit_string`

### R5. bc2asm 関数テーブル行を struct 化する (ergonomics)

`bc2asm.tc` の `fns: I32Array` は 1 行 10 エントリの固定レイアウトで
アクセサ関数 (`fn_name_ss` / `fn_name_sl` / ...) を手書きしている。
R1 と同じ発想で `struct BcFunc { ... }` + `BcFuncArray` にすれば
すっきりする。

- `compiler/bc2asm.tc:383` — `// TODO: Structにして。`

### R6. asm.tc のラベル管理を struct 化する (ergonomics)

`asm.tc` は `g_lab_names` (U8Array) + `g_lab_offs` (I32Array) を
並列配列でラベル表にしている。`struct Label { name_ss, name_sl, off }`
+ `LabelArray` に置き換えたい (`sched_init` 周りと同じ構造)。

- `compiler/asm.tc:1089` — `// TODO: Label構造体を作って。`

### R7. bc2asm の stdin 読み込みを SourceReader に寄せる (ergonomics)

`bc2asm.tc` の `main` は 64KB チャンクで stdin をループ読みしている
が、`compiler/source_reader.tc` が既にストリーミング入力ライブラリとして
存在する。揃えれば `parse.tc` と同じ入力処理パスになる。

- `compiler/bc2asm.tc:1097` — `// TODO: Use SourceReader`

### R8. asm.tc の dead `parse_reg` を消す (cleanup)

`compiler/asm.tc:203` の `parse_reg` は書きかけで `return 0 - 1; // TODO`
で終わっており、実際のロジックは `parse_reg_op` に書き直されている。
呼び出し元もないはずなので dead code として削除するだけで済む。

- `compiler/asm.tc:215` — `return 0 - 1; // TODO`

---

## 参考: すでに直した問題

履歴として残す。コミットメッセージを見れば詳細がわかる。

- `u32 >> n` が arithmetic shift だった → `shr_u` opcode 追加 (9ff97b5)
- `u32 < u32` (`<=`, `>`, `>=`) が signed 比較になっていた → `lt_u` /
  `le_u` / `gt_u` / `ge_u` opcode 追加 + codegen で LHS 型を見て分岐。
  合わせて `string_buffer.emit_int` が INT32_MIN を出力できなかった
  バグも修正
- `u32 / u32` / `u32 % u32` が signed 除算になっていた → `div_u` /
  `mod_u` opcode 追加。bc2asm は `divu` / `remu` を emit。asm.tc にも
  `divu` / `remu` エンコーディングを追加。bcrun.tc 側はバイナリ長除算
  で software 実装
- 16 進リテラル `0xFFFFFFFF` 等で top bit 以上が壊れる → compiler/parse.tc
  の hex/binary 累積を `<<` + `|` に変更して bit パターンを保存。
  合わせて bootstrap の ast/codegen を `printf %d (int32_t)` に揃え
  (Gen1 と Gen2 の AST テキストを一致させる)、interp.c の `>>` も
  u32 なら論理シフトするように修正。typecheck.tc の int literal 読み
  取りが先頭 `-` を受け付けていなかったバグも修正 (negative 値が 0 扱い
  だった)
- struct 定義の trailing comma が通らなかった (parser) → 修正 (b04855c)
- 関数宣言 / 関数呼び出しの trailing comma → 修正 (b04855c)
- struct array が asm リンカで未定義シンボル → parser で synthetic fn
  を生成して修正 (b04855c)
- 配列コンストラクタの size が i32 だった → u32 に変更 (b04855c)
- Gen2 typecheck が struct array 型を知らなかった → 対症療法として
  typecheck.tc に register_struct_array を足したが、最終的には synthetic
  fn で置換 (b04855c)
- runtime.tc の pool アロケータが固定バケット + 先頭追加しかできず
  カーネルで任意サイズの task RAM を確保できなかった → kmalloc/kfree
  (free-list + 10 bucket) に置き換え (d889401)
- kernel が bin2s で .rodata にタスクを埋め込んでいたので /bin/* という
  概念がなかった → mtfs + `loader.tc` + `vfs_xip_addr` で FS からロード
  するフローに差し替え (フェーズ6 Step 6.2 / 6.3、bb5ad5c / 4d082c3 /
  6955d8b)
- スケジューラが固定スロットで 1 度 done したら再利用不可だった →
  state 4 種 + sched_spawn / sched_wait を追加してプロセス管理の土台を
  作り、sh をループ化できるようにした (フェーズ6 Step 6.5)
- `load_task` / `sys_exec_handler` が task 画像 (frame_buf / ram /
  stack / img) を一切 free していなかった → スケジューラに per-slot
  の owning allocation arrays を追加。make_task が g_last_* に
  allocation base を記録し、sched_register/spawn/replace_current が
  slot に snapshot、sched_task_exit と sys_exec が古い slot を
  kfree するようにした。テストは 5× catfile spawn/wait で
  `KERN: live=36` が変わらないことを検証 (リーク時は spawn 毎に 4 ずつ
  増える)。runtime.tc に `kfree` / `km_live_count` / `km_dump_stats` の
  export を追加 (K1)
- typecheck のエラーメッセージが `"Type error\n"` 11 バイト固定だった
  → `check_call_site` の失敗時に関数名 + 引数型リスト + 直前 comment
  ノード (parse.tc が AST に埋め込む元ソース行) を印字するよう拡張。
  例: `Type error: no overload for 'append' matching (StringLiteral, i32)
  near: var s: String = append("hi", a);`。行番号なしでも位置特定
  できる。AST フォーマットは不変 (#5 段階 1)
- bootstrap C runtime の `"get/set: out of bounds"` メッセージが固定
  文字列で idx/len を含まなかった → `bootstrap/runtime_syscall.c` の
  get_bounds_check / set_bounds_check で `"get: <idx> out of bounds
  (len=<n>)"` を出すように修正。bootstrap/bcrun.c / interp.c の独立
  チェックも同じ書式に揃えた (#6 段階 1a)
- compiler/runtime.tc の get/set に境界チェックが一切なく Gen3 ターゲット
  (kernel / 各種 TC app) は OOB で silent corruption していた → `set`
  側のみ境界チェックを追加 (set は書き込み = 他領域を壊せるので
  こちらが致命的)。`(i as u32) >= (n as u32)` の unsigned 比較で
  "i<0 または i>=n" を 1 命令にまとめて hot-path コストを最小化。
  get 側は 60 秒テスト制約を超えたので残件 (#6 段階 1b 部分)
- trap_common.s の 8 つの ecall ハンドラが prologue / epilogue を
  コピペしていた (mv s0,sp; call _set_kern_gp; la t0,_kern_save;
  lw sp,4(t0) の 4 行 × 8 + 終端 5 行 × 8) → `_ecall_enter` /
  `_ecall_leave_advance` というヘルパラベルに括り出して各ハンドラを
  半分程度に縮めた。`.macro` / `.endm` のサポートを asm.tc に足さず
  ヘルパラベル (`call _ecall_enter` / `j _ecall_leave_advance`) で
  single-source 化。23 行減 (#7 短期)
- Gen2 ツールの再ビルドが「15 秒以上かかる」という問題と対処案が
  problem.md にあったが、実測で 1.6 秒 (6 ツール順次) になっていた。
  原因は特定しきれていないが、shr_u / u32 除算 / int32 canonicalization
  などの bootstrap 改善が積み重なった結果と推測。測定値が十分小さい
  ので #16 は閉じる。合わせて `tests/test_common.sh:build_gen2_tool`
  に残っていた `2>/dev/null` を削除して #14 (stderr 可視化) と一貫
  させた (#16)
- `/tmp/gen2` / `/tmp/gen3` のキャッシュが stale のまま使われると、
  古い overload テーブル経由で意味不明な実行時エラー (かつて
  "get: out of bounds" の発生源) になっていた → compile-gen2.sh /
  compile-gen3.sh の起動時に `find compiler/*.tc -newer
  $GEN2_DIR/typecheck` で検出し、stale 時に rebuild コマンドを含む
  警告を stderr に出すようにした。強制 rebuild はしない (開発者が
  stale build を意図的に使いたい場面もあるため)。make test は毎回
  fresh にビルドするので警告は出ない (#15)
- ツールチェーンの stderr が「成功時に 100 行以上のノイズ」で埋まっていて
  `compile-gen*.sh` が全パイプ段を `2>/dev/null` で潰していた (結果
  typecheck/codegen/bc2asm の失敗が開発者に見えなかった) → 3 箇所の
  無条件 stderr 出力を削除: (a) `compiler/runtime.tc` の `sys_exit` が
  `km_dump_stats` を呼んでいたのをやめた、(b) `compiler/asm.tc` の
  成功時ラベルマップダンプを削除、(c) `bootstrap/runtime_syscall.c` の
  `sys_exit__i32` が `pool_dump_stats` を呼んでいたのをやめた。これで
  compile-gen1/gen2/gen3.sh の `2>/dev/null` を全部外せて、成功時は
  完全無音・失敗時はエラーがそのまま見えるようになった。make test も
  副次効果で ~1s 速くなった (#14)
- `struct` フィールドに `StringLiteral` 型を書けるか未検証だった (#18) →
  3 経路 (interp / bcrun / rv32) で動作確認。`struct Mount { prefix:
  StringLiteral, fs_type: i32 }` のような宣言・コンストラクト・
  field アクセスとも問題なし
- `compiler/bcrun.tc` の OP_SHR_U 実装が「1 ビット arithmetic shift +
  & 0x7FFFFFFF マスク + 残りシフト」という 5 行の trick だった → shr_u
  が bootstrap / Gen2 両方に実装済なので、`((a3 as u32) >> (b3 as u32))
  as i32` の 1 行に置き換え。以前の循環依存 (shr_u 実装に shr_u が
  必要) は解消済 (#11)
- asm.tc のエラーが「`asm: unknown instruction 'xxx'`」など mnemonic
  だけで行番号も元行もなかった → `g_cur_line` を `process_line` 冒頭
  でセットし、`asm_err_begin` / `asm_err_end` ヘルパで 3 つのエラー
  サイト (unknown instruction / undefined label / gp-relative out of
  range) を書き直した。新しい出力形式: `asm:<line>: <msg>\n  at:
  <verbatim line>`。pass 2 終了後は `g_cur_line = 0` でクリアし
  write_elf 段階のエラー (e.g. 未定義 _start) が過去の行を誤って
  参照しないようにした (#9)
