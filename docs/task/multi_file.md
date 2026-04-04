# 複数ファイルサポート設計

## 概要

複数の `.tc` ファイルからなるプログラムをコンパイル・リンクできるようにする。
`language.md` に定義済みの `import "filename.tc"` 構文を実装する。

## 現状

- `import` 構文は `parse.tc` でパースされ、ASTノード `(import "filename.tc")` として出力される
- しかし **import先のファイルは読み込まれず**、シグネチャの展開も行われない
- `typecheck.tc` は `NK_IMPORT` ノードを無視する
- `codegen.tc` も `NK_IMPORT` ノードを無視する
- すべてのコンパイラステージは **stdin のみ** から入力を読む（ファイルI/Oなし）

## 目標

```
// lib.tc
export fn add(a: i32, b: i32) -> i32 {
    return a + b;
}

fn internal_helper() -> i32 {   // export なし → 外部から呼べない
    return 42;
}

// main.tc
import "lib.tc"

fn main() -> i32 {
    return add(1, 2);        // OK: export された関数
    // internal_helper();    // エラー: export されていない
}
```

これを以下のようにコンパイル・リンクできるようにする:

```bash
# 各ファイルを個別にコンパイル
compile main.tc → main.s
compile lib.tc  → lib.s

# リンク
riscv-gcc crt0.s runtime_syscall.c main.s lib.s -o program
```

## 設計

### export キーワード

#### 関数の export

`export` キーワードを `fn` の前に付けると、他のファイルから呼べる関数になる。

```
export fn add(a: i32, b: i32) -> i32 { ... }
```

`export` のない関数はファイル内部でのみ使用可能。
import 先の非 export 関数は AST に展開されず、呼び出すとコンパイルエラーになる。

#### struct の export

struct 自体は export なしでも import 先で**型名として**使える。
ただし、struct が自動生成する関数（アロケータ、デストラクタ、getter/setter、配列操作）は
import 先では**呼べない**。

```
// lib.tc
struct Point {
    x: i32,
    y: i32,
}

export fn make_point(x: i32, y: i32) -> Point {
    return newPoint(x, y);    // lib.tc 内では使える
}

// main.tc
import "lib.tc"

fn main() -> i32 {
    var p: Point = make_point(1, 2);  // OK: Point を型として使える
    // newPoint(1, 2);                // エラー: struct の自動生成関数は呼べない
    // x(p);                          // エラー: getter も呼べない
    // delete(p);                     // エラー: destructor も呼べない
    return 0;
}
```

**理由**: struct のフィールド構成は実装の詳細。外部に公開する操作は
明示的に `export fn` でラップすべき。

#### import で展開されるもの

| 宣言 | import 先の AST に展開 | 用途 |
|------|----------------------|------|
| `export fn` | `extern_fn` ノード | 関数呼び出し可能 |
| `fn`（export なし） | 展開しない | — |
| `struct` | `extern_struct` ノード（型名のみ） | 型として使用可能 |
| struct の自動生成関数 | 展開しない | — |
| グローバル変数 | 展開しない（export 不可） | — |

### コンパイルパイプライン

```
main.tc ─→ parse ─→ main.ast ─→ typecheck ─→ main.tast ─→ codegen ─→ main.bc ─→ bc2asm ─→ main.s ─┐
                        ↑                                                                               │
                   lib.tc の export fn を                                                               ├→ リンク → program
                   extern_fn として展開                                                                 │
lib.tc  ─→ parse ─→ lib.ast  ─→ typecheck ─→ lib.tast  ─→ codegen ─→ lib.bc  ─→ bc2asm ─→ lib.s  ─┘
```

### parse ステージの変更

#### 入力方式の変更

現在: stdin からソースを読む
変更後: **コマンドライン引数でファイル名**を受け取る（import 先を相対パスで開くため）

```bash
# 現在
cat main.tc | ./parse

# 変更後
./parse main.tc
```

