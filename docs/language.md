# 独自言語仕様（案）

## 設計方針

- 文法は **LL(1)** パーサで解析できる構造に限定する
- 型の種類を絞り、コンパイラ実装をシンプルに保つ
- **関数のオーバーロード**（同名・異なる引数型）を許可する
- **ポインタ型なし** — 直接メモリアクセスは `peek`/`poke` で行う
- 配列・構造体は **参照型**（Javaと同様、変数には32bitの参照が入る）
- C風の見た目で、Cプログラマが読み書きしやすい

## 型システム

### 基本型（値型）

| 型 | サイズ | 説明 |
|---|---|---|
| `u8` | 1byte | 符号なし整数 |
| `u16` | 2byte | 符号なし整数 |
| `u32` | 4byte | 符号なし整数 |
| `i8` | 1byte | 符号あり整数 |
| `i16` | 2byte | 符号あり整数 |
| `i32` | 4byte | 符号あり整数 |
| `bool` | 1byte | 真偽値 |
| `void` | - | 戻り値なし |

### 参照型

変数のサイズは常に32bit（内部的にはアドレスが入る）。
ユーザはアドレスを直接意識しない。

- **配列型**: `I8Array`, `I16Array`, `I32Array`, `U8Array`, `U16Array`, `U32Array`
- **構造体型**: `struct` 宣言で定義した名前（例: `Point`）

### 制限事項（意図的）

- ポインタ型なし（`peek`/`poke` で代替）
- 浮動小数点型なし（整数演算で代替）
- 可変長引数なし
- 関数ポインタなし
- **グローバル参照型は null 初期化のみ可**（実体確保は関数内で行う）
  - `var g_arr: U32Array = 0 as U32Array;` で null 宣言
  - `fn main() { g_arr = U32Array(64); }` のように初期化
  - 初期化子に関数呼び出しを書くと codegen が無視するため null のまま

## 配列

### 組み込み配列型と操作関数

各配列型に対して以下の関数が組み込みで提供される（`I32Array` を例に）:

```
I32Array(size: u32) -> I32Array       // 確保
delete(arr: I32Array)                  // 解放
len(arr: I32Array) -> u32             // 長さ
get(arr: I32Array, idx: u32) -> i32   // 要素取得
set(arr: I32Array, idx: u32, val: i32) // 要素設定
```

他の型も同様（`U8Array`, `get(arr: U8Array, ...)` など）。
`String` も参照型なので `StringArray` も組み込みで提供される。

```
StringArray(size: u32) -> StringArray
delete(arr: StringArray)
len(arr: StringArray) -> u32
get(arr: StringArray, idx: u32) -> String
set(arr: StringArray, idx: u32, val: String)
```

### 使用例

```
var buf: U8Array = U8Array(256);
set(buf, 0, 72);           // buf[0] = 'H'
var c: u8 = get(buf, 0);   // c = buf[0]
delete(buf);
```

## 構造体

### 宣言と自動生成関数

`struct` を宣言すると、コンパイラが以下の関数を自動生成する。

```
struct Point {
    x: i32,
    y: i32,
}
```

自動生成される関数:

```
Point(x: i32, y: i32) -> Point       // 確保・初期化
delete(p: Point)                     // 解放
x(p: Point) -> i32                   // x ゲッター
x(p: Point, val: i32)                // x セッター（オーバーロード）
y(p: Point) -> i32                   // y ゲッター
y(p: Point, val: i32)                // y セッター（オーバーロード）
```

ゲッターとセッターは引数型の違いによるオーバーロードで自然に共存する。

### 配列型の自動生成

`struct Point` を宣言すると、`PointArray` 型とその操作関数も自動生成される。

```
PointArray(size: u32) -> PointArray
delete(arr: PointArray)
len(arr: PointArray) -> u32
get(arr: PointArray, idx: u32) -> Point
set(arr: PointArray, idx: u32, val: Point)
```

### 使用例

```
var p: Point = Point(3, 4);
var px: i32 = x(p);       // px = 3
x(p, 10);                  // p.x = 10
delete(p);

var arr: PointArray = PointArray(8);
set(arr, 0, Point(1, 2));
var q: Point = get(arr, 0);
delete(arr);
```

## String

`String` は組み込みの参照型で、内部に `U8Array`（バイト列）と `u32`（使用バイト数）を持つ。
ユーザが `struct` として宣言する必要はなく、言語に組み込まれている。

