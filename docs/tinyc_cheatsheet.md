# tinyc (.tc) 開発チートシート

tinyc は自己ホスト達成済みの小型言語。
このドキュメントは **実装済みの機能** と **よくあるハマりポイント** を中心にまとめたもの。

正式な言語仕様は `docs/language.md` を参照。

---

## ツールチェーン

### Gen1 ツール (C 実装、bootstrap/ 配下)

| ツール | 入力 | 出力 | 説明 |
|--------|------|------|------|
| `./parse <file.tc>` | .tc ソース | AST（テキスト） | 構文解析 |
| `./typecheck` | stdin: AST | 型注釈付きAST | 型検査 (stdin 経由) |
| `./codegen <file.tc>` | .tc ソース | バイトコード (.bc) | parse+typecheck+codegen 一体 |
| `./bcrun` | stdin: バイトコード | 実行結果 | バイトコード実行 |
| `./interp <file.tc>` | .tc ソース (+ stdin) | 実行結果 | AST直接インタープリタ |
| `./bc2asm` | stdin: バイトコード | RISC-V アセンブリ | ネイティブ変換 |
| `./extract-sigs` | stdin: AST | .th (ヘッダ) | export シグネチャ抽出 |

### よく使うコマンド

```bash
# 直接実行（インタープリタ経由、最速）
./tc_run.sh interp tests/fib.tc

# C実装ツールでコンパイル→バイトコード実行
./tc_run.sh bcrun tests/fib.tc

# RISC-V クロスコンパイル + qemu 実行
./tc_run.sh rv32 tests/fib.tc

# 自己ホスト版 (Gen2) でコンパイル
./tc_run.sh pipeline  tests/fib.tc
./tc_run.sh bc2asm_tc tests/fib.tc

# stdin を渡す場合
./tc_run.sh bcrun tests/calc.tc "12 + 34 * 56"
./tc_run.sh bcrun tests/calc.tc @input.txt
```

### コンパイルスクリプト (RV32 ELF 生成)

```bash
# Gen1 ツール (GCC リンカ) で .tc → RV32 ELF
./compile-gen1.sh -o output file.tc

# Gen2 ツール (qemu 経由 + asm.tc リンカ) で .tc → RV32 ELF
GEN2_DIR=/path/to/gen2 ./compile-gen2.sh -o output file.tc
```

### 複数ファイル

```bash
# import "lib.tc"; を再帰的に解決
./tc_build.sh -o prog main.tc          # 単一ファイルでも import OK
GEN2_DIR=/path/to/gen2 ./compile-gen2.sh -o prog main.tc  # 同上
```

---

## 言語構文

### 変数宣言

```tinyc
var x: i32 = 10;
var flag: bool = true;
var c: u8 = 'A';

// 参照型ローカル
var buf: U8Array = U8Array(256);

// 参照型グローバル (null 初期化のみ可、0 as XxxArray)
var g_arr: U32Array = 0 as U32Array;

fn init() -> void {
    g_arr = U32Array(64);   // 関数内で確保
}
```

### 関数

```tinyc
// 通常の関数
fn add(a: i32, b: i32) -> i32 {
    return a + b;
}

// void 関数 (末尾 return は省略可)
fn greet() -> void {
    return;
}

// 本体なし宣言 (アセンブリ関数や別モジュール関数を呼ぶ)
fn _set_kern_gp() -> void;
fn csr_read_mstatus() -> u32;

// export — 別ファイルから import で呼べる
export fn kputs(s: StringLiteral) -> void { ... }
```

### import

```tinyc
import "kernel_common.tc";
// import 先の export fn と struct シグネチャを取り込む
// import は ファイル先頭 にのみ書ける
```

### 整数リテラルと型キャスト

```tinyc
// 整数リテラル
42        // i32 (デフォルト)
42i8 42u8 42i16 42u16 42i32 42u32

// hex / binary リテラル (任意のサフィックス可)
0xFF      // 255 (i32)
0xDEADBEEFu32
0b1010    // 10 (i32)
0b11111111u8

// 文字リテラル (型は u8)
'A'       // 65u8
'\n' '\t' '\\' '\'' '\0'

// キャスト (明示的のみ、暗黙変換なし)
var d: i32 = b as i32;
var addr: u32 = task_buf as u32 + 4u32;
```

### 配列操作

配列コンストラクタの size は `u32`。リテラルはサフィックス、変数は `as u32`。

```tinyc
var arr: I32Array = I32Array(64u32);
set(arr, 0, 42);
var v: i32 = get(arr, 0);
var n: i32 = len(arr);
delete(arr);

// バイト列
var buf: U8Array = U8Array(256u32);
set(buf, 0, 'H');
sys_write(1, buf, 1);
delete(buf);

// 変数サイズ: as u32 でキャスト
fn make_buf(n: i32) -> U8Array { return U8Array(n as u32); }
```

### 構造体

```tinyc
struct Point {
    x: i32,
    y: i32,
}

// 自動生成: コンストラクタ、ゲッター/セッター、delete
fn main() -> i32 {
    var p: Point = Point(3, 4);
    var px: i32 = x(p);     // ゲッター
    x(p, 10);                // セッター (オーバーロード)
    delete(p);
    return 0;
}
```