stdin フォールバック: 引数なしなら従来通り stdin から読む（後方互換性）。
ただし stdin モードでは import は使えない（相対パスが解決できない）。

#### export キーワードのパース

```
// 構文
export fn name(params) -> ret_type { body }
```

パーサーは `export` トークンを認識し、ASTノードにフラグとして記録する:

```
(fn:export add (params (param a i32) (param b i32)) i32
  (return (add (var a) (var b))))
```

`:export` 修飾子を fn ノードに付ける。export でない fn は従来通り `(fn ...)` のまま。

#### ASTへの展開

import 先から抽出するもの:
- **export 付き関数のシグネチャ**: `(extern_fn name (params ...) ret_type)` — 本体なし
- **struct 宣言**: `(extern_struct name)` — 型名のみ（フィールド情報なし）

```
// main.tc の AST 出力例
(program
  (extern_fn add (params (param a i32) (param b i32)) i32)  ← lib.tc の export fn
  (extern_struct Point)                                      ← lib.tc の struct（型名のみ）
  (fn main (params) i32
    (return (call add (int 1) (int 2)))))
```

**展開しないもの**:
- export なしの関数
- struct の自動生成関数（newXxx, delete, getter, setter, 配列操作）

#### import の処理

import は**直接 import したファイルのみ**が対象。推移的に伝播しない。

```
// a.tc imports b.tc, b.tc imports c.tc
// a.tc から c.tc の export fn は見えない（b.tc の export fn のみ見える）
```

```
parse main.tc:
  1. main.tc を読む
  2. import "lib.tc" を見つける
  3. lib.tc を開く
  4. lib.tc のトップレベル宣言をスキャンする（再帰パースはしない）
     - export fn → シグネチャを抽出
     - struct → 型名を抽出
     - import 文、非 export fn、グローバル変数 → 無視
  5. 抽出した extern_fn / extern_struct ノードを出力
  6. main.tc 本体のパースを続行
```

lib.tc 内の `import "c.tc"` は処理しない。lib.tc からはトップレベルの
`export fn` と `struct` だけを浅くスキャンする。

多重読み込み防止: 同じファイルを2回 import した場合、2回目は無視する。

### typecheck ステージの変更

- `extern_fn` ノードを `collect_decls` で処理し、fntab に登録する
- `extern_fn` に対しては関数本体の型チェックを行わない（本体がない）
- `extern_struct` ノードを処理し、型名として登録する
  - **自動生成関数（newXxx, delete, getter, setter, 配列操作）は登録しない**
  - 型名のみ登録するので、引数・戻り値の型チェックで使える
- `export` 付き fn は通常の fn と同様に型チェックする（export は可視性の問題であり、型の問題ではない）

### codegen ステージの変更

- `extern_fn` ノードに対してはコードを生成しない（スキップ）
- `extern_struct` ノードに対してもコードを生成しない（スキップ）
- `export` 付き fn は通常の fn と同様にコード生成する
- `call` 命令は従来通りマングル名で出力。リンカが解決する

### bc2asm ステージの変更

- 変更なし。既に外部シンボルへの `call` を正しく出力できている
- export 関数のシンボルは `.globl` で公開される（現在もすべての関数が `.globl`）

### リンク

- 各 `.tc` ファイルを `.s` まで個別にコンパイル
- `riscv-gcc` でまとめてリンク

```bash
riscv-gcc -march=rv32im -mabi=ilp32 -static -nostdlib -lgcc \
    -Wl,-Ttext-segment=0x10000 \
    crt0.s runtime_syscall.c main.s lib.s -o program
```

### ビルドスクリプト

`tc_run.sh` を拡張するか、新しい `tc_build.sh` を用意する:

```bash
# 単一ファイル（従来通り）
./tc_run.sh rv32 main.tc

# 複数ファイル
./tc_build.sh main.tc lib.tc -o program
```

## 実装ステップ

### Step 1: export キーワードのパース（C実装）