### 操作関数

`String` は immutable。`append` は元の文字列を変更せず、新しい `String` を返す。
文字列リテラル（`"hello"` など）はそのまま `String` 型として使える。

```
delete(s: String)                           // 解放（リテラルには何もしない）
len(s: String) -> u32                       // 文字数（バイト数）
getChar(s: String, idx: u32) -> u8          // idx番目のバイトを取得
append(s: String, c: u8) -> String          // 末尾に1バイト追加したコピーを返す
append(s: String, t: String) -> String      // 末尾に別のStringを追加したコピーを返す（オーバーロード）
equals(s: String, t: String) -> bool        // 内容比較
```

### 文字列リテラル

ソースコード中の文字列リテラル（`"hello"` など）は `String` 型として扱う。
リテラルは読み取り専用領域に置かれ、内部の `literal` フラグが立っている。
`delete` に渡してもフラグを確認して何もしないため、安全に扱える。

### 使用例

```
var s: String = append("hello", " world");  // 新しいStringが返る
// len(s) == 11
delete(s);
delete("hello");  // リテラルなので何もしない（安全）

var empty: String = "";  // 空文字列もリテラルで表現
```

### 内部構造（コンパイラ実装の参考）

```
// Stringの内部レイアウト（ユーザからは見えない）
//   buf: U8Array   バイト列
//   len: u32       バイト数
//   literal: u8    1=リテラル（deleteで解放しない）、0=ヒープ確保
```

## 直接メモリアクセス（peek / poke）

ポインタの代わりに組み込み関数で直接アドレスを読み書きする。
主にカーネルやドライバの実装で使用する。

```
peek32(addr: u32) -> u32
peek16(addr: u32) -> u16
peek8(addr: u32) -> u8
poke32(addr: u32, val: u32)
poke16(addr: u32, val: u16)
poke8(addr: u32, val: u8)
```

### 使用例

```
// UARTレジスタへの書き込み
poke32(0x40034000, 0x01);
// SRAMの任意アドレスを読む
var v: u32 = peek32(0x20000100);
```

## 文法（LL(1)設計）

### LL(1)を保つための工夫

- 型名は先頭トークンで一意に判別できる（`u8`, `i32`, `I32Array`, `Point` など）
- 文の先頭トークンで文の種類をほぼ確定できる（`if`, `while`, `return`, `var`）
- 識別子で始まる文のみ2トークン目で確定する:
  - `IDENT '='` → 代入文
  - `IDENT '('` → 関数呼び出し文
  ポインタがないため左辺は常に単純な識別子のみ。この2種の区別だけで十分。

### 宣言

```
// インポート（ファイルの先頭に記述）
import "other.tc"

// 変数宣言
var x: i32 = 10;
var p: Point = Point(1, 2);
var buf: U8Array = U8Array(64);

// 関数宣言（オーバーロードあり）
fn add(a: i32, b: i32) -> i32 { ... }
fn add(a: u8, b: u8) -> u8 { ... }

// 本体なし関数宣言（セミコロンで終わる）
// アセンブリ実装の関数や別モジュールの関数を呼ぶときに使う。
// シグネチャだけ typechecker に登録され、リンカが解決する。
fn csr_read_mstatus() -> u32;
fn poke32(addr: u32, val: u32) -> void;

// 構造体宣言
struct Rect {
    left: i32,
    top: i32,
    right: i32,
    bottom: i32,
}
```

## import

```
import "filename.tc"
```

- ファイルの先頭にのみ記述できる
- 指定ファイルから **関数シグネチャ** と **struct 宣言** のみを読み込む（関数本体は無視）
- これにより型検査・オーバーロード解決が複数ファイルにまたがって行える
- ヘッダファイルは不要。ソースファイルが唯一の定義の場所
- 同じファイルを複数回 import しても1回だけ処理される（多重読み込み防止）
- 循環 import はコンパイルエラー
- コンパイルと実行は各ファイルを個別にコンパイルしてリンカで結合する

### コンパイラパイプラインへの影響

`parse` → `typecheck` の段階で import を処理する。

```
parse foo.tc → foo.ast（import先のシグネチャも展開済み）
typecheck foo.ast → foo.tast
codegen foo.tast → foo.bc
bc2asm foo.bc → foo.s
as foo.s -o foo.o

// 全ファイルをコンパイルしてリンク
ld foo.o bar.o baz.o -o program
```

