# 作業ルール

- タスクは1つずつ実装し、完了したら必ずgitコミットしてから一時停止する。
- 次のタスクに進む前にユーザーの確認を待つ。

---

# プロジェクト チートシート

## ディレクトリ構成

```
bootstrap/  C実装のコンパイラ（ブートストラップ用）
  crt0.s          GCCリンク用スタートアップ
  crt0_tc.s       tc_asm.sh用スタートアップ（.textのみ）
  crt0_tc_data.s  tc_asm.sh用プールメタデータ＋アリーナ（.data/.bss、コード末尾に配置）
  runtime_syscall.c  Cランタイム（GCCリンク用）
  extract_sigs.c  .th ヘッダ抽出ツール（AST → export シグネチャ）
compiler/   自作TinyC製の自己ホスト型コンパイラ
  parse.tc      レキサー＋パーサー（ソース→AST .ast）
  typecheck.tc  型チェック＋オーバーロード解決（AST→型付きAST .tast）
  codegen.tc    コード生成（型付きAST→バイトコード .bc、ストリーミング処理）
  bc2asm.tc     アセンブラ（バイトコード→RISC-V asm .s）
  extract_sigs.tc  .th ヘッダ抽出ツール（TC版）
  bcrun.tc      バイトコードインタープリタ
  asm.tc        RISC-Vアセンブラ（.s→ELF32、GCC不要）
  runtime.tc    TinyC製ランタイム（プールアロケータ、tc_asm.sh用）
  string_buffer.tc  伸長バッファライブラリ（parse.tc から import）
  source_reader.tc  ストリーミング入力リーダー（4KBバッファ）
  strlib.tc     共通ユーティリティ（is_digit, is_alpha等）
tests/      テストスイート
  golden/         C実装の基準出力（.ast .bc .s .out .exit）
  golden/tc/      compiler/コンパイラソース自体の基準出力
  test_all.sh     全テストスイートのエントリポイント
  test_common.sh  共通ライブラリ（パス、カウンタ、Gen2 ツールビルド等）
docs/       仕様・設計ドキュメント
os/         OSカーネル（作成中）
```

## ビルド＆実行

```bash
make                              # 全バイナリをビルド（parse, codegen, bc2asm, interp, typecheck, extract-sigs 等）
make test                         # テスト実行
make update-golden                # goldenファイルを再生成
make update-golden-and-run-test   # golden 再生成してからテスト実行
```

## 世代の定義

- **Gen1 (C実装)**: `bootstrap/` の C コンパイラを GCC で x86_64 にコンパイルしたもの
- **Gen2**: `compiler/` の TC コンパイラを Gen1 でコンパイルし RV32 ELF にしたもの（`compile-gen1.sh`）
- **Gen3**: `compiler/` の TC コンパイラを Gen2 でコンパイルし RV32 ELF にしたもの（`compile-gen2.sh`）

## コンパイルスクリプト

```bash
# Gen1 ツール（C版）でコンパイル → Gen2 ツールの生成に使う
./compile-gen1.sh -o output file.tc

# Gen2 ツール（qemu経由）でコンパイル → Gen3 ツールの生成に使う
GEN2_DIR=/path/to/gen2 ./compile-gen2.sh -o output file.tc

# Gen3 ツール（qemu経由）でコンパイル → Gen2==Gen3 の確認に使う
GEN3_DIR=/path/to/gen3 ./compile-gen3.sh -o output file.tc
```

各スクリプトの共通パイプライン:
1. import 先の .tc を再帰的に収集
2. 各 .tc を個別にコンパイル → .s
3. 全 .s を GCC でリンク（crt0.s + runtime_syscall.c）

compile-gen2.sh / gen3.sh では .th（tc header）を介した import 解決を使う:
- Gen1 parse + extract-sigs で import 先の .th を生成
- typecheck に `(imports ...)` ノードで .th を渡す

## 中間ファイル拡張子

| ステージ | 出力 | 拡張子 |
|---|---|---|
| parse | AST（S式） | `.ast` |
| extract-sigs | exportシグネチャ | `.th` (tc header) |
| typecheck | 型付きAST | `.tast` |
| codegen | バイトコード | `.bc` |
| bc2asm | アセンブリ | `.s` |

## コンパイルパイプライン

### Gen1（C版、内部で parse+typecheck+codegen を一体実行）
```
source.tc → ./codegen source.tc → .bc → ./bc2asm → .s
```
import を含むファイルは `./codegen source.tc` のようにファイル引数で渡す
（内部 typecheck が import 先を読んでシグネチャを収集）。

