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

| ステージ | 現在 | 目標 | 主なやること |
|---|---:|---:|---|
| parse     |  14 KB |  15 KB | 維持 |
| sigscan   | (新規) |  20 KB | extract_sigs.tc を OS タスク化 |
| tcheck    | 717 KB |  80 KB | typecheck から派生、symbol を per-item kmalloc、関数ごとに stream check |
| codegen   | 303 KB |  50 KB | strtab を per-identifier kmalloc、locals は per-function reset |
| bc2asm    | 1.4 MB |  35 KB | **per-function emission** + global symbol table 廃止 (関数名・global var・literal は seen-time に即 emit) |
| asm-pass1 | (新規) |  45 KB | asm から派生、label collector のみ。`.lab` を出力 |
| asm-pass2 | (新規) |  45 KB | asm から派生、`.lab` を読んで encoder。出力は stream emit |

「動的成長配列」は使わない。固定で十分小さく取れるものは固定 (instrs:
1 関数 4096 entry など)、可変なものは「**1 個ごとに kmalloc**」する
(識別子文字列、symbol entry、ラベル名など)。U8Array/I32Array のハンドル
は再 alloc しないので、生ポインタを取っているコードを壊す心配がない。

順次実行なので合計値の意味は薄く、**最大 80 KB** が pico2 の枠を決める。

---

## ステージごとの具体策

### 1. parse (14 KB → 15 KB)

何もしない。lexer の tok_buf を必要なら拡張する程度。

### 2. typecheck (717 KB → 80 KB)

障害物は forward fn / struct 参照 だけ。**ステージを 2 プロセスに分割**
して逃がす (= sh の `<` / `>` redirect で中間ファイルを挟む既存パターンを
そのまま流用)。

#### パイプラインの新形

```
parse      < a.tc                  > a.ast
sigscan    < a.ast                 > a.th       (= extract_sigs.tc を OS タスク化)
tcheck     -h a.th < a.ast         > a.tast
```

- **sigscan**: 既存の `compiler/extract_sigs.tc` をタスクとして mtfs に
  載せるだけで実体はほぼ揃っている。AST を stream 読みして top-level
  (fn シグネチャ / struct / global var) だけを `.th` に書く。本体は
  捨てる。AstNode pool は top-level 1 個分 (~500 slot ≈ 18 KB) で済む。
- **tcheck**: 起動時に `-h a.th` で渡された .th を読み込んで symbol
  table を作る。**ここはモジュール全体ぶんを kmalloc per-item で持つ
  のが許容**: 100 関数 × ~150 B = 15 KB。さらに stdin (a.ast) を stream
  読みし、関数 1 個分の AST を pool に貯め → check → .tast 出力 → pool
  reset。1 関数あたり worst-case 1000 ノード ≈ 36 KB。

#### 個々のテーブルをやめて per-item kmalloc に

現状 typecheck の strtab(512K) と fntab(113K) は「最悪を想定した固定」。
代わりに per-function / per-symbol で kmalloc する:

- **identifier**: 文字列ごとに `kmalloc(len + 4)` で個別オブジェクト。
  symbol table は `{name_ptr: u32, len: i32, kind: i32}` の薄い entry
  だけ持つ。string interning はしない (重複コピーの方が安い) 。
  StringRef のような 1-2 word の handle で参照できれば既存の
  `(ss, sl)` ペアに直接マップできる。
- **fn signature**: `struct FnSig { name: u32, ret_type: i32, nparam: i32,
  param_base: u32, ... }` を関数ごとに 1 つ kmalloc。`param_base` は
  `kmalloc(nparam * 8)` への先頭。可変長部分はそれ自体が 1 つの
  kmalloc 区画なので growth で動く必要はない。
- **AstNode pool**: もとから per-node kmalloc 風の構造 (`AstNodeArray`
  の slot をリセットする)。pool slot 数を 1024 程度に下げる。

#### 見積もり (tcheck 実行中の peak)

- symbol table 本体: 100 関数 × ~150 B = 15 KB
- 1 関数分の AstNode pool: 1024 slot × ~40 B = 40 KB
- 入出力バッファ: 8 KB
- 雑多な scratch (atom_buf, ob): ~10 KB
- **合計 ≈ 75 KB**

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
4. **typecheck 分割 (T3)**: sigscan を EXTRA_TASKS に追加 → tcheck を
   typecheck.tc から派生させて per-function stream check 化 → pipeline
   を `parse | sigscan ; tcheck -h *.th < a.ast` に切り替え。 Gen1 は
   触らない。**717 KB → 80 KB**。
5. **asm 分割 (asm-pass1 / asm-pass2)**: 共通ロジックを `asm_common.tc`
   に括り出して 2 バイナリに分ける。`.lab` フォーマットを定義。pass2 は
   出力を直接 stream emit (g_code 廃止)。pass1 は g_lines を持たない
   stream 構造に書き直す。**9.5 MB → 各 50 KB**。最大の効果。
6. **(後回し) assembler / linker 完全分離**: problem.md #7 long term。
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
