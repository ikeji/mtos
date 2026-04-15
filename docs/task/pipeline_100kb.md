# フェーズ 2.5 / 7: コンパイルパイプラインを 100 KB 級に縮める計画

## 目的

Pico 2 (RP2350、SRAM 520 KB) で自分自身を再コンパイルできるようにする。
phase 7 M6 で qemu virt 上のセルフコンパイルは達成したが、実測ピークが
asm ≈ 9.5 MB、bc2asm ≈ 1.4 MB で、どちらも pico2 では到底載らない。
各ステージのデータセグメント (BSS + heap) を **100 KB 前後** に抑えるのが
目標。達成できれば 256 KB task RAM (kernel/loader.tc) の枠に余裕で収まる。

理想は **1 パス + ストリーム処理**。どうしても forward reference が外せない
ステージは、**プロセス分割 + 中間ファイル経由**で逃がす。
**動的成長配列は使わない** — TC では `U8Array` への ref 自体が kmalloc
ハンドルなので、growth で kmalloc し直すと既存の参照が dangling する。
代わりに「あらかじめ十分小さい固定バッファ + 越えたら kmalloc per-item」
の 2 本立て (固定: per-function instructions、可変: 識別子文字列) で
シュリンクする。

関連: `docs/problem.md` #7 (asm.tc memory)、 K3 (per-task size)、
`docs/task/phase7_compiler_on_os.md` (M1〜M6 記録、実測ピーク表)。

---

## 現状 (phase 7 M6 時点)

| ステージ | 実測ピーク | 主な allocation (静的) | 入力 | 出力 |
|---|---:|---|---|---|
| parse      | 14 KB   | tok_buf 4K + SourceReader 4K + StringBuffer 増 | stream | stream |
| typecheck  | 717 KB  | strtab 512K + fntab 113K + AstNode プール | stream | stream |
| codegen    | 303 KB  | strtab 256K + AstNode(4K slot) + locals 8K | stream | stream |
| bc2asm     | 1.4 MB  | **instrs 1M** + strtab 256K + label_pcs 64K | stream | stream |
| asm        | 9.5 MB  | **g_code 4M + g_lines 4M** + labels 320K | slurp | 一括 |

- **parse**: 合格。単調 stream、forward reference 無し。
- **typecheck**: 大半が固定サイズの strtab (524288) と fntab (600 × 47 i32)。
  いま fntab は 600 関数分固定、1 関数あたり 47 フィールドもあるので
  実質上限まで取っている。
- **codegen**: 固定 256 KB strtab が支配的。AstNode は per-function reset
  できているので pool の絶対ピークは既に制御下。
- **bc2asm**: `I32Array(262144)` で 1 MB の全 instruction バッファを持ち、
  pass 全体を終えるまで保持している。"stream 入力・bulk emit" 構造。
- **asm**: g_code と g_lines がそれぞれ 4 MB。入力を全部バッファリングして
  2 パス、出力も 4 MB の U8Array に書いてから一括 write_elf で吐く。
  `MAX_CODE = 4194300` に素で張り付く最悪クラス。

参考: `docs/problem.md` #7 に asm.tc 単独の内訳と assembler/linker 分離の
短中長期案あり。本計画はそれを phase 7 と統合して pipeline 全体で 100 KB
に寄せる。

---

## 構造的な障害物 (なぜ RAM が要るのか)

ステージごとに「これがある限り完全 stream 化は無理」という制約:

| ステージ | 障害物 | 影響 |
|---|---|---|
| parse     | なし | —  |
| typecheck | **forward fn / struct 参照** | AST 全体を持たないと未定義識別子か後出し関数か判断不能 |
| codegen   | 実装上は無いが、strtab を固定で大きく取っている | 単なる余剰確保 |
| bc2asm    | **function 内の forward jump label** | 命令ストリームが固まるまで `jal` / `br` のオフセット決まらず |
| asm       | **global label forward reference** (関数を跨ぐ call / la) + ELF ヘッダの size 事前確定 | 全関数読むまで label → 絶対 PC が定まらない。ELF 側も segment size を先頭に埋めるので全体長が必要 |

ポイントは **forward reference の粒度** が違うこと:

- typecheck / asm: module-wide (別の関数 / top-level を指す)
- bc2asm: function-local (同じ関数内のラベル)

ここが設計の分岐点。

---

## 目標予算

各ステージ **working set 100 KB 以下** を目標 (コード + 固定 rodata は別勘定)。
1 ステージずつ独立に動作するので、同時に乗る心配はない。

