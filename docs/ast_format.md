# AST ファイルフォーマット (.ast / .tast / .th)

## 概要

AST は S式（S-expression）のテキスト形式で表現される。
拡張子によって内容が異なるが、フォーマットは共通。

| 拡張子 | 生成元 | 内容 |
|---|---|---|
| `.ast` | parse | 型注釈なし AST |
| `.tast` | typecheck / tcheck | 型注釈付き AST |
| `.th` (旧) | extract-sigs | export シグネチャのみ（AST サブセット） |
| `.th` (拡張) | sigscan | top-level 全部（fn 全て / struct + fields / global）|

## S式の基本構造

```
(kind[:annotation] [value]
  [children...]
)
```

- `kind`: ノード種別（program, fn, struct, var_decl 等）
- `annotation`: `:` の後に付く注釈（`:export`, `:i32` 等）。省略可
- `value`: ノードの値（関数名、変数名、整数値、文字列等）。省略可
- `children`: 子ノード。0個以上

例: `(fn:export emit_char (params ...) (ret ...) (block ...))`

## ノード種別一覧

### トップレベル

| kind | value | children | 説明 |
|---|---|---|---|
| `program` | — | fn, struct, var_decl, import, comment | ルートノード |
| `fn` | 関数名 | params, ret, block | 関数定義。`:export` 注釈あり |
| `struct` | 構造体名 | field* | 構造体定義 |
| `import` | ファイル名 | — | import 宣言 |
| `var_decl` | 変数名 | type [, init_expr] | グローバル/ローカル変数宣言 |
| `comment` | コメント文字列 | — | ソースコメント（`"..."` で囲む） |

### 関数内部

| kind | value | children | 説明 |
|---|---|---|---|
| `params` | — | param* | パラメータリスト |
| `param` | パラメータ名 | type | パラメータ定義 |
| `ret` | — | type | 戻り値型 |
| `block` | — | stmt* | 文のブロック |

### 型

| kind | value | children | 説明 |
|---|---|---|---|
| `type` | 型名 | — | 型参照（i32, u8, StringBuffer 等） |
| `field` | フィールド名 | type | 構造体フィールド |

### 文 (statement)

| kind | value | children | 説明 |
|---|---|---|---|
| `var_decl` | 変数名 | type [, init_expr] | ローカル変数宣言 |
| `assign` | 変数名 | expr | 代入 |
| `call_stmt` | 関数名 | expr* | 関数呼び出し（戻り値破棄） |
| `if` | — | cond, then_block [, else_block] | 条件分岐 |
| `while` | — | cond, body_block | ループ |
| `return` | — | [expr] | return 文 |
| `break` | — | — | break 文 |
| `continue` | — | — | continue 文 |

### 式 (expression)

| kind | value | children | 説明 |
|---|---|---|---|
| `int` | 整数値 | — | 整数リテラル。`:u8` 等の型注釈あり |
| `str` | 文字列値 | — | 文字列リテラル（`"..."` で囲む） |
| `bool` | `true`/`false` | — | 真偽値リテラル |
| `var` | 変数名 | — | 変数参照 |
| `call` | 関数名 | expr* | 関数呼び出し（値を返す） |
| `binop` | 演算子 | left, right | 二項演算（+, -, *, /, %, ==, != 等） |
| `unary` | 演算子 | expr | 単項演算（!, - 等） |
| `cast` | — | expr, type | 型キャスト（`expr as Type`） |

## 型注釈 (annotation)

`:` の後に付くメタデータ。

| 注釈 | 使用箇所 | 意味 |
|---|---|---|
| `:export` | fn | export 関数（import 先から呼べる） |
| `:i32`, `:u8` 等 | int | 整数リテラルの型サフィックス |
| `:TYPE` | .tast の各式ノード | typecheck が付与した式の型 |

## .tast（型付き AST）

typecheck の出力。`.ast` と同じ構造だが、式ノードに型注釈が追加される。

例:
```
(var_decl:i32 result
  (type i32)
  (call:i32 fib
    (int:i32 10)
  )
)
```

## .th（tc header）

`.ast` のサブセットで top-level 宣言だけを残したもの。フォーマットは
通常の AST と同じだが、関数本体 (`block`) は省略される。生成ツールに
よって 2 種類のレベルがある:

### 旧 .th (export シグネチャのみ)

`bootstrap/extract_sigs.c` および `compiler/extract_sigs.tc` の出力。
import 先のモジュールに公開する API のみ。

含むもの:
- `fn:export` — パラメータと戻り値型のみ（block なし）
- `struct` — 型名のみ（field なし）

```
(program
  (struct StringBuffer)
  (fn:export emit_char
    (params
      (param sb
        (type StringBuffer)
      )
      (param c
        (type u8)
      )
    )
    (ret
      (type void)
    )
  )
)
```

### 拡張 .th (top-level 全部)

`compiler/sigscan.tc` の出力。tcheck (= typecheck の per-function
streaming 版) が **自分自身の forward 参照を解決するため**に消費する。
旧 .th の strict superset:

