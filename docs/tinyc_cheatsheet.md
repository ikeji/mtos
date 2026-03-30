# tinyc (.tc) 開発チートシート

tinyc は自己ホスト（セルフホスティング）を目標とした小型言語。
このドキュメントは **実装済みの機能** と **よくあるハマりポイント** を中心にまとめたもの。

---

## ツールチェーン

### ツール一覧

| ツール | 入力 | 出力 | 説明 |
|--------|------|------|------|
| `./parse <file.tc>` | .tc ソース | AST（テキスト） | 構文解析 |
| `./typecheck <file.tc>` | .tc ソース | 型注釈付きAST | 型検査 |
| `./codegen <file.tc>` | .tc ソース | バイトコード (.bc) | コード生成 |
| `./bcrun` | stdin: バイトコード | 実行結果 | バイトコード実行 |
| `./interp <file.tc>` | .tc ソース (+ stdin) | 実行結果 | AST直接インタープリタ |
| `./bc2asm` | stdin: バイトコード | RISC-V アセンブリ | ネイティブ変換 |

### よく使うコマンド

```bash
# 直接実行（インタープリタ経由）
./interp tests/fib.tc

# C実装ツールでコンパイル→実行
./codegen tests/fib.tc | ./bcrun

# stdin を与えるプログラム
{ ./codegen tests/calc.tc; printf "12 + 34 * 56"; } | ./bcrun

# パースして AST を確認
./parse tests/fib.tc

# RISC-V バイナリを生成して qemu で実行
./codegen tests/fib.tc | ./bc2asm > /tmp/fib.s
riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -static -nostdlib -lgcc \
    -Wl,-Ttext-segment=0x10000 src/crt0.s /tmp/fib.s src/runtime_syscall.c -o /tmp/fib
qemu-riscv32 /tmp/fib
```

---

## tinyc パイプライン（セルフホスティング用）

C実装ツールではなく tinyc 実装のパーサ／コードジェネレータを使ってコンパイルするパイプライン。

```
ソース.tc
  → parse.tc (bcrun上で動作) → AST
  → codegen.tc (bcrun上で動作) → バイトコード
  → bcrun → 実行
```

### 実行方法

```bash
# Step 1: parse.tc を使って source.tc をパース
{ ./parse src/parse.tc | ./codegen; cat source.tc; } | ./bcrun   # → AST テキスト

# Step 2: codegen.tc を使って AST からバイトコード生成
AST=$(step1コマンド)
{ ./parse src/codegen.tc | ./codegen; echo "$AST"; } | ./bcrun   # → バイトコード

# Step 3: バイトコードを bcrun で実行
{ step2コマンド; printf "stdin入力"; } | ./bcrun

# 一発でコンパイル＆実行（fib.tcの例）
PARSE_BC=$(./parse src/parse.tc | ./codegen)
CODEGEN_BC=$(./parse src/codegen.tc | ./codegen)
FIB_AST=$({ printf '%s\n' "$PARSE_BC"; cat tests/fib.tc; } | ./bcrun)
FIB_BC=$({ printf '%s\n' "$CODEGEN_BC"; printf '%s\n' "$FIB_AST"; } | ./bcrun)
printf '%s\n' "$FIB_BC" | ./bcrun
```

### .endbc マーカー

バイトコードの末尾に `.endbc` が出力される。
`bcrun` は `.endbc` 以降の stdin バイトを、実行するプログラムの stdin として使う。
これにより「バイトコード＋プログラム stdin」を1本のパイプで渡せる。

---

## 言語構文

### 変数宣言

```tinyc
var x: i32 = 10;
var flag: bool = true;
var buf: U8Array = newU8Array(256);   // 参照型（グローバルには置けない）
```

### 関数

```tinyc
fn add(a: i32, b: i32) -> i32 {
    return a + b;
}

fn greet() -> void {
    // void関数の末尾 return は省略可
    return;
}
```

### 型と型キャスト

```tinyc
// 整数リテラルのサフィックス
var a: i32 = 42;       // デフォルトは i32
var b: u8  = 65u8;     // u8 リテラル
var c: u32 = 1024u32;

// キャスト（明示的のみ、暗黙変換なし）
var d: i32 = b as i32;
var e: u8  = (a & 255) as u8;
```

### 配列操作

```tinyc
var arr: I32Array = newI32Array(64);
set(arr, 0u32, 42);                  // arr[0] = 42
var v: i32 = get(arr, 0u32);         // v = arr[0]
var n: i32 = len(arr) as i32;        // 長さ
delete(arr);                          // 解放

// U8Array（バイト列）
var buf: U8Array = newU8Array(256);
set(buf, 0u32, 72u8);               // 'H'
var c: u8 = get(buf, 0u32);
```

### 制御フロー

```tinyc
// if / else
if cond {
    ...
} else {
    ...
}

// while ループ
while i < n {
    i = i + 1;
}
```

---

## ハマりポイント（制約一覧）

### 1. `else if` は使えない

パーサが `else if` をサポートしていない。
**代替パターン**: `handled` フラグを使って複数の `if` を順に書く。

```tinyc
// NG
if x == 1 {
    ...
} else if x == 2 {
    ...
}

// OK: handled フラグパターン
var handled: i32 = 0;
if x == 1 && handled == 0 {
    ...
    handled = 1;
}
if x == 2 && handled == 0 {
    ...
    handled = 1;
}
```

### 2. `break` / `continue` は使える

```tinyc
// break: ループを抜ける
while i < n {
    if get(arr, i as u32) == target { break; }
    i = i + 1;
}

// continue: 次のイテレーションへ
while i < n {
    i = i + 1;
    if i % 2 == 0 { continue; }
    sum = sum + i;
}

// ネスト: break/continue は最内ループにのみ作用
while i < rows {
    var j: i32 = 0;
    while j < cols {
        if get(arr, j as u32) == 0 { break; }  // 内側だけ抜ける
        j = j + 1;
    }
    i = i + 1;
}
```

