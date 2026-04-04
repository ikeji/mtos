# ソースファイル一覧

## ディレクトリ構成

```
bootstrap/  Cで書かれたブートストラップコンパイラ
compiler/   tinyc自己ホスト実装
os/         OSカーネル（将来）
tests/      テストファイル・テストインフラ
docs/       ドキュメント
```

---

## C実装（フェーズ1ブートストラップツール）: `bootstrap/`

### コアライブラリ

| ファイル | 説明 |
|----------|------|
| `bootstrap/lexer.c` / `bootstrap/lexer.h` | 字句解析器（レキサー）。tinyc ソースを TOKEN に分割する |
| `bootstrap/ast.c` / `bootstrap/ast.h` | AST（抽象構文木）のノード生成・操作・S式出力・S式読み込み |
| `bootstrap/parser.c` / `bootstrap/parser.h` | 構文解析器（パーサー）。トークン列から AST を構築する |
| `bootstrap/typecheck.c` / `bootstrap/typecheck.h` | 型チェッカー。AST に型アノテーションを付与し、型エラーを検出する |
| `bootstrap/interp.c` / `bootstrap/interp.h` | AST インタープリタ。型チェック済み AST を直接実行する |
| `bootstrap/codegen.c` / `bootstrap/codegen.h` | バイトコードジェネレータ（C実装）。AST からバイトコード（`.bc`）を生成する |

### エントリーポイント（各バイナリの `main`）

| ファイル | 生成バイナリ | 説明 |
|----------|-------------|------|
| `bootstrap/parse_main.c` | `./parse` | ソース → AST（S式）を出力する |
| `bootstrap/typecheck_main.c` | `./typecheck` | ソース → 型チェック済み AST を出力する |
| `bootstrap/interp_main.c` | `./interp` | ソース → AST インタープリタで実行する |
| `bootstrap/codegen_main.c` | `./codegen` | ソース → バイトコード（`.bc`）を出力する |

### バイトコード実行・変換

| ファイル | 生成バイナリ | 説明 |
|----------|-------------|------|
| `bootstrap/bcrun.c` | `./bcrun` | バイトコードインタープリタ。stdin からバイトコードを読んで実行する |
| `bootstrap/bc2asm.c` | `./bc2asm` | バイトコード → RISC-V アセンブリ（C実装）。`riscv64-unknown-elf-gcc` でリンク可能 |

### ランタイムライブラリ

| ファイル | 説明 |
|----------|------|
| `bootstrap/runtime.c` | `bcrun` 用ランタイム。`malloc` ベースのヒープ管理・組み込み関数の C 実装 |
| `bootstrap/runtime_syscall.c` | RISC-V ベアメタル用ランタイム。`ecall` 直接呼び出し、バンプアロケータ |
| `bootstrap/crt0.s` | RISC-V 用スタートアップルーチン。`main` を呼び出す前に SP を設定する |

---

## tinyc 自己ホスト実装（フェーズ2）: `compiler/`

| ファイル | 説明 |
|----------|------|
| `compiler/parse.tc` | tinyc で書かれたパーサー。ソース → AST（S式）を出力する |
| `compiler/codegen.tc` | tinyc で書かれたコードジェネレータ。AST → バイトコードを出力する |
| `compiler/bc2asm.tc` | tinyc で書かれた bc2asm。バイトコード → RISC-V アセンブリを出力する |
| `compiler/bcrun.tc` | tinyc で書かれたバイトコードインタープリタ（`bcrun` の自己ホスト版） |

---

## OS カーネル（フェーズ3）: `os/`

将来のOS本体コードが入る予定。

---

## テストファイル: `tests/`

| ファイル | 説明 |
|----------|------|
| `tests/hello.tc` | Hello World（U8Array に文字を直接 set して sys_write） |
| `tests/hello2.tc` | Hello World その2（String から U8Array に変換して sys_write） |
| `tests/fib.tc` | フィボナッチ数列（再帰関数） |
| `tests/fizzbuzz.tc` | FizzBuzz（while ループ・条件分岐） |
| `tests/calc.tc` | 四則演算電卓（stdin から式を読んで評価、グローバル変数使用） |
| `tests/elseif_test.tc` | else if チェーンのテスト |
| `tests/charliteral_test.tc` | 文字リテラル（`'A'`、`'\n'` など）のテスト |
| `tests/break_test.tc` | break 文のテスト |
| `tests/continue_test.tc` | continue 文のテスト |
| `tests/nested_break_test.tc` | ネストしたループの break テスト |

---

## スクリプト・テストインフラ

| ファイル | 説明 |
|----------|------|
| `tc_run.sh` | 指定メソッド（interp/bcrun/rv32/pipeline/bc2asm_tc）で .tc ファイルを実行するヘルパー |
| `tc_run_all.sh` | 全5メソッドで実行し、出力が一致するか確認する |
| `tests/run_tests.sh` | メインテストスイート。全テストを実行して PASS/FAIL を報告する |
| `tests/run_golden_tests.sh` | ゴールデンテスト。C実装と自己ホスト実装の出力を期待値ファイルと比較する |
| `tests/update_golden.sh` | ゴールデンファイル（`.ast`, `.bc`, `.s`, `.out`, `.exit`）を C ツールで再生成する |

---

## ドキュメント: `docs/`

| ファイル | 説明 |
|----------|------|
| `docs/overview.md` | プロジェクト全体の概要 |
| `docs/language.md` | tinyc 言語仕様 |
| `docs/compiler.md` | コンパイラ設計 |
| `docs/kernel.md` | OS カーネル設計 |
| `docs/filesystem.md` | ファイルシステム設計 |
| `docs/roadmap.md` | 開発ロードマップ |
| `docs/tinyc_cheatsheet.md` | tinyc 言語クイックリファレンス |
| `docs/bc_format.md` | バイトコード（`.bc`）フォーマット仕様 |
| `docs/sources.md` | このファイル：ソースファイル一覧と説明 |
