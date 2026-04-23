# コンパイラ設計

## パイプライン

各ステージは独立した実行ファイルで、テキスト中間形式を stdin/stdout
でやり取りする。Unix パイプで繋げるか、中間ファイルを保存して個別に
確認できる。

```
source.tc
    ↓ parse        (レキサ + LL(1) 再帰下降パーサ)
.ast                (S 式)
    ↓ sigscan      (拡張 .th 抽出: 全 top-level decl)
.th                 (自モジュールのシグネチャ)
    ↓ (imports) + (self .th) + (program .ast) → tcheck
.tast               (型付き AST、per-function 完結)
    ↓ codegen      (スタックマシン IR 生成)
.bc                 (バイトコード)
    ↓ bcrun        (インタプリタ、デバッグ・検証用)
    ↓ bc2asm       (per-function emit)
.s                  (RISC-V アセンブリ)
    ↓ asm_pass1    (ラベル収集 + section 集計)
.lab                (ラベルテーブル + section サイズ)
    ↓ (lab + prelude.s + 各モジュール .s) → asm_pass2
ELF 実行ファイル / raw binary
```

`as` / `ld` は使わない。`asm_pass1` + `asm_pass2` が「アセンブラ兼
リンカ」として section 並べ替え (text → rodata → data → bss) と gp
相対 la の解決を同時に行う。

### 使用例

```sh
# ステージを個別に実行して中間ファイルを確認
./parse foo.tc > foo.ast
./sigscan < foo.ast > foo.th
{ cat imports.th; printf '(self\n'; cat foo.th; printf ')\n'; cat foo.ast; } \
    | ./tcheck > foo.tast
./codegen < foo.tast > foo.bc
./bcrun   < foo.bc            # バイトコードで動作確認
./bc2asm  < foo.bc > foo.s
./asm_pass1 < foo.s > foo.lab
cat foo.lab foo.s | ./asm_pass2 > foo.elf

# パイプで一括実行 (ラップは compile-gen2.sh / compile-gen3.sh)
GEN2_DIR=/tmp/gen2 ./compile-gen2.sh -o foo foo.tc
```

## レキサ / パーサ

- 手書き再帰下降。先読み 1 トークン (LL(1)) で分岐
- ネストなしの struct、expression 優先順位は `docs/language.md` 準拠
- trailing comma 対応 (struct フィールド / fn パラメータ / 関数呼び出し)

## sigscan (拡張 .th)

`.ast` を stream 読みして **モジュールの全 top-level 宣言**
(export / 非 export / struct / グローバル変数) を 1 つの .th に吐く。
旧 `extract-sigs` は export のみだったが、tcheck 内部 per-fn check で
自モジュールの他の top-level も要るので sigscan が拡張 .th を担う。

peak ~10 KB。入力は stream なので AST 全体を一度に保持しない。

## tcheck (streaming)

stdin 形式: `(imports <ext-th*>) (self <ext-th>) (program <ast>)`。

- **imports**: Gen1 `extract-sigs` が import 先 .tc から抽出した .th
  (export シグネチャのみ)
- **self**: 自モジュールの sigscan 出力
- **program**: 自モジュールの .ast 本体

tcheck は (imports) + (self) を 1 度読んで大域環境を作り、program を
per-function で stream 読みする。per-fn strtab rollback + per-fn
kmalloc fntab により peak **75〜252 KB** (旧 monolithic typecheck
の 717 KB 比 ~9 分の 1)。

.tast は `.ast` 各ノードに `:型` アノテーションを付けた形式。
per-function 完結なので後段 codegen も stream 処理できる。

## 意味解析

### 型検査
- 各式に型を付ける (ボトムアップ)
- **暗黙の型変換なし** (`as` キャストのみ)
- ただし整数リテラルはサフィックスなしなら相手型に coerce (2 段階
  オーバーロード解決)

### オーバーロード解決

1. **Phase 1 (exact match)**: 引数の型が完全一致する候補を選ぶ
2. **Phase 2 (literal coercion)**: Phase 1 で見つからなければ、
   サフィックスなし整数リテラル引数を候補の期待型に coerce して再解決

完全一致が 2 個以上、または 0 個ならエラー。

