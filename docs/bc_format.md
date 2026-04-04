# .bc バイトコードファイル仕様

tinyc コンパイラが生成するバイトコード（`.bc`）フォーマットの仕様。

---

## 概要

`.bc` ファイルはスタックマシン用テキスト形式のバイトコード。`codegen` ツールが tinyc ソースから生成し、`bcrun`（インタープリタ）または `bc2asm`（RISC-V アセンブリ変換）が読み込む。

---

## ファイル構造

```
.bc                                  ← ヘッダー（必須・1行目）

; コメント                            ← セミコロンで始まる行はコメント

.string 0 "..."                      ← 文字列テーブル（0個以上）
.string 1 "..."

.global NAME TYPE INITVAL            ← グローバル変数宣言（0個以上）

.fn NAME ARG_TYPE... RET_TYPE        ← 関数定義（1個以上）
.param PNAME TYPE
.local LNAME TYPE
  命令
  ...
.endfn

.endbc                               ← 終端マーカー（プログラムの標準入力はここ以降）
```

---

## ディレクティブ

### `.bc`
ファイルの先頭に必ず記述するヘッダー。

### `.string INDEX "VALUE"`
文字列リテラルテーブルへの登録。`INDEX` は 0 始まりの整数。`VALUE` は C スタイルのエスケープシーケンスを使用（`\n`, `\t`, `\\`, `\"` など）。

```
.string 0 "Hello, World\n"
.string 1 "Error: "
```

### `.global NAME TYPE INITVAL`
グローバル変数の宣言と初期値（整数のみ）。`TYPE` は型名（`i32`, `u8`, `U8Array` など）。

```
.global count i32 0
```

### `.fn NAME ARG_TYPE... RET_TYPE`
関数定義の開始。引数の型を列挙し、最後のトークンが戻り値の型。
引数なしの場合は `NAME RET_TYPE` の 2 トークン。
bc2asm / bcrun はこの行からマングル名を計算する（`NAME__ARG1__ARG2...`）。

```
.fn fib i32 i32          ← 引数 1 つ(i32)、戻り値 i32
.fn to_buf String U8Array ← 引数 1 つ(String)、戻り値 U8Array
.fn main i32              ← 引数なし、戻り値 i32
```

### `.param NAME TYPE`
関数の引数宣言（`.fn` 直後）。引数順に並べる。

```
.param n i32
```

### `.local NAME TYPE`
関数内ローカル変数の宣言。

```
.local buf U8Array
.local i i32
```

### `.endfn`
関数定義の終了。

### `.endbc`
バイトコードの終端マーカー。`bcrun` はこの行以降を実行プログラムの標準入力として扱う。

---

## ラベル

`__Lnn:` 形式（`nn` は数字列）のラベルを行頭に記述する。

```
__L0:
  load i
  push_int 10
  lt
  jump_ifnot __L1
  jump __L0
__L1:
```

---

## 命令一覧

### スタック操作

| 命令 | 引数 | 説明 |
|------|------|------|
| `push_int N` | 整数 | 整数値 N をスタックに積む |
| `push_str I` | インデックス | 文字列リテラル I (`.string` テーブルの添字) をスタックに積む |
| `pop` | なし | スタックトップを捨てる |

### 変数アクセス

| 命令 | 引数 | 説明 |
|------|------|------|
| `load NAME` | 変数名 | ローカル/グローバル変数 NAME をスタックに積む |
| `store NAME` | 変数名 | スタックトップを変数 NAME に格納し、pop する |

### 演算（2引数は `sub A B` = A - B の順でスタックから取る）

| 命令 | 説明 |
|------|------|
| `add` | 加算 |
| `sub` | 減算 |
| `mul` | 乗算 |
| `div` | 除算 |
| `mod` | 剰余 |
| `and` | ビット AND |
| `or` | ビット OR |
| `xor` | ビット XOR |
| `shl` | 左シフト |
| `shr` | 右シフト |
| `neg` | 単項マイナス |
| `lnot` | 論理 NOT（0→1, 非0→0） |

### 比較（結果: 真=1, 偽=0）

| 命令 | 説明 |
|------|------|
| `eq` | == |
| `ne` | != |
| `lt` | < |
| `le` | <= |
| `gt` | > |
| `ge` | >= |

### 制御フロー

| 命令 | 引数 | 説明 |
|------|------|------|
| `jump LABEL` | ラベル名 | 無条件ジャンプ |
| `jump_if LABEL` | ラベル名 | スタックトップが真ならジャンプ（pop する） |
| `jump_ifnot LABEL` | ラベル名 | スタックトップが偽ならジャンプ（pop する） |
| `return` | なし | スタックトップの値を返す |
| `return_void` | なし | void を返す |

### 関数呼び出し

| 命令 | 引数 | 説明 |
|------|------|------|
| `call NAME ARG_TYPE...` | 関数名・引数の型リスト | 型リストの個数分をスタックから引数として NAME を呼び出し、結果をスタックに積む。bc2asm/bcrun が内部でマングル名（`NAME__TYPE1__TYPE2...`）に変換して呼び出す |

### 型変換

| 命令 | 引数 | 説明 |
|------|------|------|
| `cast TYPE` | 型名 | スタックトップを TYPE に変換 |

---

## 組み込み関数（`call` で呼び出し可能）

| 関数名 | 引数 | 説明 |
|--------|------|------|
| `U8Array(n)` | サイズ | n バイトの配列を確保して返す |
| `I32Array(n)` | サイズ | n 要素の i32 配列を確保して返す |
| `len(obj)` | オブジェクト | 配列または文字列の長さを返す |
| `get(obj, i)` | オブジェクト・インデックス | 要素またはバイトを取得 |
| `set(obj, i, v)` | オブジェクト・インデックス・値 | 要素またはバイトをセット |
| `delete(obj)` | オブジェクト | メモリ解放（bcrun では noop） |
| `append(arr, v)` | 配列・値 | 要素を末尾に追加 |
| `equals(a, b)` | オブジェクト×2 | 内容比較 |
| `sys_write(fd, buf, n)` | ファイルディスクリプタ・バッファ・バイト数 | ファイルに書き込む |
| `sys_exit(code)` | 終了コード | プロセスを終了する |
| `sys_read(fd, buf, n)` | ファイルディスクリプタ・バッファ・バイト数 | ファイルから読み込む |
| `print_i32(n)` | i32 | `"%d\n"` で出力 |
| `print_u32(n)` | u32 | `"%u\n"` で出力 |
| `print_bool(b)` | bool | `"true\n"` or `"false\n"` で出力 |

---

## サンプル

`fib.tc` のコンパイル結果例:

```
.bc
.fn fib i32 i32
.param n i32
  load n
  push_int 1
  le
  jump_ifnot __L0
  load n
  return
__L0:
  load n
  push_int 1
  sub
  call fib i32
  load n
  push_int 2
  sub
  call fib i32
  add
  return
  return_void
.endfn

.fn main i32
  push_int 10
  call fib i32
  return
  return_void
.endfn

.endbc
```
