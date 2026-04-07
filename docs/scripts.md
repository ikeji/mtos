# スクリプト一覧と呼び出し関係

## 呼び出しグラフ

```
make test
  └── tests/test_all.sh              ← メインエントリポイント
        ├── tests/test_unit.sh             ← 単体テスト (parse/typecheck/codegen/interp/bcrun/rv32)
        ├── tests/test_pipeline.sh         ← 自己ホスト版パイプラインテスト
        ├── tests/test_consistency.sh      ← tc_run_all 全メソッド一致テスト
        ├── tests/test_golden_examples.sh  ← サンプル .tc の Golden テスト
        ├── tests/test_golden_compiler.sh  ← compiler/ ソースの Golden テスト
        ├── tests/test_gen3.sh             ← Gen2==Gen3 自己ホスト検証
        └── tests/test_import.sh           ← import/export テスト

make update-golden
  └── tests/update_golden.sh         ← Golden ファイル再生成
```

`tests/test_common.sh` は共通ライブラリ（`source` で読み込み）。
ツールパス、カウンタ、report 関数、`compile_tc_to_bc`、Gen2 ツールビルド等を提供。

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

| スクリプト | 説明 |
|-----------|------|
| `test_all.sh` | 全7スイートを順に実行し、結果を集計するエントリポイント |
| `test_common.sh` | 共通ライブラリ。パス定義、カウンタ、report 関数、Gen2 ツールビルド、`compile_tc_to_bc` |
| `test_unit.sh` | 単体テスト: parse/typecheck/codegen 出力チェック、interp/bcrun/rv32 実行テスト |
| `test_pipeline.sh` | 自己ホスト版コンパイラでのコンパイル＋実行テスト |
| `test_consistency.sh` | tc_run_all による全メソッドの出力一致テスト |
| `test_golden_examples.sh` | サンプル .tc ファイルの Golden テスト（Gen1 vs Gen2） |
| `test_golden_compiler.sh` | compiler/ ソース自体の Golden テスト。rv32 ネイティブ実行で高速化 |
| `test_gen3.sh` | Gen2 == Gen3 自己ホスト検証（RISC-V qemu）。ピークメモリも表示 |
| `test_import.sh` | import/export 機能のテスト |
| `update_golden.sh` | Golden ファイル再生成。rv32 ネイティブ実行で高速化 |

### test_common.sh の提供する機能

- **ツールパス**: PARSE, CODEGEN, BCRUN, BC2ASM, INTERP, RISCV_CC, QEMU 等
- **カウンタ・report**: PASS/FAIL, `report_pass`, `report_fail_diff`, `report_fail_msg`, `check_output`, `check_contains`, `print_results`
- **compile_tc_to_bc**: import を解決して BC をマージ
- **Gen2 ツール**: `ensure_gen2_tools` (RISC-V ネイティブビルド), `run_parse_tc`/`run_typecheck_tc`/`run_codegen_tc`/`run_bc2asm_tc` (native or bcrun fallback)
- **共通データ**: `EXAMPLE_FILES`, `TC_FILES`, `get_stdin`, `get_tc_exec_input_file`