### Gen2/Gen3（各ツール分離、stdin ストリーミング）
```
source.tc → parse → .ast → typecheck → .tast → codegen → .bc → bc2asm → .s
```
import 解決は typecheck が担当。.th ファイルで import 先のシグネチャを受け取る:
```
{ echo "(imports"; cat import1.th import2.th; echo ")"; parse < source.tc } | typecheck | codegen | bc2asm > source.s
```

## .tcファイルの実行方法

```bash
./tc_run.sh interp    foo.tc          # ASTインタープリタで直接実行（速い）
./tc_run.sh bcrun     foo.tc          # Cコード生成→バイトコード実行
./tc_run.sh rv32      foo.tc          # Cコード生成→RISC-V→qemu実行
./tc_run.sh pipeline  foo.tc          # 自己ホスト版(parse.tc+typecheck.tc+codegen.tc)で実行
./tc_run.sh bc2asm_tc foo.tc          # 自己ホスト版bc2asm→RISC-V→qemu実行
# stdinを渡す場合
./tc_run.sh bcrun     calc.tc "1 + 2"
./tc_run.sh bcrun     calc.tc @input.txt
```

## 複数ファイルのコンパイル

```bash
./tc_build.sh -o prog main.tc lib.tc  # 複数 .tc ファイルをコンパイル＋リンク
```

`import "lib.tc";` で他ファイルの `export fn` を呼べる。struct は**型名として**使えるが、
自動生成関数（コンストラクタ、getter/setter、delete）は import 先から呼べないので、
必要なら `export fn` のラッパーを定義する。詳細は `docs/task/multi_file.md`。

## テスト構造

### テストスクリプト構成
- `tests/test_all.sh` — 全スイートを実行するエントリポイント（`make test`）
- `tests/test_common.sh` — 共通ライブラリ（パス、カウンタ、Gen2 ツールビルド等）
- `tests/test_unit.sh` — 単体テスト（parse/typecheck/codegen/interp/bcrun/rv32）
- `tests/test_pipeline.sh` — Gen2 パイプラインテスト（qemu rv32 native）
- `tests/test_consistency.sh` — tc_run_all 全メソッド一致テスト
- `tests/test_golden_examples.sh` — サンプル .tc ファイルの golden テスト
- `tests/test_gen3.sh` — Gen1 vs golden、Gen2 vs Gen3 自己ホスト確認
- `tests/test_import.sh` — 複数ファイル import/export のテスト
- goldenファイルの更新: `make update-golden`

### Gen2 ツールのビルド
- `build_gen2_tool` は `compile-gen1.sh` を使用（GCC リンカ + runtime_syscall.c）
- `ensure_gen2_tools` は qemu + riscv-gcc が必要

### Gen2 vs Gen3 の比較（真の自己ホスト確認）
- `tests/test_gen3.sh` — Gen2 BC == Gen3 BC を確認
  - Gen2 コンパイラで Gen3 をコンパイルし、バイトコードが一致することを確認
  - 自己ホストコンパイラが正しく自分自身をコンパイルできることを証明する

## tc_asm.sh / runtime.tc / asm.tc の注意点

tc_asm.sh は GCC リンカを使わない自己ホストパイプライン（レガシー）。
現在のメインパイプラインは compile-gen1.sh / compile-gen2.sh（GCC リンカ使用）。

### プールアロケータ (runtime.tc + crt0_tc_data.s)
- 17バケット: 16B〜1MB（各バケット2〜4096ブロック）
- アリーナ: 約4.6MB、スタック: 64KB
- ゼロフィルは poke32 (4バイト単位) — poke8 より4倍高速だが大きな確保は遅い
- `--no-builtins` フラグで runtime.tc をコンパイル（typecheck のビルトイン衝突回避）

### asm.tc の制限
- セクションディレクティブ (.text/.data/.bss) を無視 — 全てフラットに配置
- `.data`/`.bss` は crt0_tc_data.s として**コード末尾に**配置する必要あり
- ラベルマップを stderr に出力（デバッグ用）
- 数値ラベル (`1:`) は各桁256個まで

### bc2asm の注意点
- 条件分岐は `bnez/beqz __skip_N; j target` パターンを使用
  （B-type ±4KB 制限を回避、J-type ±1MB で十分）
- `.rodata` (.string) 後に `.align 2` を出力（4バイトアラインメント保証）
- eval stack の最大深さを計算し frame_size に含める

## 言語仕様

- `docs/language.md` — TinyC言語仕様
- `docs/bc_format.md` — バイトコード形式仕様
- `docs/sources.md` — ソースファイル一覧と説明
- `docs/tinyc_cheatsheet.md` — TinyC構文チートシート