### 3. グローバル参照型の初期化は関数内で行う

`I32Array`, `U8Array` などの参照型はグローバルに宣言できる（初期値は null）。
ただし **初期化子に関数呼び出しは書けない**。codegen が整数定数しかバイトコードに出力しないため、
`newU8Array(...)` などの呼び出しが実行されず null のままになる。

```tinyc
// NG: 初期化子の関数呼び出しが無視され、null のまま実行時エラー
var g_buf: U8Array = newU8Array(256);

// OK: 宣言だけして main で確保する
var g_buf: U8Array;          // null で初期化される
var g_buf_len: i32 = 0;

fn process() -> void {
    set(g_buf, 0u32, 72u8);  // main で代入済みであれば使える
}

fn main() -> i32 {
    g_buf = newU8Array(256); // ← ここで確保・代入
    g_buf_len = 256;
    process();
    delete(g_buf);
    return 0;
}
```

### 4. グローバル変数の初期値

グローバル変数には整数リテラルで初期値を与えられる。
初期値なしの場合は 0 に初期化される。

```tinyc
var g_count: i32 = 0;     // OK
var TK_INT: i32 = 17;     // OK（定数として使う）
var g_flag: bool = false;  // OK（0 として扱われる）
```

### 5. 前方宣言は不要

tinyc のタイプチェッカは2パスで動作するため、
使用順序を気にせず関数を定義できる。相互再帰もそのまま書ける。

```tinyc
// OK（forward declaration 不要）
fn foo() -> void { bar(); }
fn bar() -> void { foo(); }
```

### 6. `&&` / `||` のショートサーキット

`&&` と `||` は左辺が確定したら右辺を評価しない（短絡評価）。
条件式が副作用を持つ場合に注意。

```tinyc
// i < len が false なら get() は呼ばれない（安全）
if i < len && get(buf, i as u32) == 10u8 {
    ...
}
```

### 7. 型キャストが必要な場面

- `u8` と `i32` の混在する演算
- `i32` を配列インデックス（`u32`）に渡すとき
- 比較の片方がリテラルと型が違うとき

```tinyc
var c: u8 = get(buf, pos as u32);         // i32 → u32
var n: i32 = c as i32 - 48;              // u8 → i32
set(buf, pos as u32, (val & 255) as u8); // i32 → u8
```

### 8. `sys_read` の返り値

`sys_read(fd, buf, len)` は読んだバイト数（`i32`）を返す。
ループで読み切る必要がある（パイプは一度で全バイトが届かない場合がある）。

```tinyc
var total: i32 = 0;
var done: i32 = 0;
while done == 0 && total < BUF_SIZE {
    var r: i32 = sys_read(0, buf, (BUF_SIZE - total) as u32);
    if r <= 0 { done = 1; }
    if r > 0  { total = total + r; }
}
```

---

## 組み込み関数（実装済み）

### I/O

```tinyc
sys_read(fd: i32, buf: U8Array, len: u32) -> i32
sys_write(fd: i32, buf: U8Array, len: u32) -> i32
sys_exit(code: i32)
```

### デバッグ出力

```tinyc
print_i32(n: i32)     // 改行付きで標準出力
print_u32(n: u32)
print_bool(b: bool)
print_str(s: String)  // interp のみ（bcrun では未サポート）
```

### 配列

```tinyc
newI32Array(size: u32) -> I32Array
newU8Array(size: u32)  -> U8Array
get(arr: I32Array, idx: u32) -> i32
get(arr: U8Array,  idx: u32) -> u8
set(arr: I32Array, idx: u32, val: i32)
set(arr: U8Array,  idx: u32, val: u8)
len(arr: I32Array) -> u32
len(arr: U8Array)  -> u32
delete(arr: I32Array)
delete(arr: U8Array)
```

---

## バイトコード形式（.bc）

スタックマシン形式のテキストフォーマット。

```
; string table
.string 0 "hello"

; globals
.global g_count i32 0
.global TK_INT  i32 17

.fn func_name nparams return_type
.param name type
.local name type
  push_int 42
  load varname
  store varname
  call func_name nargs
  return
  return_void
  jump __L0
  jump_if __L0
  jump_ifnot __L0
__L0:
.endfn

.endbc
```

### 主要命令

| 命令 | 動作 |
|------|------|
| `push_int N` | スタックに整数 N を積む |
| `push_str N` | string table の N 番目の参照を積む |
| `load NAME` | 変数 NAME の値をスタックへ |
| `store NAME` | スタックトップを変数 NAME へ |
| `call NAME N` | N 引数で関数 NAME を呼び出す |
| `return` | 戻り値あり return |
| `return_void` | 戻り値なし return |
| `pop` | スタックトップを捨てる |
| `add/sub/mul/div/mod` | 算術演算 |
| `eq/ne/lt/le/gt/ge` | 比較（結果は 0 or 1） |
| `and/or/xor/shl/shr` | ビット演算 |
| `neg` / `lnot` | 単項マイナス / 論理 NOT |
| `cast TYPE` | スタックトップを TYPE に変換 |
| `jump L` | 無条件ジャンプ |
| `jump_if L` | スタックトップが真なら |
| `jump_ifnot L` | スタックトップが偽なら |

---

## テスト実行

```bash
bash tests/run_tests.sh
```

- C実装ツールのテスト（parse, codegen, bcrun, rv32）
- **パイプラインテスト**: parse.tc / codegen.tc を bcrun 上で動かすテスト
