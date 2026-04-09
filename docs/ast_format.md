# AST ファイルフォーマット (.ast / .tast / .th)

## 概要

AST は S式（S-expression）のテキスト形式で表現される。
拡張子によって内容が異なるが、フォーマットは共通。

| 拡張子 | 生成元 | 内容 |
|---|---|---|
| `.ast` | parse | 型注釈なし AST |
| `.tast` | typecheck | 型注釈付き AST |
| `.th` | extract-sigs | export シグネチャのみ（AST サブセット） |

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

extract-sigs の出力。`.ast` のサブセットで、以下のみ含む:
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

typecheck は `(imports (program ...) (program ...) ...)` ノードで
複数の .th を受け取り、export シグネチャを型環境に登録する。

## (imports ...) ノード

typecheck への入力で、stdin の先頭に置く。通常の `(program ...)` の前に配置。

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

`(imports ...)` がない場合、typecheck は従来通り `(program ...)` を直接読む。

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