※ 実測値は **2026-04-15 / commit 5ee10a4** 時点。Gen3 tools を
   compile-gen2.sh で build (= compiler/runtime.tc を実 link) し、
   `km_dump_peak` を qemu-riscv32 で 14 個の compiler/*.tc に対して
   走らせた結果。詳細な per-input テーブルは下の「ステージ別実測表」
   を参照。

| ステージ | 現在 | 目標 | 実測 | 主なやること |
|---|---:|---:|---:|---|
| parse     |  14 KB |  15 KB | **14 KB**       | 維持 |
| sigscan   | (新規) |  20 KB | **9〜11 KB**    | extract_sigs.tc 派生、**top-level を全部** (非 export 含む) .th に出す。block / field / 式は読み捨て (#62 完了)。入力に関係なくほぼ一定 |
| tcheck    | 717 KB |  80 KB | **74〜244 KB**  | typecheck から派生、per-top-level reset + per-fn strtab rollback + **per-fn kmalloc fntab** (#51, #63, #64 完了)。残り bottleneck は vm_run の 2581 nodes (3072-slot AstNode pool) のみ。bcrun.tc が 244 KB の outlier |
| codegen   | 303 KB |  50 KB | **79〜246 KB**  | strtab を perm/ephemeral 2 cursor 化 + per-top-level rollback (#59 完了)。同じく bcrun.tc::vm_run の AstNode pool が outlier |
| bc2asm    | 1.4 MB |  35 KB | **118〜124 KB** | **per-function emission** + per-fn strtab rollback (#60 完了)。入力に関係なくほぼ一定 |
| asm-pass1 | (新規) |  45 KB | **398〜436 KB** | asm から派生、label collector のみ。`.lab` を出力 (#56)。g_lab_names 256 KB + g_labels 16384 entry で定数部分がほぼ満杯 |
| asm-pass2 | (新規) |  45 KB | **557〜624 KB** | asm から派生、`.lab` を読んで encoder (#56 + Phase 4)。g_code を `.lab` のセクションサイズ合計で動的確保するようになり、旧 4.6 MB (MAX_CODE 固定) は解消。compiler/*.tc では text+rodata+data ≈ 300〜400 KB が支配的 |

「動的成長配列」は使わない。固定で十分小さく取れるものは固定 (instrs:
1 関数 4096 entry など)、可変なものは「**1 個ごとに kmalloc**」する
(識別子文字列、symbol entry、ラベル名など)。U8Array/I32Array のハンドル
は再 alloc しないので、生ポインタを取っているコードを壊す心配がない。

順次実行なので合計値の意味は薄く、**最大 80 KB** が pico2 の枠を決める。

---

## ステージごとの具体策

### 1. parse (14 KB → 15 KB)

何もしない。lexer の tok_buf を必要なら拡張する程度。

### 1.5. sigscan (新規 → 10 KB) ✓ 完了

`compiler/sigscan.tc` (#50, #62)。`extract_sigs.tc` を雛形にして拡張 .th
を吐く。phase 7 経路 (compile-gen2.sh + tcheck) でしか使われないので、
host (compile-gen1.sh) と既存 typecheck.tc には影響を与えない。

実装上のポイント:

- **per-top-level ストリーミング**: `(program` を手動で消費した後、
  top-level 1 個ずつ `read_node` → emit → `reset_node_pool() + g_sp=0`
  のループ。pool peak は「1 個の top-level decl」分に閉じ込める
- **subtree skip**: `should_keep()` で「sigscan が emit するノード種」だけを
  pool に格納し、それ以外 (block / field / 式 / comment) は
  `consume_subtree_silent()` で読み捨てる。これで関数本体が pool を
  食い潰すことはない
- **kmalloc per-item**: 識別子文字列はそのまま大きな strtab に積むが、
  per-top-level reset で短命

実測 (**2026-04-15 / commit 5ee10a4**、Gen3 sigscan + qemu-riscv32):

| 入力 | km peak |
|---|---:|
| compiler/asm_pass1.tc      |  **8692 B** |
| compiler/asm_pass2.tc      |   9100 B |
| compiler/runtime.tc        |   9228 B |
| compiler/strlib.tc         |   9236 B |
| compiler/string_buffer.tc  |   9236 B |
| compiler/asm_common.tc     |   9636 B |
| compiler/codegen.tc        |   9636 B |
| compiler/source_reader.tc  |   9644 B |
| compiler/sigscan.tc        |   9372 B |
| compiler/tcheck.tc         |   9772 B |
| compiler/ast_node.tc       |   9780 B |
| compiler/parse.tc          |  10044 B |
| compiler/bc2asm.tc         |  10052 B |
| **compiler/bcrun.tc**      | **11548 B** |

入力ファイルにかかわらず 9〜11 KB で頭打ち。fixed buffers の内訳:

- `AstNodeArray(64)`: 64 × 4 B = 256 B refs + 最大 22 ノード × 36 B
  AstNode = 約 1 KB live
- `U8Array(512)` strtab: 516 B
- `U8Array(256)` atom_buf: 260 B
- StringBuffer (流し込み): 1 KB ぐらい
- SourceReader 内部バッファ: 4 KB
- runtime kmalloc 簿記: 残り

`live=272 B` (parse.tc 等で取れる exit 時の値) は SourceReader / atom_buf
の delete し忘れの leak。実害はない。

### 2. typecheck (717 KB → 80 KB)

障害物は forward fn / struct 参照 だけ。**ステージを 2 プロセスに分割**
して逃がす (= sh の `<` / `>` redirect で中間ファイルを挟む既存パターンを
そのまま流用)。

#### パイプラインの新形

```
parse    < a.tc  > a.ast
sigscan  < a.ast > a.th
{ <(emit_imports a.deps) ; printf "(self\n"; cat a.th ; printf ")\n" ; cat a.ast } | tcheck > a.tast
```

実装上は **argv は使わず、stdin に 3 段ラッパーを cat する** (driver script
が組み立てる)。bootstrap/crt0.s が argv を渡さないので host で argv 経由が
使えないのと、(imports ...) 形式が typecheck.tc で既に動いている自然な
延長だから。`asm-pass2` が `--lab` を取りたい段で sh argv 化 (#53) と
crt0 拡張をまとめてやる。

#### .th フォーマットの拡張

現状の .th は **export されたシンボルしか含んでいない** (extract_sigs の
本来の用途が「import 先に公開する API」なので)。tcheck の自己 forward
参照解決には足りない。**`docs/ast_format.md` の「拡張 .th」節**で正式
仕様を定義済み。要点:

- `(fn name ...)` (annotation 無し) — 非 export 関数 (旧 .th では捨てて
  いた)。**parser が struct から自動生成する constructor / getter /
  setter / `delete` / `XxxArray` / `len` / `get` / `set` も全部ここに
  含まれる** ので、struct のフィールド情報を別途 .th に持つ必要はない
- `(struct Name)` — 旧 .th と同じ「型名のみ」の形のまま
- `(var_decl ...)` — トップレベル global 変数

つまり sigscan は **「extract_sigs から `:export` フィルタを外した
だけ」** に近い。

tcheck 側の挙動 (stdin 3 段ラッパー):

- **`(imports (program ...) (program ...))`** (1 個必須、空も可):
  各子 `(program ...)` は import される .th。中の `(fn:export ...)` のみ
  register、非 export と global var は無視
- **`(self (program ...))`** (1 個必須、空も可): 自分自身の sigscan 出力。
  全 top-level fn と struct を register。global var だけは pre-register
  しない (typecheck.tc が source 順 var_add しているのに合わせる、後述)
- **`(program ...)`**: 主入力 .ast。top-level 1 個ずつ stream で読み、
  per-fn check + write_node + reset_node_pool

互換性:

- bootstrap の `extract_sigs.c` / Gen2 の `extract_sigs.tc` は触らない。
  Gen1 経路 (`make test` の typecheck) は引き続き旧 .th + 旧 typecheck
- 新 sigscan は別バイナリ。`compile-gen2.sh` の typecheck split 経路で
  のみ呼び出す
- 既存の `golden/tc/*.th` は extract_sigs 由来なので壊れない

#### 内部実装 (#50 / #51 / #62 / #63 完了済)

- **sigscan** (`compiler/sigscan.tc`, #50): per-top-level reset で 1 個
  ずつ stream read。should_keep() でブロック / フィールド / 式を skip。
  詳細は §1.5
- **tcheck** (`compiler/tcheck.tc`, #51): typecheck.tc を雛形に refactor。
  ラッパー parser (`read_open_kind` / `read_close_paren` /
  `read_imports_wrapper` / `read_self_wrapper`) を追加し、main を
  4 phase 化 (imports → self → program 開く → stream loop → 閉じる)。
  check_expr / check_stmt / check_fn 等の本体ロジックは無変更
- 出力 (.tast) は typecheck.tc と byte-identical (47 ファイルで diff
  harness が green)

#### 既存 typecheck.tc との互換性 quirk

typecheck.tc は `check_program` 内で global の `var_add` を **source 順**
で行うため、ファイル後半で var_decl される global を前半の fn が assign
していると、その assign は annot されない (var_find が失敗するため)。
asm.tc の `(assign g_mem_reg ...)` で 1 件確認した。

tcheck で global を pre-register すると ALL の forward 参照が解決されて
しまい、annot が付いて diff が出るので、tcheck も globals は pre-register
せず main loop で source 順に var_add するように合わせている (collect_self_th
は globals を skip)。

#### 実測 (**2026-04-15 / commit 5ee10a4**、Gen3 tcheck + qemu-riscv32 / km_dump_peak)

Gen3 tcheck (compile-gen2.sh で build、実 runtime.tc link) を 14 個の
.tc 入力で実行した peak。extract_sigs.tc / typecheck.tc / asm.tc は
削除済なので無し:

| 入力 | km peak |
|---|---:|
| compiler/strlib.tc        |  **75316 B** |
| compiler/ast_node.tc      |  79352 B |
| compiler/asm_pass1.tc     |  80412 B |
| compiler/string_buffer.tc |  82624 B |
| compiler/source_reader.tc |  82808 B |
| compiler/runtime.tc       |  89968 B |
| compiler/asm_pass2.tc     |  94256 B |
| compiler/sigscan.tc       | 106820 B |
| compiler/tcheck.tc        | 119608 B |
| compiler/codegen.tc       | 134804 B |
| compiler/parse.tc         | 149836 B |
| compiler/bc2asm.tc        | 189652 B |
| compiler/asm_common.tc    | 191040 B |
| **compiler/bcrun.tc**     | **249808 B** (~244 KB) |

実装上の固定 buffer:

- `nodes: AstNodeArray(3072)` → refs 12 KB + live ~2581 × ~36 B = ~93 KB
- `strtab: U8Array(32768)` → 32 KB (per-fn rollback で sp は 25 KB 以下)
- `fntab: U32Array(256)` → 1 KB ハンドル + per-fn kmalloc ~10 KB
- `vartab: I32Array(640)` → 2.5 KB
- `atom_buf: U8Array(1024)` → 1 KB
- 入出力 + scratch: ~10 KB

**合計 静的 ≈ 49 KB** + per-fn entries ~10 KB = 約 60 KB。worst case
の live AstNode (vm_run 用 ~93 KB) を加えて合計 ~150 KB を下限に、
~250 KB が `make test` で見える上限 (= bcrun.tc)。

#### 残るボトルネック

1. **AstNode pool の bcrun.tc::vm_run 用 3072 slot** (-90 KB): 他のファイル
   の peak 1696 (asm.tc) と比較して vm_run だけが突出。pool を per-fn で
   shrink/grow できると bcrun も他と同じレベルに落ちる。動的成長は
   AstNode 参照を pool index で持っている関係で生ポインタを invalidate
   しないが、構造は大規模変更になる
2. **strtab 32 KB** はまだ余地あり: per-fn rollback で sp の高水位は
   ~25 KB なので、もう少し絞れる (例 28 KB) が誤差レベル
3. **vartab / atom_buf** は十分小さく、いじっても効果限定的

**現時点の 75〜251 KB は phase 7 の 256 KB task 枠には収まる**。pico2
セルフホスト (~100 KB 目標) には (1) の AstNode pool 改修が要るが、
これはデッドラインのある作業ではないので #64 完了で一旦止める。

### 3. codegen (303 KB → 50 KB)

障害物無し。固定 strtab(256K) を縮めるだけ。**動的成長は使わない**:

- **strtab → per-identifier kmalloc**: typecheck と同じ方針。識別子 1 つ
  ごとに kmalloc。symbol entry は (name_ptr, kind, etc) を持つ。
- **locals 2048 × 4 → 1 関数分のみ**: 関数を跨いで locals を持つ必要は
  無いので、関数開始時に固定 256 entry の I32Array を取り、関数末端で
  reset (ゼロクリア + 使用 cnt を 0 に)。U8Array/I32Array の中身を
  reset するだけなので handle は不変。
- **AstNodeArray(4096) は維持** (16 KB refs、per-function reset 既存)。
  あるいは 1024 slot に絞って 4 KB でも実害は無さそう。

#### 見積もり

- AstNode pool refs: 4 KB
- 1 関数分 locals: 1 KB
- per-identifier alloc 累計: ~10 KB
- 入出力バッファ + scratch: ~10 KB
- 雑多: ~15 KB
- **合計 ≈ 40〜50 KB**

### 4. bc2asm (1.4 MB → 40 KB)

障害物は function-local な forward jump のみ。**per-function emission**
にして関数末端で全部リセット:

- `.fn` directive を読んだら 1 関数分の instructions を I32Array(4096)
  (= 16 KB、1 関数 1000 命令まで余裕) に溜める。
- 関数末端 (`.endfn`) で label offsets を確定して assembly を emit、
  バッファをそのまま reset (再 alloc しない、cnt を 0 にするだけ)。

#### 実は bc2asm はモジュール状態を持つ必要が**ない**

現状の `fns: BcFuncArray(256)` (256 関数分の表) は「全関数 parse → 全関数
emit」というアーキテクチャの副産物。streaming にすると **どの関数の
名前も持たなくて良い**:

- **`call foo` の符号化**: bc2asm は `call foo` というアセンブリのテキスト
  を吐くだけ。`foo` がどこにあるかを知る必要はない (= asm の仕事)。
- **自分自身の prologue / 名前**: 「現在 emit 中の 1 関数」のみライブ。
- **forward call**: アセンブリレベルでは単なるラベル参照。bc2asm は何の
  情報も追加しない。

global var と string literal も同じ理屈で持たなくて良い:

- **`.global foo`**: 見た瞬間に `.data\n.globl foo\nfoo: .word X\n.text\n`
  を吐く。section が text と data を行き来するが、asm.tc は section を
  reorder してくれるので問題なし。
- **`.string N "..."`**: bc 形式では先頭にまとまっている。見た瞬間に
  `.section .rodata\n__unit_strobjN: .word L\n.string "..."\n.text\n`
  を吐く。後で出てくる `OP_PUSH_STR N` は bytecode に N が直接埋まって
  いるので、emit 時に `la t0, __unit_strobjN` というラベル名を組み立て
  るだけで、literal の内容を覚えておく必要はない。

唯一の論点は `__unit_strobj<N>` の `unit` 部分。今の #21 修正は「最初の
関数名」を使っているが、それだと「最初の .fn を見るまで literal を
buffer する」が要る。**`bc2asm --unit foo` を argv で渡す**方が小さい:
build script (compile-gen2.sh) は unit 名を必ず知っている。

#### 見積もり (1 関数 emit 中の peak)

- 現在の 1 関数 BcFunc + 名前 string: ~50 B
- 現在の関数の instrs (固定 4096 entry × 16 B): 16 KB
- 現在の関数の label_pcs (固定 256 entry): 1 KB
- 現在の関数の params/locals (固定 256 × 8 B 各): 4 KB
- unit 名 (argv): ~32 B
- 入出力バッファ + tok: 8 KB
- 雑多 (sb header 等): ~5 KB
- **合計 ≈ 35 KB**

### 5. asm (9.5 MB → 80 KB)

障害物は:

1. **全 label を集めないと pass 2 の命令エンコードが決まらない**
   (関数間の `call foo` / `la global_var` / `.word symbol`)
2. **ELF ヘッダに全セクションの size を書かないといけない**
3. 入力 (g_lines 4 MB) と 出力 (g_code 4 MB) を丸ごと持っている

**ステージ分割で逃がす** (typecheck と同じ手):

#### パイプラインの新形

```
asm-pass1  < full.s              > full.lab
asm-pass2  -l full.lab < full.s  > out.bin
```

- **asm-pass1 (label collector)**: stream で .s を 1 行ずつ読み、
  各セクションの `g_pos` を進めながら label 定義を見つけたら
  `(name, section, offset)` を出力。出力フォーマットは 1 行 1 label の
  テキストか、固定長バイナリ。シンボル table は **per-name kmalloc**。
  数値ラベル (0:〜9:) はテキスト位置と一緒に出す。最後の行で各
  セクションの最終 size と ELF ヘッダ用メタ情報も書く。
- **asm-pass2 (encoder)**: 起動時に `.lab` を読み込んで in-memory な
  symbol table に展開 (per-name kmalloc)。stdin の .s を再度 stream
  読みして、各命令を符号化して **stdout に直接 stream emit**。先頭の
  ELF ヘッダは pass1 が出した size メタ情報を使って先に emit できる
  ので、g_code バッファは不要。

両プロセスとも g_lines / g_code を持たない。symbol table はその時々で
kmalloc する 1024 個程度の薄いハンドル列のみ。

#### 既存 asm.tc の構造を流用しやすい点

- pass 1 / pass 2 の論理は **そのまま**。今 1 つのプロセスでループ 2 回
  回している部分を、別バイナリの main に切り出す。共通ロジックは
  `compiler/asm_common.tc` に括り出して両者から import。
- ELF 出力ヘルパー (`write_elf` 相当) は asm-pass2 のみで使う。
- pass1 が `.lab` をテキストフォーマットで出すと debug が楽。
  例: `__main_strobj0:R:0x18` のような行。

#### sh のリダイレクトで完結するか

現状 sh は `<` / `>` の 2 種しかなく、`asm-pass2 -l a.lab < b.s > out`
の形は **追加引数 `-l a.lab`** がそのまま取れない。`spawn(path, argv,
in_path, out_path)` の argv が 1 要素以上を取れる必要がある。

→ phase 7 で kernel 側 `sys_spawn_handler` が argv を StringArray clone
する仕組みは既にある (`kernel/loader.tc` の clone_argv)。sh.tc の
parser を「コマンド名 + 残り token を argv に積む」に拡張すれば対応可。
これは **本計画の subtask "sh argv 化"** として独立に進められる。

#### 見積もり

asm-pass1 (label collector):

- symbol table (per-name kmalloc 累計): 1024 label × 平均 24 B = 24 KB
- 数値ラベル: 4 KB
- 1 行バッファ + tok: 8 KB
- 雑多: ~10 KB
- **合計 ≈ 45 KB**

asm-pass2 (encoder):

- symbol table (.lab を展開): 24 KB
- 1 行バッファ + tok: 8 KB
- ELF ヘッダ scratch: 1 KB
- 雑多: ~10 KB
- **合計 ≈ 45 KB**

---

## 横断的に必要な下地 (新規実装)

### T1. per-item kmalloc symbol table パターン

各ステージの strtab / fntab / labels を「巨大固定 U8Array/I32Array」から
「per-item kmalloc + 薄いハンドル配列」に切り替えるための共通パターンを
**先に決めて文書化**しておく。動的成長配列は使わない (TC では U8Array
ハンドルが kmalloc アドレスそのもので、再 alloc すると既存参照が dangle)。

設計の骨格:

- 識別子文字列は 1 つ 1 つ独立 kmalloc。長さ + データの inline で
  `[len:i32, bytes...]` の形 (StringLiteral と同じレイアウト) が使い
  回せる。free は kfree 1 発。
- symbol table は固定サイズ (例 256 entry) の `U32Array` を 2 本: 1 本に
  name handle、もう 1 本に kind/type コードを入れる。そろそろ struct
  化したいが、今は 2 本でも問題ない。
- 256 entry を超えそうなら struct ベースの linked list 拡張に逃げる。
  自分自身の compiler ソースで実測して 256 で足りるか確認しておく。

→ 共通ライブラリ (`compiler/symtab.tc` 新設) として export しておくと
typecheck / codegen / bc2asm / asm-pass1/2 でみんな使える。

### T2. ステージ分割の sh 側準備

新しい中間ファイルを sh から呼べるように:

- `sh` の引数パーサを `<コマンド> [arg]* [< in] [> out]` に拡張
  (現状はコマンド + 0/1 引数 + リダイレクト)。argv は kernel 側
  `clone_argv` で既に StringArray にできるので、sh 側のトークナイズだけ
  追加すれば良い。
- `compile-gen2.sh` (ホスト側) のパイプラインも 2 行追加。
- `make test` (Gen1) は影響しない (Gen1 は今のまま 1 プロセス typecheck)。

### T2.5. .th フォーマット拡張

タスクとしては小さいが、sigscan / tcheck より先に決めて
`docs/ast_format.md` を更新する必要がある。順序:

1. `(fn name ...)` (annotation 無し) を非 export 関数として使えるようにする
2. `(struct Name (fields (field f1 (type ..)) ...))` のフィールド入りを
   許容する (現状の `(struct Name)` も互換のため受理)
3. `(global name (type ..) (init ..))` を新規追加
4. typecheck 側の import .th 読み込みを「`:export` のみ register」に
   明示する (たぶん現状もそうだが要確認)
5. tcheck の self .th 読み込みは「全部 register」

bootstrap 側 (`bootstrap/extract_sigs.c`) は当面いじらず、Gen1 経路は
旧 .th フォーマット (export のみ) を使い続ける。Gen2 経路で sigscan が
拡張版 .th を使う。golden ファイルは Gen1 由来なので影響なし。

### T3. mtfs に新タスクを追加

- `sigscan` (extract_sigs.tc を symlink)
- `asm-pass1` / `asm-pass2` (新規)
- `tcheck` (typecheck.tc から派生)

これらを `EXTRA_TASKS` で `kernel/build.sh` に追加。phase 7 と同じ手順
なので追加コストは低い。

### T4. (将来) lseek / pwrite syscall

本計画の **stream 2 プロセス分離では不要**。tmpfs 経由で中間ファイルを
渡せば seek 不要。phase 8 で vfs を拡張する際にまとめてやる。

---

## 現在の状況 (2026-04-15)

Phase 1 (typecheck 分割) + Phase 2 (asm 分割) + Phase 3 (in-place shrinks)
が全部 green。OS 上でも test_phase7.sh の 4 ステージが通る。残り作業:

- **compile-gen2.sh の新パス migration (#61 後半)**: 現状は compile-gen2.sh
  が旧 `typecheck` + 旧 `asm` を Gen2 binary として使っている。sigscan +
  tcheck + asm-pass1 + asm-pass2 に切り替えれば compiler/typecheck.tc と
  compiler/asm.tc を削除できる。touch する必要があるのは:
  - `compile-gen2.sh` (asm 呼び出しを asm-pass1 + asm-pass2 経由に、typecheck
    呼び出しを sigscan + tcheck 経由に)
  - `compile-gen3.sh` (同様)
  - `tests/test_common.sh::ensure_gen2_tools` (build 対象の追加)
  - `tests/test_gen3.sh` (Gen2/3 の呼び出しで使われている)
  - `tests/test_asm.sh` (asm 呼び出し)
  - `tc_run.sh` / `tc_asm.sh` (legacy スクリプト)
  .tast/.bc/.ELF は byte-identical が diff harness で確認済なので安全だが
  触るファイル数が多い。単独のコミットで実施する
- **asm-pass2 の g_code 4 MB 廃止 (stream-emit)**: ELF header 用の filesz
  を asm-pass1 が .lab に書く → asm-pass2 はヘッダを upfront 出力してから
  code を stream emit。4.6 MB → ~500 KB 見込み
- **bcrun.tc::vm_run 由来の AstNode pool outlier**: tcheck/codegen/bc2asm
  どれも bcrun.tc で peak が跳ね上がるのは vm_run の巨大 switch body に
  AST ノードが 2581 個取られているから。根治には source 分解が必要で
  (ユーザ指示で) out of scope。現状の 252 KB peak は phase 7 OS の 16 MB
  task RAM 枠には収まるので production code は困らない

## 実装順序 (リスク低・効果高の順)

各ステップは独立にコミット可能。「X KB → Y KB」を commit message に
記録する。`km_dump_peak` が exit 時に peak を stderr に出すので
`tests/test_phase7.sh` をそのまま回帰計測に使える。

0. **T1 symtab 設計の確定**: 先に「per-item kmalloc + 薄いハンドル配列」の
   API を `compiler/symtab.tc` に書いて 1 つのステージで試す。最初の
   消費者は codegen が小さくて良い。小さいので半日〜1 日。
1. **codegen shrink**: 固定 256 KB strtab を per-identifier kmalloc に
   差し替える。AST pool は既に per-function reset あり。低リスク・
   小規模。**303 KB → 50 KB** 見込み。
2. **bc2asm per-function emission**: 1.4 MB → 40 KB が一番インパクト大。
   構造変更だが機能は bc2asm 内で閉じる。関数ごとに instrs / label_pcs
   を **同じハンドルのまま reset** (cnt = 0 にする) するだけ。グローバル
   symbol も per-name kmalloc に切り替え。
3. **sh argv 化 (T2)**: `asm-pass2 -l a.lab < ...` の形を sh が受け取れる
   ようにする。後段で必要になるが、sh 単体で動作確認が完結する。
4. **.th フォーマット拡張 (T2.5)**: `docs/ast_format.md` を更新し、
   bootstrap/typecheck.c と compiler/typecheck.tc が `(fn name ...)` /
   struct fields / `(global ...)` の追加形を読めるようにする (まだ
   sigscan は無い)。テストは extract_sigs を流用して既存 .th が壊れない
   ことの確認まで。
5. **typecheck 分割 (T3)**: sigscan を EXTRA_TASKS に追加 → tcheck を
   typecheck.tc から派生させて per-function stream check 化 → pipeline
   を `parse | sigscan ; tcheck -h *.th < a.ast` に切り替え。 Gen1 は
   触らない。**717 KB → 80 KB**。
6. **asm 分割 (asm-pass1 / asm-pass2)**: 共通ロジックを `asm_common.tc`
   に括り出して 2 バイナリに分ける。`.lab` フォーマットを定義。pass2 は
   出力を直接 stream emit (g_code 廃止)。pass1 は g_lines を持たない
   stream 構造に書き直す。**9.5 MB → 各 50 KB**。最大の効果。
7. **(後回し) assembler / linker 完全分離**: problem.md #7 long term。
   pass1/pass2 が動いてからで良い。

---

## リスクと未解決

- **per-item kmalloc のオーバーヘッド**: 小さい識別子を大量に kmalloc
  すると header 4 B + bucket round-up で実コストが膨らむ。現 kmalloc は
  最小 4 B bucket なので、6 文字の識別子 = 6+4 → 16 B bucket = 20 B
  使う。1000 識別子 = 20 KB。許容範囲。bucket 配置の効率は
  `compiler/runtime.tc` の `kmalloc` 算出をベンチして、必要なら 8/16 B
  の専用 small allocator を追加する。
- **symbol table が 256 entry で足りるか**: コンパイラ自身の最大ファイル
  (parse.tc / asm.tc / typecheck.tc) で実測する必要あり。先に Gen1 で
  「全ファイルの top-level シンボル数」をカウントするスクリプトを書いて
  確認してから固定数を決める。足りなければ struct ベース linked list
  に逃げる。
- **typecheck 分割で .ast を 2 回読む**: sigscan (parse 直後の .ast を
  読む) と tcheck (同じ .ast を再度読む) で **同じ tmpfs ファイルを 2 回
  open する**。ファイルは一度 sigscan に渡って次に tcheck に渡るので、
  parse 出力を `>` で a.ast に書いて 2 回 cat される構造になる。tmpfs は
  既に複数 fd / random open に対応しているので問題ない。

- **.th フォーマットの拡張**: 現状の .th は export のみだが、tcheck は
  自分自身の forward 参照解決のために non-export な fn と global var も
  必要になる。strict superset 拡張 (`(fn name ...)` / `(var_decl ...)`)
  で対応する。`(struct Name)` は型名のみのまま据え置き — struct の
  field 情報は parser がすでに合成 fn (constructor / getter / setter /
  delete / Array 系) として AST に出しているので、それらが `(fn ...)`
  として乗れば自動で struct アクセスが解決できる。tcheck は **`-h
  imports.th` (import) と `-s self.th` (自分自身) を別オプション**で
  受け取り、import からは `:export` のみ register、self からは全部
  register する。詳細は `docs/ast_format.md` 「拡張 .th」節。
- **asm 分割で `.lab` フォーマットを決める必要**: bc 形式や ast 形式と
  同じ「テキスト 1 行 1 entry」で書く案が小さくて済む。仕様は asm-pass1
  実装時に決めて `docs/lab_format.md` に短くまとめる。
- **既存 `make test` が通るか**: Gen1 は変えないので Gen1 単体テストは
  影響無し。Gen2 経由のテスト (`tests/test_pipeline.sh` /
  `tests/test_gen3.sh`) は `compile-gen2.sh` のパイプライン更新にあわせて
  そのまま動く想定。各ステップで `make test` を回して回帰を確認する。
- **bc2asm の section 出力順**: per-function emission では `.text`・
  `.data`・`.section .rodata` がインタリーブして出る (.global 見たら
  即吐き、.string 見たら即吐き、関数本体は .text)。asm.tc は元から
  text → rodata → data → bss に reorder するので最終 ELF レイアウトは
  変わらないが、`.s` 出力をホスト側 GAS でビルドしている経路 (Gen1
  test 等) があれば壊れる可能性がある。Gen1 は bootstrap/bc2asm.c で
  別実装なので影響なし、Gen2 経路は asm.tc しか使わないので OK。

- **bc2asm の `--unit` argv**: bc2asm を `bc2asm --unit foo < a.bc > a.s`
  の形に変える。`compile-gen2.sh` がファイル名から unit 名を導出して
  渡す。OS 上でも sh が argv をサポートすれば同じ呼び出しが通る (sh
  argv 化は本計画の T2 でやる)。Gen1 は `bootstrap/bc2asm.c` 側で同様の
  `--unit` 引数を実装する。

---

## 目標達成後

pico2 (256 KB) で全ステージが走るようになれば、**phase 2.5 (pico2 セルフ
ホスト)** がほぼ手に入る。実際に動かすには K3 (per-task サイズ宣言) で
各コンパイラタスクに適切な task RAM を配る必要がある。K3 と本計画は
同時進行できる独立作業。

また、bc2asm / asm を per-function に再構成した結果、**phase 7 M7
(OS 上で Gen2 → Gen3 一周)** も速度・メモリ両面で現実的になる。

---

## ステージ別実測表 (**2026-04-15 / commit 5ee10a4**)

Gen3 tools を compile-gen2.sh で build し (=compiler/runtime.tc を
link)、qemu-riscv32 で compiler/*.tc (14 ファイル) を各ステージに
食わせた peak メモリ (バイト単位)。host 側の tool 本体が `km_dump_peak`
を呼んで stderr に `[kmem peak=N live=M]` を出すので、そこから回収
した数値。

### codegen

| 入力 | km peak |
|---|---:|
| compiler/strlib.tc        |  **80352 B** |
| compiler/ast_node.tc      |  81664 B |
| compiler/asm_pass1.tc     |  84656 B |
| compiler/source_reader.tc |  86396 B |
| compiler/string_buffer.tc |  87216 B |
| compiler/runtime.tc       |  91716 B |
| compiler/asm_pass2.tc     |  97688 B |
| compiler/sigscan.tc       | 107888 B |
| compiler/tcheck.tc        | 116380 B |
| compiler/bc2asm.tc        | 189276 B |
| compiler/codegen.tc       | 134740 B |
| compiler/parse.tc         | 149996 B |
| compiler/asm_common.tc    | 192148 B |
| **compiler/bcrun.tc**     | **252068 B** (~246 KB) |

### bc2asm

peak が入力にほぼ無関係なのが特徴 (1 関数ずつ emit してリセット
する per-function emission のおかげ):

| 入力 | km peak |
|---|---:|
| compiler/asm_pass1.tc     | **120296 B** |
| compiler/asm_pass2.tc     | 120636 B |
| compiler/sigscan.tc       | 121180 B |
| compiler/codegen.tc       | 122056 B |
| compiler/string_buffer.tc | 122200 B |
| compiler/source_reader.tc | 122336 B |
| compiler/ast_node.tc      | 123356 B |
| compiler/bcrun.tc         | 123756 B |
| compiler/parse.tc         | 124640 B |
| compiler/asm_common.tc    | 124640 B |
| compiler/tcheck.tc        | 125056 B |
| compiler/bc2asm.tc        | 126008 B |
| compiler/runtime.tc       | **126476 B** |

### asm_pass1

`.lab` label collector。入力は **compile-gen2.sh が組み立てた
full.s** (crt0 + runtime + 各 user .s + crt0_data)。上記の 14 ファイル
のうち、compile-gen2.sh が end-to-end で通せる 9 本 (strlib / runtime
のような「main なしライブラリ」は compile-gen2.sh がエラーで止まる
ので計測不能):

| コンパイル対象 | asm_pass1 peak |
|---|---:|
| compiler/runtime.tc       | **407148 B** |
| compiler/strlib.tc        | 410196 B |
| compiler/codegen.tc       | 430692 B |
| compiler/bcrun.tc         | 433412 B |
| compiler/parse.tc         | 433896 B |
| compiler/tcheck.tc        | 435624 B |
| compiler/bc2asm.tc        | 436136 B |
| compiler/asm_pass1.tc     | 442704 B |
| **compiler/asm_pass2.tc** | **445584 B** (~436 KB) |

#### なぜ asm_pass1 がこれだけメモリを食うのか

asm_pass1 は **label 表** が常時支配項で、入力サイズ (crt0 + runtime
+ user 1 ファイル ≈ 50k 行 / 1 MB 台の .s) にほぼ関係なく ~400 KB
台に張り付く。`asm_common.tc::asm_init_common` の固定 BSS 群:

| 変数 | 型 | サイズ | 説明 |
|---|---|---:|---|
| `g_lab_names`    | `U8Array(262144)`      | **256 KB** | 全ラベル名を packed byte pool に詰める共有ストレージ |
| `g_labels`       | `LabelArray(16384)`    | **256 KB** | `Label { name_off, name_len, addr, section }` (4 × i32 = 16 B) × 16384 エントリ |
| `g_numlab`       | `I32Array(10240)`      | ~40 KB  | 数字ラベル 0:〜9: を digit × 1024 枠で持つ。各 digit 1024 個まで |
| `g_line_buf`     | `U8Array(4092)`        | 4 KB    | 1 行ごとの走査バッファ |
| その他 (g_sec_*, g_mnem, g_ops, g_numlab_count, SourceReader) | | ~10 KB | 読み込みバッファや少数の I32Array など |

※ `g_lab_names` と `g_labels` はどちらも `large_alloc` 経路で
`km_align_page` に丸められ、`kmalloc` の peak counter 上では
**それぞれ 260 KB** ほど。この 2 個だけで ~512 KB の upper bound
を決める ("最大 16384 label × 名前 256 KB まで入れられる" という
設計予算)。測定で ~400 KB 台に収まっているのは、runtime / crt0 /
compiler source を合わせても label 数は実際には 16384 までは
埋まらず、一部が bucket 側 (< 4080 B) の小さい allocation に収まる
ため。つまり **measured peak ≈ "大きい 2 つの固定 pool + live bucket"**。

#### 縮めようとすると

- `g_labels = 16384` は、コンパイラ自身を self-host するときの
  ラベル数を upper bound にしている。実測は ~6000 台。4096 や
  2048 まで絞れば 256 KB → 64 KB に落ちる
- `g_lab_names = 256 KB` は packed pool。実測では 64 KB で足りる
  ファイルが多い
- ただし **両方とも** 「固定で 1 発で取る」実装なので、絞りすぎると
  上記 upper bound を超えた時点で OOM する。per-label kmalloc にすれば
  動的に必要な分だけ取れるが、`name_off` を使った直接参照を破壊する
  大改修になる
- `g_numlab = 10240` (10 digit × 1024) も過剰気味。数字ラベルは
  per-function 数個しか出ないので数十で十分。ただし current 4 B ×
  10240 = 40 KB は peak への影響が 10% 未満で優先度低

### asm_pass2

`.lab` + source で encoder。Phase 4 で g_code を
text+rodata+data のセクションサイズ合計で動的確保するように変えた
(旧 MAX_CODE=4 MB 固定は廃止)。peak は compile 対象の binary の
filesz にほぼ比例する:

| コンパイル対象 | asm_pass2 peak |
|---|---:|
| compiler/codegen.tc       | **570060 B** |
| compiler/bcrun.tc         | 577004 B |
| compiler/tcheck.tc        | 595472 B |
| compiler/bc2asm.tc        | 595996 B |
| compiler/asm_pass1.tc     | 618884 B |
| compiler/asm_pass2.tc     | 629956 B |
| **compiler/parse.tc**     | **638800 B** (~624 KB) |

**note**: これは phase 4 完了直後に test_phase7.sh で測った
Hello World ビルドの "441 KB" より大きい。Hello World は text +
rodata + data が小さい (< 10 KB) ので g_code も小さいだけ。
compiler/*.tc は自己ホスト中コードの塊で text+rodata+data が
~300〜400 KB あり、そこが asm_pass2 peak の支配項になる。

pico2 kernel arena (480 KB) にはまだ asm_pass1 はギリギリ入るが、
asm_pass2 (~570 KB+) は入らない。pico2 セルフホストには追加の
shrink か、g_code を stream emit に変える改修が要る。

### 備考

- **parse** (Gen3) は km_dump_peak を呼ばないので自動計測なし。
  Gen1 C ./parse の実測 ~14 KB は固定 SourceReader+tok_buf の
  サイズからほぼ入力に依らず一定
- strlib/runtime の asm_pass2 は「main なしライブラリ単体だと
  compile-gen2.sh が途中でエラー」のため計測不能 (lib 自体が
  self-host で使われるときは上位タスクに含まれるので実害なし)
- 全ステージで bcrun.tc が outlier なのは vm_run 単一関数に
  AST ノードが 2581 集中しているため。ソース分割は意図的に out
  of scope (ユーザ指示)
