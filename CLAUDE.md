# 作業ルール

- タスクは1つずつ実装し、完了したら必ずgitコミットしてから一時停止する。
- 次のタスクに進む前にユーザーの確認を待つ。

---

# プロジェクト チートシート

## ディレクトリ構成

```
compiler/   C実装のコンパイラ（ブートストラップ用）
tc/         自作TinyC製の自己ホスト型コンパイラ
  parse.tc      レキサー＋パーサー（ソース→AST）
  codegen.tc    コード生成（AST→バイトコード）
  bc2asm.tc     アセンブラ（バイトコード→RISC-V asm）
  bcrun.tc      バイトコードインタープリタ
tests/      テストスイート
  golden/         C実装の基準出力（.ast .bc .s .out .exit）
  golden/tc/      tc/コンパイラソース自体の基準出力
docs/       仕様・設計ドキュメント
os/         OSカーネル（作成中）
```

## ビルド＆実行

```bash
make                  # 全バイナリをビルド（parse, codegen, bcrun, bc2asm, interp, typecheck）
make test             # テスト実行
make update-golden    # goldenファイルを再生成
```

## .tcファイルの実行方法

```bash
./tc_run.sh interp    foo.tc          # ASTインタープリタで直接実行（速い）
./tc_run.sh bcrun     foo.tc          # Cコード生成→バイトコード実行
./tc_run.sh rv32      foo.tc          # Cコード生成→RISC-V→qemu実行
./tc_run.sh pipeline  foo.tc          # 自己ホスト版(parse.tc+codegen.tc)で実行
./tc_run.sh bc2asm_tc foo.tc          # 自己ホスト版bc2asm→RISC-V→qemu実行
# stdinを渡す場合
./tc_run.sh bcrun     calc.tc "1 + 2"
./tc_run.sh bcrun     calc.tc @input.txt
```

## コンパイルパイプライン

```
source.tc
  → ./parse source.tc              # AST（S式テキスト形式）
  → ./parse | ./codegen            # バイトコード（.bc形式）
  → ./parse | ./codegen | ./bc2asm # RISC-V アセンブリ（.s形式）
  → ./bcrun                        # バイトコード実行（stdin経由でbcを渡す）
```

## テスト構造

### 世代の定義
- **Gen1 (C実装)**: `compiler/` の C コンパイラ（ブートストラップ用）
- **Gen2**: `tc/` のコンパイラを Gen1 でコンパイルしたもの
- **Gen3**: `tc/` のコンパイラを Gen2 でコンパイルしたもの

### 現在のテスト（Gen1 vs Gen2 の比較）
- `tests/run_golden_tests.sh` — golden（Gen1出力）と自己ホスト実装（Gen2）を比較
  - `AST - C` / `AST - parse.tc` — パーサー出力の一致確認（Gen1 vs Gen2）
  - `BC - C` / `BC - codegen.tc` — バイトコードの一致確認（Gen1 vs Gen2）
  - `ASM - C` / `ASM - bc2asm.tc` — アセンブリの一致確認（Gen1 vs Gen2）
  - `Exec - bcrun C` / `Exec - bcrun tc` — 実行結果の確認
  - `Exec - rv32 C` / `Exec - rv32 tc` — RISC-V実機（qemu）での実行確認
- goldenファイルの更新: `make update-golden`

### 未実装：Gen2 vs Gen3 の比較（真の自己ホスト確認）
Gen2 == Gen3 を確認することで、自己ホストコンパイラが正しく自分自身をコンパイルできることを証明できる。

## 言語仕様

- `docs/language.md` — TinyC言語仕様
- `docs/bc_format.md` — バイトコード形式仕様
- `docs/sources.md` — ソースファイル一覧と説明
- `docs/tinyc_cheatsheet.md` — TinyC構文チートシート
