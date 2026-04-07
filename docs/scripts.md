# スクリプト一覧と呼び出し関係

## 呼び出しグラフ

```
make test
  └── tests/run_tests.sh          ← メインテストランナー
        ├── (直接テスト: unit/pipeline/bc2asm/tc_run_all)
        └── tests/run_golden_tests.sh   ← Golden テストスイート
              ├── tests/run_example_tests.sh   ← サンプル .tc の Golden
              ├── tests/run_compiler_tests.sh  ← compiler/ ソースの Golden
              ├── tests/run_gen3_tests.sh      ← Gen2==Gen3 自己ホスト検証
              └── tests/run_import_tests.sh    ← import/export テスト

make update-golden
  └── tests/update_golden.sh      ← Golden ファイル再生成

(ユーザー直接実行)
  tc_run.sh        ← .tc ファイルを指定メソッドで実行
  tc_run_all.sh    ← 全メソッドで実行して出力を比較
  tc_build.sh      ← 複数 .tc ファイルのコンパイル＋リンク
```

`tests/compile_tc.sh` は共通ライブラリ（`source` で読み込み）。
`compile_tc_to_bc` 関数を提供し、import を解決して BC をマージする。

---

## 各スクリプトの詳細

### ユーザー向けスクリプト（ルート）

| スクリプト | 説明 | 使い方 |
|-----------|------|--------|
| `tc_run.sh` | .tc ファイルを指定メソッドで実行 | `./tc_run.sh <method> <file.tc> [stdin]` |
| `tc_run_all.sh` | 全5メソッドで実行し出力一致を確認 | `./tc_run_all.sh <file.tc> [stdin]` |
| `tc_build.sh` | 複数 .tc を RISC-V ELF にコンパイル＋リンク | `./tc_build.sh -o prog main.tc lib.tc` |

#### tc_run.sh のメソッド

| メソッド | パイプライン |
|---------|-------------|
| `interp` | parse → typecheck → interp（AST 直接実行） |
| `bcrun` | codegen → bcrun（バイトコード実行） |
| `rv32` | codegen → bc2asm → riscv-gcc → qemu |
| `pipeline` | parse.tc → typecheck.tc → codegen.tc（全て bcrun 上で実行） |
| `bc2asm_tc` | codegen(C) → bc2asm.tc(bcrun) → riscv-gcc → qemu |

### テストスクリプト（tests/）

| スクリプト | 説明 | 呼ばれ方 |
|-----------|------|---------|
| `run_tests.sh` | メインテストランナー。単体テスト + golden テストを実行 | `make test` |
| `run_golden_tests.sh` | 4つの golden テストサブスイートを束ねるラッパー | `run_tests.sh` から |
| `run_example_tests.sh` | サンプル .tc ファイルの golden テスト（Gen1 vs Gen2） | `run_golden_tests.sh` から |
| `run_compiler_tests.sh` | compiler/ ソース自体の golden テスト（Gen1 vs Gen2） | `run_golden_tests.sh` から |
| `run_gen3_tests.sh` | Gen2 == Gen3 の自己ホスト検証（RISC-V qemu） | `run_golden_tests.sh` から |
| `run_import_tests.sh` | import/export 機能のテスト | `run_golden_tests.sh` から |
| `update_golden.sh` | Golden ファイル（.ast, .bc, .s, .out, .exit）を C ツールで再生成 | `make update-golden` |
| `compile_tc.sh` | 共通ライブラリ。`compile_tc_to_bc` 関数を提供 | `source` で読み込み |

### run_tests.sh の内部構成

`run_tests.sh` は以下を順に実行:

1. **単体テスト** — parse/typecheck/codegen の基本出力チェック
2. **実行テスト** — interp/bcrun/rv32 でのサンプルプログラム実行
3. **パイプラインテスト** — 自己ホスト版コンパイラでのコンパイル＋実行
4. **bc2asm.tc テスト** — 自己ホスト版 bc2asm でのアセンブリ生成＋実行
5. **tc_run_all 整合性テスト** — 全メソッドの出力一致確認
6. **Golden テスト** — `run_golden_tests.sh` 経由で全サブスイート実行

### compile_tc.sh の仕組み

`compile_tc_to_bc <file.tc>` は以下を行う:

1. .tc ファイルから `import "xxx.tc"` を抽出
2. 各 import ファイルを `$CODEGEN` で BC に変換
3. メインファイルも BC に変換
4. 全 BC から `.bc`/`.endbc` ヘッダを除去してマージ
5. 末尾に `.endbc` を付加して出力