`parse` が import 先ファイルを再帰的に読み込み、シグネチャ・struct をASTに展開する。
import 先の関数本体はASTに含めないため、リンク前に重複定義にはならない。

### 文

```
// 変数への代入
x = 42;

// 条件分岐
if cond {
    ...
} else {
    ...
}

// ループ
while cond {
    ...
}

// return
return expr;
```

### 式

```
// 算術・ビット演算
a + b, a - b, a * b, a / b, a % b
a & b, a | b, a ^ b, a << b, a >> b

// 比較
a == b, a != b, a < b, a <= b, a > b, a >= b

// 論理
a && b, a || b, !a

// キャスト（明示的のみ）
x as u32

// 整数リテラル（10進数 / 16進数 / 2進数、サフィックスで型を指定、省略時は i32）
42        // i32
42i8      // i8
42u8 42u16 42u32 42i16 42i32

// hex / binary リテラル
0xFF      // 255 (i32)
0xDEADBEEFu32
0b1010    // 10 (i32)
0b11111111u8

// 文字リテラル（u8）
'A'       // 65u8
'\n' '\t' '\\' '\'' '\0'

// 関数呼び出し（オーバーロードは引数型で解決）
add(1, 2)         // i32 版が呼ばれる（デフォルト i32）
add(1u8, 2u8)     // u8 版が呼ばれる
```

## 関数オーバーロードの解決

- 呼び出し時の引数の型を静的に解析し、マッチする関数を選択する
- 暗黙の型変換は行わない（型が完全一致するものを選ぶ）
- マッチする関数が複数または0個の場合はコンパイルエラー
- 整数リテラルのデフォルト型は `i32`

## 組み込み関数一覧

| 関数 | 説明 |
|---|---|
| `peek8/16/32` | 指定アドレスから読み込み |
| `poke8/16/32` | 指定アドレスへ書き込み |
| `XxxArray(size)` | 配列の確保 |
| `len(arr)` | 配列の長さ |
| `get(arr, idx)` | 配列要素の取得 |
| `set(arr, idx, val)` | 配列要素の設定 |
| `delete(ref)` | 配列・構造体の解放 |
| `Xxx(...)` | 構造体の確保（struct宣言で自動生成） |
| `field(p)` / `field(p, val)` | 構造体フィールドのゲッター・セッター（自動生成） |

## OS・ライブラリとの対応

### システムコール（カーネルが提供）

システムコールはバッファを `U8Array` + `len` で受け取る。String は渡せない。

```
sys_open(path: U8Array, flags: u32) -> i32
sys_read(fd: i32, buf: U8Array, len: u32) -> i32
sys_write(fd: i32, buf: U8Array, len: u32) -> i32
sys_close(fd: i32) -> i32
sys_exit(code: i32)
sys_brk(addr: u32) -> u32
sys_fork() -> i32
sys_exec(path: U8Array) -> i32
sys_wait(pid: i32) -> i32
sys_getpid() -> i32
sys_pipe(fds: I32Array) -> i32   // fds[0]=読み出し, fds[1]=書き込み
sys_dup2(old_fd: i32, new_fd: i32) -> i32
```

### ユーザランドライブラリ（オーバーロードでStringにも対応）

システムコールの薄いラッパとして提供。`String` を受け取る版は内部で `U8Array` に変換して呼び出す。

```
// open
fn open(path: U8Array, flags: u32) -> i32
fn open(path: String, flags: u32) -> i32    // String版ラッパ

// read / write
fn read(fd: i32, buf: U8Array, len: u32) -> i32
fn write(fd: i32, buf: U8Array, len: u32) -> i32
fn write(fd: i32, s: String) -> i32         // String版ラッパ

// その他
fn close(fd: i32) -> i32
fn exit(code: i32)

// exec系（sys_execveのラッパ、POSIX準拠）
fn execve(path: String, argv: StringArray, envp: StringArray) -> i32
fn execv(path: String, argv: StringArray) -> i32   // envp省略版
fn execvp(path: String, argv: StringArray) -> i32  // PATH検索あり

// 文字列操作
fn strcmp(a: String, b: String) -> i32
fn itoa(n: i32) -> String
fn atoi(s: String) -> i32
```