含むもの:
- `fn:export` — export 関数 (旧 .th と同じ)
- `fn` (annotation 無し) — **非 export 関数** (旧 .th では捨てていた)。
  parser が struct から自動生成する **コンストラクタ / getter / setter
  / `delete` / `XxxArray` / `len` / `get` / `set` も全部ここに含まれる**
  (parser はこれらを top-level の `(fn ...)` ノードとして吐く)
- `struct` — **型名のみ** (旧 .th と同じ)。フィールド情報は上記の合成
  関数が代わりに表現するので、`(struct Name (field ...))` のような形は
  使わない
- `var_decl` — トップレベルの global 変数宣言

つまり sigscan は実質「extract_sigs から `:export` フィルタを外した
だけ」になる。

例 (struct + global + 関数 1 つを持つ単純なソースの拡張 .th):

```
(program
  (struct Foo)
  (fn Foo
    (params
      (param __a0 (type i32))
      (param __a1 (type u8))
    )
    (ret (type Foo))
  )
  (fn f1
    (params (param __self (type Foo)))
    (ret (type i32))
  )
  (fn f1
    (params
      (param __self (type Foo))
      (param __v (type i32))
    )
    (ret (type void))
  )
  (fn delete
    (params (param __self (type Foo)))
    (ret (type void))
  )
  (var_decl g_indent
    (type i32)
    (int 0)
  )
  (fn:export emit_char
    (params
      (param sb (type StringBuffer))
      (param c (type u8))
    )
    (ret (type void))
  )
  (fn helper_internal
    (params (param x (type i32)))
    (ret (type i32))
  )
)
```

(`FooArray` / `len` / `get` / `set` の合成 fn は省略)

互換性:

- **旧 .th を期待する読み手 (= 既存 typecheck.tc)** が拡張 .th を読んでも
  動く: `(fn ...)` (annotation 無し) と `(var_decl ...)` を無視して
  `(fn:export ...)` だけ拾えばよい。`(struct Name)` の形は旧 .th と
  同じなのでそのまま使える。
- **tcheck** は旧 .th を読んでも壊れない: `:export` の fn だけ取れれば
  import の用途は満たせる。

## .th の渡し方

### 既存: `(imports ...)` ノード経由 (typecheck.tc)

stdin 先頭に `(imports (program ...) ...)` ブロックを置く方式。
`compile-gen2.sh` がこの形を作る:

```
(imports
  (program
    ... string_buffer.th の内容 ...
  )
  (program
    ... source_reader.th の内容 ...
  )
)
(program
  ... メインファイルの AST ...
)
```

`(imports ...)` がない場合は従来通り `(program ...)` を直接読む。

### 新方式: `-h` / `-s` argv (tcheck)

tcheck は `(imports ...)` を使わず、コマンドライン引数で .th を
受け取る。**`-h` は import の .th**、**`-s` は自分自身の .th** で
役割を明示的に分ける (positional な「最後が self」のような暗黙ルールは
使わない):

```
tcheck -h string_buffer.th -h source_reader.th -s self.th < a.ast > a.tast
```

- **`-s self.th`**: 全 top-level (fn 全部 + struct 型名 + globals) を
  symbol table に登録 → 関数本体を stream check するときの forward
  参照解決に使う。1 つだけ指定可。
- **`-h import.th`** (複数指定可): `(fn:export ...)` のみ register。
  `(fn ...)` (非 export) と global var は無視 (他モジュールから touch
  不可なので不要)。

`-s` 無しで起動された場合は self forward 参照を解決できないので、本体に
self forward 参照を含む .ast には実用的に使えない (= ファイル先頭から
順番にしか定義参照できない、C90 風の宣言要件)。`compile-gen2.sh` /
OS 上の sh は parse → sigscan → tcheck のパイプラインで sigscan の
出力を `-s` に必ず渡す。

## 完全な例

### ソース (fib.tc)
```
fn fib(n: i32) -> i32 {
    if n <= 1 { return n; }
    return fib(n - 1) + fib(n - 2);
}
fn main() -> i32 {
    var result: i32 = fib(10);
    print_i32(result);
    return result;
}
```

### AST (.ast)
```
(program
  (fn fib
    (params
      (param n
        (type i32)
      )
    )
    (ret
      (type i32)
    )
    (block
      (if
        (binop <=
          (var n)
          (int 1)
        )
        (block
          (return
            (var n)
          )
        )
      )
      (return
        (binop +
          (call fib
            (binop -
              (var n)
              (int 1)
            )
          )
          (call fib
            (binop -
              (var n)
              (int 2)
            )
          )
        )
      )
    )
  )
  (fn main
    (params)
    (ret
      (type i32)
    )
    (block
      (var_decl result
        (type i32)
        (call fib
          (int 10)
        )
      )
      (call_stmt print_i32
        (var result)
      )
      (return
        (var result)
      )
    )
  )
)
```