`bootstrap/parse.c` を変更:
- `export` をキーワードとして追加
- `export fn` を認識し、ASTノードに `:export` 修飾子を付ける
- 既存テストは影響なし（export を使わないコードは従来通り動く）

### Step 2: parse の引数対応（C実装）

`bootstrap/parse.c` を変更:
- `argv[1]` があればファイルとして開く
- なければ従来通り stdin から読む
- まだ import の再帰処理はしない

### Step 3: extern_fn / extern_struct ノードの追加

- AST に `extern_fn`、`extern_struct` ノード種別を追加
- typecheck で `extern_fn` を fntab に登録
- typecheck で `extern_struct` を型名として登録（自動生成関数は登録しない）
- codegen で両方をスキップ

### Step 4: parse での import 処理（C実装）

`bootstrap/parse.c` を変更:
- import 文を処理するとき、指定ファイルを開く
- ファイルのトップレベル宣言を**浅くスキャン**（再帰しない）
- `export fn` のシグネチャのみ `extern_fn` ノードとして出力
- struct は `extern_struct` ノード（型名のみ）として出力
- import 先の import 文は無視する（推移的 import なし）
- 多重読み込み防止（同じファイルの2回目の import は無視）

### Step 5: テスト

- 複数ファイルのテストケースを追加
  - export fn の呼び出し
  - 非 export fn の呼び出しがエラーになること
  - struct の型名使用
  - struct の自動生成関数が呼べないこと
  - 推移的 import が伝播しないこと（a→b→c で a から c が見えない）
  - 多重 import の正常動作
- 単一ファイルの既存テストが壊れないことを確認

### Step 6: parse.tc での import 処理（自己ホスト版）

- Step 1〜4 と同じロジックを `compiler/parse.tc` に実装
- ファイルI/Oのシステムコール（open, read, close）を TinyC から呼べるようにする

### Step 7: tc_run.sh / tc_build.sh の対応

- 複数ファイルのコンパイル＋リンクをサポート

## 検討事項

### ファイルI/O

現在の TinyC には `sys_read(fd, buf, len)` と `sys_write(fd, buf, len)` がある。
import のためには `sys_open(path, flags, mode)` と `sys_close(fd)` が追加で必要。

これらは `runtime_syscall.c` に追加する builtins として実装できる。
あるいは `peek`/`poke` と `ecall` で直接システムコールを発行してもよい。

### パスの解決

import パスは**現在のファイルからの相対パス**で解決する。

```
src/main.tc:  import "lib.tc"    → src/lib.tc
src/main.tc:  import "util/io.tc" → src/util/io.tc
```

### グローバル変数

グローバル変数は export できない。各ファイルのグローバル変数はそのファイル内でのみ有効。
ファイル間でデータを共有したい場合は `export fn` でアクセサを提供する。

### struct のフィールド操作を外部から行いたい場合

struct の自動生成関数は import 先では使えないため、
フィールドにアクセスしたい場合は明示的に export fn でラップする:

```
// lib.tc
struct Point { x: i32, y: i32 }

export fn Point_new(x: i32, y: i32) -> Point {
    return newPoint(x, y);
}

export fn Point_x(p: Point) -> i32 {
    return x(p);
}

export fn Point_set_x(p: Point, val: i32) -> void {
    x(p, val);
}
```

これにより、公開するインターフェースを明示的に制御できる。

### 名前衝突

- 同じシグネチャ（名前＋引数型）の export fn が複数ファイルで定義されていたらリンクエラー
- import はシグネチャのみなので、コンパイル時には検出できない
- リンカが `multiple definition` エラーを出す → これで十分

### 非 export 関数のシンボル

非 export 関数もリンカレベルではシンボルが見える（`.globl` が付く）。
初期実装ではこれを許容する。将来的に:
- 非 export 関数は `.local` ディレクティブを使い、リンカから隠す
- あるいはファイル名プレフィックスでマングルして衝突を防ぐ
