# コンパイラ設計（案）

## パイプライン

各ステージは独立した実行ファイルとして実装し、テキストを標準入出力でやり取りする。
Unix パイプで繋げることも、中間ファイルを保存して個別に確認することもできる。

```
ソースコード (.src)
    ↓ parse（パーサ）
AST テキスト (.ast)
    ↓ typecheck（意味解析・型検査）
型付きAST テキスト (.tast)
    ↓ codegen（バイトコード生成）
バイトコード テキスト (.bc)
    ↓ bcrun（バイトコードインタプリタ）  ← デバッグ・検証用
    ↓ bc2asm（コード生成）
RISC-V アセンブリ (.s)
    ↓ as（アセンブラ）
オブジェクトファイル (.o)
    ↓ ld（リンカ）
実行ファイル
```

### 使用例

```sh
# ステージを個別に実行して中間ファイルを確認
parse foo.src > foo.ast
typecheck foo.ast > foo.tast
codegen foo.tast > foo.bc
bcrun foo.bc                    # バイトコードで動作確認
bc2asm foo.bc > foo.s
as foo.s -o foo.o
ld foo.o -o foo

# パイプで一括実行
parse foo.src | typecheck | codegen | bc2asm | as - -o foo.o
```

## レキサ

- 手書きの状態機械
- トークン種別: キーワード、識別子、整数リテラル、文字列リテラル、演算子、区切り文字

## パーサ（LL(1)）

- 再帰下降パーサ（手書き）
- 先読み1トークンで分岐を決定
- LL(1)を保証するための文法制約（`language.md` 参照）

### 文法（EBNF概略）

```
program     = import* decl*
import      = 'import' STR_LIT
decl        = fn_decl | struct_decl | var_decl
fn_decl     = 'fn' IDENT '(' param_list ')' '->' type block
struct_decl = 'struct' IDENT '{' field_list '}'
var_decl    = 'var' IDENT ':' type ('=' expr)? ';'

block       = '{' stmt* '}'
stmt        = var_decl | if_stmt | while_stmt | return_stmt | ident_stmt
ident_stmt  = IDENT '=' expr ';'             -- 代入文（左辺は識別子のみ）
            | IDENT '(' arg_list ')' ';'     -- 関数呼び出し文
            -- IDENT の次のトークンが '=' か '(' かで確定（実質LL(2)だが手書きパーサで自然に処理可能）
if_stmt     = 'if' expr block ('else' block)?
while_stmt  = 'while' expr block
return_stmt = 'return' expr? ';'

expr        = logic_or
logic_or    = logic_and ('||' logic_and)*
logic_and   = compare ('&&' compare)*
compare     = bit_or (('=='|'!='|'<'|'<='|'>'|'>=') bit_or)?
bit_or      = bit_xor ('|' bit_xor)*
bit_xor     = bit_and ('^' bit_and)*
bit_and     = shift ('&' shift)*
shift       = add (('<<'|'>>') add)*
add         = mul (('+'|'-') mul)*
mul         = unary (('*'|'/'|'%') unary)*
unary       = ('!'|'-'|'*'|'&') unary | postfix
postfix     = primary ('[' expr ']' | '.' IDENT | '(' arg_list ')' | 'as' type)*
primary     = IDENT | INT_LIT | STR_LIT | 'true' | 'false' | '(' expr ')'
```

## AST テキスト形式

`parse` の出力・`typecheck` の入出力はテキスト形式のAST。
人間が読めるため、そのままデバッグ出力として使える。

### 出力形式（S式風インデント）

パース後（型なし）:
```
(fn add (params (a i32) (b i32)) (ret i32)
  (block
    (return
      (add
        (var a)
        (var b)))))
```

型検査後（型付き）:
```
(fn add (params (a i32) (b i32)) (ret i32)
  (block
    (return
      (add:i32
        (var:i32 a)
        (var:i32 b)))))
```

- 型付きASTでは各ノードに `:型` を付加
- ファイル・行番号情報も含める（デバッグ用）

## 意味解析

### 型検査
- 各式に型を付ける（ボトムアップ）
- 代入・演算の型の互換性チェック
- 暗黙の型変換なし（`as` キャストのみ）

