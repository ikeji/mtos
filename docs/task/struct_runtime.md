# struct ランタイムサポート設計

## 概要

`language.md` に定義済みの `struct` 構文に、実行時のサポートを追加する。
現状はパース・AST化までは動作するが、コンストラクタ・getter/setter の
呼び出し先が存在しないため、実行すると失敗する。

**設計方針:** struct を内部的に `U32Array` の別名として扱い、
**parser が struct 宣言から必要な関数群を AST として展開する**。
合成関数本体は明示的な `as` キャストで struct と U32Array を橋渡しする。
ランタイム側（bcrun / bc2asm / runtime.c）への変更は不要。

## 現状

動作するもの:
- `parse.tc` / `parser.c` は `struct Point { x: i32, y: i32 }` をパースする
- AST ノード `(struct Point (field x (type i32)) (field y (type i32)))` として出力される
- C 版 `typecheck.c` は struct 宣言から以下の関数を型環境（fntab）に登録する:
  - コンストラクタ `Point(x: i32, y: i32) -> Point`
  - `delete(p: Point) -> void`
  - getter `x(p: Point) -> i32`
  - setter `x(p: Point, val: i32) -> void`
  - 配列型 `PointArray` とその操作関数

動作しないもの:
- **bcrun / runtime.c / bc2asm**: struct コンストラクタや getter/setter の呼び出し先が存在しない（関数が未定義）
- **self-hosted typecheck.tc**: `collect_struct` がコンストラクタと delete しか登録していない

結果として `tests/import/main_struct.tc`（struct を使うテスト）は失敗する。

## 方針

### struct の内部表現

struct はサイズ N（フィールド数）の `U32Array` として表現する:

- フィールドはすべて 32bit スロットに格納（`i32`/`u32`/`bool`/参照型すべて 32bit、`u8`/`i8`/`u16`/`i16` もスロット内で保持可能）
- 参照は非負のアドレスなので `i32` より `u32` 表現の方が自然
- コンストラクタは `U32Array(N)` で確保
- getter は `get(arr, idx)` で読み出し
- setter は `set(arr, idx, val)` で書き込み
- `delete` は `U32Array` の delete をそのまま呼ぶ

すべての参照型は HeapObj へのポインタ（runtime.c）または HeapObj の参照
（bcrun）なので、`Point` と `U32Array` は runtime 上で区別されない。
型区別は typechecker の責務のみ。

### 呼び出し dispatch が base name ベースで動く

- **bcrun** (`call_builtin`): `base_name()` で先頭の関数名を取り出し、`get`/`set`/`delete`/`len`/`U32Array` はそれで dispatch
- **bc2asm** (`is_builtin`): 同様にベース名で判定し、`__tc_<base>` を call
- **runtime.c**: `__tc_set(obj, idx, val)` / `__tc_get(obj, idx)` は HeapObj を受け取り型チェックせずに動く

→ 呼び出しが `set__U32Array__u32__u32` でも `set__Point__u32__u32` でも、ランタイムは同じ `__tc_set` に dispatch するので動く。ただし本設計では合成関数内で明示キャストを使って **常に `set__U32Array__u32__u32` 等として呼ぶ** ため、ディスパッチに新しいケースは不要。

### 参照型間の `as` キャスト

struct と U32Array は参照型として **同じ 32bit ビットパターン** を持つので、両者間の `as` キャストは **runtime 無コスト**で実装できる（BC 命令を emit しない）。

```tinyc
var arr: U32Array = U32Array(3);
var p: Point = arr as Point;      // OK
var back: U32Array = p as U32Array;  // OK
```

このキャストは合成関数の境界で使われるが、ユーザが明示的に使うことも可能
（低レベル操作が必要な advanced ケース向け）。

## 設計

### struct → 関数群への展開

`struct Point { x: i32, y: i32 }` を見たら、parser は以下の AST ノードを
**元の struct ノードの直後に program へ追加**する:

```tinyc
fn Point(__a0: i32, __a1: i32) -> Point {
    var __p: U32Array = U32Array(2);
    set(__p, 0u32, __a0 as u32);
    set(__p, 1u32, __a1 as u32);
    return __p as Point;
}

fn x(__p: Point) -> i32 {
    return get(__p as U32Array, 0u32) as i32;
}
fn y(__p: Point) -> i32 {
    return get(__p as U32Array, 1u32) as i32;
}

fn x(__p: Point, __v: i32) -> void {
    set(__p as U32Array, 0u32, __v as u32);
    return;
}
fn y(__p: Point, __v: i32) -> void {
    set(__p as U32Array, 1u32, __v as u32);
    return;
}

fn delete(__p: Point) -> void {
    delete(__p as U32Array);
    return;
}
```

`PointArray` は既存の `U32Array` と同じ実装で動作するため、**合成関数は不要**。
typechecker が fntab に配列型ビルトインのシグネチャを登録するだけでよい:

```
PointArray(u32) -> PointArray
len(PointArray) -> u32
get(PointArray, u32) -> Point
set(PointArray, u32, Point) -> void
delete(PointArray) -> void
```

`PointArray` コンストラクタの呼び出しは base name が `PointArray` なので、
bc2asm/bcrun は既存の `XxxArray` ビルトインとして扱う。

### フィールド型が `u32`/`u8`/`bool` のとき