詳細は `docs/language.md` の「構造体」セクション参照。

### 制御フロー

```tinyc
if cond {
    ...
} else if cond2 {
    ...
} else {
    ...
}

while i < n {
    if cond { break; }
    if other { continue; }
    i = i + 1;
}
```

### 直接メモリアクセス

```tinyc
// MMIO レジスタアクセス (ポインタ型なし)
var v: u32 = peek32(0x40070000u32);
poke32(0x40070000u32, 0x55u32);
peek8 peek16 peek32 / poke8 poke16 poke32
```

---

## ハマりポイント

### 1. グローバル参照型の初期化は関数内で

参照型グローバルは `0 as XxxArray` で null 初期化のみ可。確保は関数内で:

```tinyc
// OK: null で宣言、main で確保
var g_buf: U8Array = 0 as U8Array;

fn main() -> i32 {
    g_buf = U8Array(256);   // ← ここで確保
    set(g_buf, 0, 'H');
    delete(g_buf);
    return 0;
}
```

旧コンパイラ版で `var g_buf: U8Array = U8Array(256);` と書くと、初期化子の関数呼び出しが
無視されて null のままになるので注意。

### 2. 前方宣言は不要

typechecker は2パスなので、関数の使用順序を気にしなくて OK。相互再帰もそのまま書ける。

### 3. `&&` / `||` のショートサーキット

左辺が確定したら右辺を評価しない。

```tinyc
// i < len が false なら get() は呼ばれない
if i < len && get(buf, i) == 10u8 { ... }
```

### 4. 型キャストが必要な場面

- `u8` と `i32` の混在演算
- リファレンスをアドレスとして扱うとき (`buf as u32`)
- リテラルとの比較 (型推論なし)

```tinyc
var c: u8 = get(buf, pos);
var n: i32 = c as i32 - 48;
set(buf, pos, (val & 255) as u8);
var addr: u32 = arr as u32 + 4u32;  // U8Array データ部の先頭
```

### 5. `sys_read` の返り値

`sys_read(fd, buf, len)` は読んだバイト数を返す。一度に全部届くとは限らないので
ループで読み切る:

```tinyc
var total: i32 = 0;
while total < BUF_SIZE {
    var r: i32 = sys_read(0, buf, BUF_SIZE - total);
    if r <= 0 { break; }
    total = total + r;
}
```

### 6. 関数のオーバーロード解決

引数の型で完全一致するものが選ばれる。暗黙の型変換はないので注意:

```tinyc
fn f(x: i32) -> void { ... }
fn f(x: u8)  -> void { ... }

f(42);       // → i32 版
f(42u8);     // → u8 版
f(c as u8);  // 明示キャスト
```

---

## 組み込み関数 (主要)

### I/O / システムコール

```tinyc
fn sys_read(fd: i32, buf: U8Array, len: i32) -> i32
fn sys_write(fd: i32, buf: U8Array, len: i32) -> i32
fn sys_exit(code: i32) -> void

fn print_i32(n: i32) -> void   // 改行付き
fn print_u32(n: u32) -> void
fn print_bool(b: bool) -> void
```

### 配列 (各 XxxArray 型に提供)

```tinyc
fn U8Array(size: i32)  -> U8Array
fn I32Array(size: i32) -> I32Array
// ... U16Array, U32Array, I8Array, I16Array
fn get(arr: U8Array, idx: i32) -> u8
fn set(arr: U8Array, idx: i32, val: u8) -> void
fn len(arr: U8Array) -> i32
fn delete(arr: U8Array) -> void
```

### 文字列

```tinyc
// String / StringLiteral
fn len(s: String) -> i32
fn get(s: String, idx: i32) -> u8
fn append(s: String, t: String) -> String
fn equals(s: String, t: String) -> bool
fn delete(s: String) -> void           // リテラルには no-op
```

### 直接メモリ

```tinyc
fn peek8(addr: u32)  -> u8
fn peek16(addr: u32) -> u16
fn peek32(addr: u32) -> u32
fn poke8(addr: u32, val: u8)   -> void
fn poke16(addr: u32, val: u16) -> void
fn poke32(addr: u32, val: u32) -> void
```

---

## バイトコード形式 (.bc)

スタックマシン形式のテキストフォーマット。詳細は `docs/bc_format.md`。

```
.bc
.string 0 "hello"
.global g_count i32 0

.fn main i32
.param argc i32
.local x i32
  push_int 42
  store x
  load x
  return
.endfn

.endbc
```

主要命令: `push_int`, `push_str`, `load`, `store`, `call`, `return`, `pop`,
`add/sub/mul/div/mod`, `eq/ne/lt/le/gt/ge`, `and/or/xor/shl/shr`,
`jump`, `jump_if`, `jump_ifnot`, `cast`

---

## テスト実行

```bash
make test          # 約50秒、上限60秒
make full-test     # consistency + kmalloc/kernel1 含む全テスト (約63秒)
make update-golden-and-run-test
```

詳細は `tests/test_all.sh` 参照。