### シンボルテーブル
- スコープはブロック単位 (function / block)
- fntab に関数候補を登録。struct の合成関数はモジュール private
  (export したいときは前方宣言で opt-in、`docs/design_decisions.md` #1)

## codegen (スタックマシンバイトコード)

AST と RISC-V asm の間の中間表現。アーキテクチャ非依存。

- 仮想スタックマシン (レジスタなし)
- **テキスト形式** (人間が読める)
- スタック値は型なし 32 bit。型は意味解析で保証済
- 型情報はオペコード側 (例 `add_i32`, `lt_u32`)
- ローカル変数はスロット番号で参照

per-top-level strtab rollback + 内部バッファ縮小で peak
**80〜252 KB** (Phase 3 で 303 KB → この範囲に)。

命令セットとファイル形式は `docs/bc_format.md` に集約。

## bc2asm (バイトコード → RISC-V asm)

per-function に stream emit。旧 monolithic 版の 1.4 MB 機構を廃止
して **peak 120〜126 KB** (Phase 3 で ~11 分の 1)。

- 仮想スタックは実スタック (sp) にマッピング。各演算で `lw`/`sw`
- RISC-V 呼び出し規約: 引数 a0〜a7、戻り値 a0、caller-saved t0〜t6 +
  a0〜a7、callee-saved s0〜s11 + sp + ra
- eval stack の最大深さを計算して frame_size に含める
- 条件分岐は `bnez/beqz 0f; j target; 0:` パターン (B-type ±4 KB
  制限を回避)
- 関数内ジャンプラベルは `.L_FNAME_pcN` (関数マングル名で global
  一意)
- section 出力順は .text → .data → .rodata (asm_pass2 がフラット
  配置で並べ替える前提)

### オーバーロード関数のマングリング

`fn add(a: i32, b: i32)` → `add__i32__i32`
(関数名 `__` 引数型列)。型同士は `__` で区切る (旧仕様の 1 個
underscore から変更済)。`do_openat__i32__String__i32` など
String / StringLiteral のどちらも同じ mangled suffix を持つものは
`task_crt0.s` が同一本体に alias する。

## asm_pass1 / asm_pass2

このツールチェーンの「アセンブラ兼リンカ」。分離理由はメモリ
(pass1 でラベルを集め、pass2 は source を 3 回 re-scan して stream
emit するため、中間 code buffer を持たずに済む)。

詳細は `docs/lab_format.md`。要点:

- 入力 `.s` を per-section cursor (text / rodata / data / bss) で
  集計し、出力では **text → rodata → data → bss** にフラット配置
- 各 section のサイズは 16 byte align
- asm_pass1 が `.lab` 中間ファイルにラベルテーブルと section
  サイズを吐く。`__global_pointer$` は `data_base + 0x800` で自動
  定義
- asm_pass2 は `.lab` + source × 3 を stdin に受け、3 回 re-scan で
  target section を 4 KB out_buf 経由 stdout に stream emit
- データ参照は **gp 相対 la** (`auipc 0` + `addi rd, gp, off`) に
  展開。12-bit 範囲外は PC 相対 (`auipc` + `addi`) に fallback
- text と data/bss が同じ LOAD segment に入る環境 (Linux / virt)
  では gp 相対版がそのまま通る
- ELF 出力: p_offset=0、ヘッダ + コードを 1 つの LOAD segment。
  末尾の `.space` (`__arena` 等) は filesz に含めず memsz のみ拡張

ピークメモリ: asm_pass1 ~250 KB、asm_pass2 **~260〜280 KB**
(Phase 5 の stream-emit 化で旧 4.6 MB から ~16 分の 1)。

### stdin 先頭ディレクティブ

- `; raw` — ELF ヘッダなしで code 部分だけを raw bin として出力
  (タスクバイナリは常にこれ)
- `; load_base 0xHHHHHHHH` — ELF 出力時の `e_entry` / `p_vaddr` /
  `p_paddr` を指定 (既定 0x10000)

### 対応命令

- 整数 RV32I + M 拡張 (mul / div / rem 系)
- CSR: `csrrw`, `csrrs`, `csrrc`, `csrr` (疑似), `csrw` (疑似),
  `mret`
- `jalr rd, rs1, imm` (I-type 間接ジャンプ)
- `.byte val[,val...]` (1 行 4 byte まで)、`.rodata` 短縮形

数字ラベル (`0:` 〜 `9:`) 対応: pass1 で定義収集、pass2 で参照解決
(各 digit 最大 1024 個)。`bnez / beqz / j 0f` が関数境界を越えて
衝突しない。

## asm_pass1 / asm_pass2 を使うラッパ

日常の build は以下のラッパを使う。

```bash
# Gen1 (C) ツールで .tc → RV32 ELF (Gen2 生成用)
./compile-gen1.sh -o output file.tc

# Gen2 (TC 自己ホスト) ツールで .tc → RV32 ELF (Gen3 生成 / kernel 用)
GEN2_DIR=/path/to/gen2 ./compile-gen2.sh -o output file.tc

# Gen3 検証用
GEN3_DIR=/path/to/gen3 ./compile-gen3.sh -o output file.tc
```

`compile-gen2.sh` の環境変数:

- `CRT0` — `.s` パス。既定 `compiler/crt0_tc.s` (Linux ELF 用)
- `CRT0_DATA` — `.s` パス。既定 `compiler/crt0_tc_data.s`
- `ASM_PROLOGUE` — asm 入力先頭に注入する 1 行 (例 `; raw`)
- `GEN2_DIR` — Gen2 ツール (parse / sigscan / tcheck / codegen /
  bc2asm / asm_pass1 / asm_pass2) の置き場所

kernel タスクのビルドでは `ASM_PROLOGUE='; raw'` + `CRT0=task_crt0.s`
+ `CRT0_DATA=task_data.s` で呼ぶ。詳細は `kernel/build.sh` と
Makefile を参照。

## 世代の定義

- **Gen1**: `bootstrap/*.c` を GCC で x86_64 にビルドしたもの
- **Gen2**: `compiler/*.tc` を Gen1 で RV32 ELF にビルドしたもの
  (`compile-gen1.sh`)
- **Gen3**: `compiler/*.tc` を Gen2 で RV32 ELF にビルドしたもの
  (`compile-gen2.sh`)

自己ホスト確認は Gen2 == Gen3 の BC/ASM 一致を
`tests/test_gen3.sh` が CI で検証。