### オーバーロード解決
- 関数呼び出し時、引数の型リストで候補を絞り込む
- 完全一致のものを1つ選ぶ（0個または複数ならエラー）
- シンボルテーブルは関数名 → [(引数型リスト, 戻り値型, ラベル)] の形式

### シンボルテーブル
- スコープはブロック単位
- グローバル・ローカルの2層

## スタックベースバイトコード

ASTとRISC-Vアセンブリの間の中間表現。
アーキテクチャ非依存で、後から別ターゲットへの対応も容易になる。
インタプリタのバックエンドとしても使える。

### 設計方針

- 仮想スタックマシン（レジスタなし、スタックで演算）
- **テキスト形式**（アセンブリと同様に人間が読み書きできる）
- スタックの値は**型なし32bit**。型の正しさは意味解析フェーズで保証済み
- 型はオペコードに埋め込む（例: `ADD_I32`, `LT_U32`）
- ローカル変数はインデックスで参照（スロット方式）

### 命令セット（案）

| 命令 | 引数 | 説明 |
|---|---|---|
| `PUSH_I32` | 値 | i32定数をスタックに積む |
| `PUSH_U8` | 値 | u8定数をスタックに積む（他の整数型も同様） |
| `PUSH_STR` | ラベル名 | 文字列定数のアドレスをスタックに積む |
| `LOAD_LOCAL` | スロット番号 | ローカル変数をスタックに積む |
| `STORE_LOCAL` | スロット番号 | スタックトップをローカル変数に書く |
| `LOAD_GLOBAL` | シンボル名 | グローバル変数をスタックに積む |
| `STORE_GLOBAL` | シンボル名 | スタックトップをグローバル変数に書く |
| `LOAD_PTR_I32` | - | スタックトップのアドレスからi32を読む |
| `STORE_PTR_I32` | - | スタックの値をアドレスにi32で書く |
| `ADD_I32`, `SUB_I32`, `MUL_I32`, `DIV_I32`, `MOD_I32` | - | 符号あり算術演算 |
| `ADD_U32`, `SUB_U32`, `MUL_U32`, `DIV_U32`, `MOD_U32` | - | 符号なし算術演算 |
| `AND`, `OR`, `XOR`, `SHL`, `SHR_I32`, `SHR_U32` | - | ビット演算 |
| `EQ`, `NE` | - | 等値比較（型非依存） |
| `LT_I32`, `LE_I32`, `GT_I32`, `GE_I32` | - | 符号あり比較 |
| `LT_U32`, `LE_U32`, `GT_U32`, `GE_U32` | - | 符号なし比較 |
| `NOT`, `NEG_I32` | - | 単項演算 |
| `CAST` | 元の型, 変換先の型 | 型変換（as） |
| `CALL` | マングル名 | 関数呼び出し（引数はスタック上） |
| `RET` | - | 関数から戻る（戻り値はスタックトップ） |
| `JMP` | ラベル | 無条件ジャンプ |
| `JZ` | ラベル | スタックトップが0なら分岐 |
| `JNZ` | ラベル | スタックトップが非0なら分岐 |
| `LABEL` | ラベル名 | ジャンプターゲット |
| `POP` | - | スタックトップを捨てる |
| `ADDR_LOCAL` | スロット番号 | ローカル変数のアドレスをスタックに積む |
| `ADDR_GLOBAL` | シンボル名 | グローバル変数のアドレスをスタックに積む |

### バイトコードテキスト例

```
fn _add__i32_i32:           ; fn add(a: i32, b: i32) -> i32
    LOAD_LOCAL  0           ; a
    LOAD_LOCAL  1           ; b
    ADD_I32
    RET

fn _main:
    PUSH_I32    1
    PUSH_I32    2
    CALL        _add__i32_i32
    STORE_GLOBAL result
    RET
```

## コード生成（バイトコード → RISC-V RV32IM）

バイトコードの各命令をRISC-Vアセンブリに変換する。
バイトコードがスタックベースなので、コード生成はほぼ機械的に行える。

### スタックのマッピング