- `u32`: キャスト不要（すでに 32bit unsigned）
- `u8`/`i8`/`u16`/`i16`/`bool`: `set` 前に `as u32`、`get` 後に `as 本来の型`

例: `struct Pixel { r: u8, g: u8, b: u8 }` のゲッター:

```tinyc
fn r(__p: Pixel) -> u8 {
    return get(__p as U32Array, 0u32) as u8;
}
```

### 参照型フィールド

フィールドが参照型（例: `name: String`）の場合、参照は 32bit 値として
U32Array に格納できる。ただし型キャストは参照型同士の `as` が必要:

```tinyc
struct Person { name: String, age: i32 }

fn name(__p: Person) -> String {
    return get(__p as U32Array, 0u32) as String;  // u32 → String ref cast
}
fn name(__p: Person, __v: String) -> void {
    set(__p as U32Array, 0u32, __v as u32);       // String → u32 ref cast
    return;
}
```

→ 参照型 ↔ `u32` の `as` キャストも許可する必要がある（同じ 32bit 値として扱う）。

**キャスト規則の全体像:**

| from | to | 扱い |
|---|---|---|
| 整数型 → 整数型 | | 既存（BC cast 命令） |
| 参照型 → 参照型 | | 新規: no-op（BC 命令なし） |
| 参照型 → u32 | | 新規: no-op（ビットパターンそのまま） |
| u32 → 参照型 | | 新規: no-op（ビットパターンそのまま） |

これらの新規キャストは、struct 合成関数が必要とするすべてのケースを
カバーする。ユーザコードで明示的に使うことも許可する。

### import との関係

parse の import 展開は import 先の struct 宣言も AST に入れる。
もし **全ての struct ノード** から合成関数を展開すると、複数ファイルで
同じ関数が重複定義される。

解決策: **struct ノードに「imported か否か」のマーカを付ける**
- parser が import 展開する struct には `(struct Point imported ...)` のように
  マーカを追加
- 合成関数展開は **マーカなし（一次宣言）の struct のみ** 対象
- import 側からは、型名 `Point` は parser で型として扱われ、合成関数は
  宣言元ファイルとリンクされる

合成関数は `export` **しない**。`language.md` の仕様で「struct が自動生成する関数は import 先から呼べない」と規定されているため、合成関数は宣言元ファイル内部でのみ使用される。import 先で struct を使いたいユーザは、export されたラッパ関数（`make_point` など）を経由する。

## 変更箇所

| ファイル | 変更内容 |
|---|---|
| `bootstrap/parser.c` | ① import した struct に `imported` マーカを付ける<br>② 一次宣言の struct から合成関数 AST を生成して program に追加 |
| `compiler/parse.tc` | 同上 |
| `bootstrap/typecheck.c` | 参照型 ↔ 参照型 / 参照型 ↔ u32 の `as` キャストを許可 |
| `compiler/typecheck.tc` | 同上。`collect_struct` に getter/setter/`PointArray` の fntab 登録を追加 |
| `bootstrap/codegen.c` | 参照型キャストは BC 命令を emit しない |
| `compiler/codegen.tc` | 同上 |
| `bcrun.c` / `bc2asm.c` / `runtime.c` / `interp.c` | **変更なし** |

## テスト

### 新規: `tests/examples/struct_basic.tc`

```tinyc
struct Point { x: i32, y: i32 }

fn main() -> i32 {
    var p: Point = Point(3, 4);
    print_i32(x(p));              // 3
    print_i32(y(p));              // 4
    x(p, 10);
    y(p, 20);
    print_i32(x(p) + y(p));       // 30
    delete(p);
    return 0;
}
```

### 新規: `tests/examples/struct_array.tc`

```tinyc
struct Point { x: i32, y: i32 }

fn main() -> i32 {
    var arr: PointArray = PointArray(3);
    set(arr, 0u32, Point(1, 2));
    set(arr, 1u32, Point(3, 4));
    var p: Point = get(arr, 0u32);
    print_i32(x(p));              // 1
    print_i32(y(get(arr, 1u32))); // 4
    delete(arr);
    return 0;
}
```

### 既存: `tests/import/main_struct.tc`

受け入れ基準。import 経由での struct 利用が通ること。

### golden テスト

`make update-golden` で golden ファイルを再生成し、bcrun / rv32 / interp の全バックエンドで動くことを確認。

### 自己ホスト確認

`tests/run_gen3_tests.sh` で Gen2 BC == Gen3 BC が一致すること。

## 実装順序

1. C版 `typecheck.c`: 参照型 `as` キャストを許可
2. C版 `codegen.c`: 参照型キャストを no-op で emit
3. C版 `parser.c`:
   - 一次宣言の struct から合成関数を展開
   - import した struct に `imported` マーカを付ける
4. `tests/examples/struct_basic.tc` を追加、golden 生成
5. `tests/examples/struct_array.tc` を追加、golden 生成
6. `tests/import/main_struct.tc` の golden 更新
7. self-hosted `typecheck.tc`: 参照型 `as` キャスト / `collect_struct` 拡張
8. self-hosted `codegen.tc`: 参照型キャスト no-op
9. self-hosted `parse.tc`: 合成関数展開 + `imported` マーカ
10. Gen2/Gen3 一致確認