- 仮想スタックは実際のハードウェアスタック（sp）にマッピング
- 演算のたびに `lw`/`sw` でスタックを読み書き（初期実装はシンプルさ優先）
- 最適化は後のフェーズで対応

### 関数呼び出し規約（RISC-V ABI準拠）
- 引数: a0〜a7（超過分はスタック）
- 戻り値: a0
- caller-saved: t0〜t6, a0〜a7
- callee-saved: s0〜s11, sp, ra

### オーバーロード関数のラベル
- `fn add(i32, i32)` → `_add__i32_i32`
- `fn add(u8, u8)` → `_add__u8_u8`
- マングリングルール: `_関数名__引数型1_引数型2_...`

## アセンブラ

- RISC-V RV32IM 対応
- 2パス（前方参照のラベル解決）
- 出力: ELF形式のオブジェクトファイル（再配置情報付き）
- `riscv32-unknown-elf-as` と同じアセンブリ構文を受け付ける
- GASの出力と照合して検証

## リンカ

- 複数オブジェクトファイルを結合
- シンボル解決と再配置
- 出力: ELF実行ファイル
- GNU ldの出力と照合して検証

### リンカ設定ファイルとリンクモード

リンクには2つのモードがある。

#### カーネルモード（アドレス固定）

カーネルは起動時から決まったアドレスに配置される。
GNU ldのリンカスクリプト相当の設定ファイルでアドレスを指定する。
ターゲット（RP2350実機 / QEMU）ごとに設定ファイルを用意することで
メモリマップの差異を吸収する。

```
# link.cfg（RP2350実機用）
mode    kernel
entry   _start
text    0x10000000  # .text セクションの開始アドレス
data    0x20000000  # .data セクションの開始アドレス
bss     0x20008000  # .bss セクションの開始アドレス
stack   0x20010000  # スタック初期値（カーネル起動時）
heap    0x15000000  # カーネルヒープ（PSRAM キャッシュなし）
```

```
# link.cfg（QEMU virt machine用）
mode    kernel
entry   _start
text    0x80000000
data    0x80100000
bss     0x80200000
stack   0x80400000
heap    0x80500000
```

#### ユーザプロセスモード（PIC）

ユーザプロセスは **PIC（Position Independent Code）** としてコンパイルする。
すべてのアドレス参照をPC相対にするため、ローダは再配置処理が不要になる。

RISC-Vの `auipc` 命令でPC相対アドレスを計算できるため、PICと相性が良い。
グローバル変数が値型のみという制約により、GOTの仕組みも不要でシンプルに実装できる。

```
# link.cfg（ユーザプロセス用、ターゲット共通）
mode    user-pic
entry   main
# アドレス指定なし。すべてのアドレスはPC相対で解決される。
```

`.text` は Flash 上で XIP 実行するためコピーしない。
`.data` / `.bss` のみ PSRAM にコピー・初期化し、`gp`（global pointer, x3）レジスタで参照する。

```
ロード時の処理:
  .text   → Flash上のまま実行（コピーなし）
  .data   → PSRAMにコピー
  .bss    → PSRAMにゼロ初期化
  gp      → .data/.bssの中央付近をローダが設定（±2KBの範囲で全グローバル変数をカバー）
```

コード生成での対応:
- 関数呼び出し: `auipc` + `jalr`（PC相対、.text内）
- グローバル変数アクセス: `lw`/`sw` with `gp` 相対オフセット（`gp` ± 2KB以内）
- 文字列リテラル（`.rodata`）: PC相対参照（.textと同じFlash上に置く）

グローバル変数の合計サイズが4KBを超える場合はコンパイルエラーとする（初期制限）。

リンカはFlash配置用の `.text`/`.rodata` と PSRAM配置用の `.data`/`.bss` を分離したELFを出力する。
再配置エントリは不要。

使用例:

```sh
# カーネルビルド
ld -config link-rp2350.cfg foo.o bar.o -o kernel.elf

# ユーザプロセスビルド
ld -config link-user.cfg foo.o bar.o -o program.elf
```

## ローダ

- ファイルシステムから実行ファイルを読み込む
- 所定のメモリ領域にコピー
- エントリポイントにジャンプ（新プロセスとして起動）
