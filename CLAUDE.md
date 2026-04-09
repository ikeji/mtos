# 作業ルール

- タスクは1つずつ実装し、完了したら必ずgitコミットしてから一時停止する。
- 次のタスクに進む前にユーザーの確認を待つ。

---

# プロジェクト チートシート

## ディレクトリ構成

```
bootstrap/  C実装のコンパイラ（ブートストラップ用、Gen1）
  crt0.s             GCCリンク用スタートアップ
  runtime_syscall.c  Cランタイム（プールアロケータ、syscallスタブ）
  extract_sigs.c     .th ヘッダ抽出ツール（AST → export シグネチャ）
  codegen_main.c     codegen エントリポイント（parse+typecheck+codegen 一体）
  typecheck_main.c   typecheck エントリポイント
  parse_main.c       parse エントリポイント
  lexer.c parser.c ast.c typecheck.c codegen.c interp.c  共有ライブラリ
  bcrun.c            バイトコードインタープリタ
  bc2asm.c           バイトコード→RISC-V asm 変換
  crt0_tc.s          asm.tcリンク用スタートアップ（compile-gen2/3.sh で使用）
  crt0_tc_data.s     asm.tcリンク用プールメタデータ（compile-gen2/3.sh で使用）
compiler/   自作TinyC製の自己ホスト型コンパイラ（Gen2/Gen3）
  parse.tc           レキサー＋パーサー（ソース → AST .ast）
  typecheck.tc       型チェック＋オーバーロード解決（AST → 型付きAST .tast）
  codegen.tc         コード生成（型付きAST → バイトコード .bc、ストリーミング処理）
  bc2asm.tc          バイトコード → RISC-V asm .s 変換
  extract_sigs.tc    .th ヘッダ抽出ツール（TC版）
  string_buffer.tc   伸長バッファライブラリ（parse.tc 等から import）
  source_reader.tc   ストリーミング入力リーダー（4KBバッファ）
  strlib.tc          共通ユーティリティ（is_digit, is_alpha 等）
  bcrun.tc           バイトコードインタープリタ（TC版）
  asm.tc             RISC-Vアセンブラ（.s → ELF32、GCC不要、compile-gen2/3.sh で使用）
  runtime.tc         TinyC製ランタイム（プールアロケータ等、compile-gen2/3.sh で使用）
tests/      テストスイート
  golden/            Gen1 の基準出力（.ast .bc .s .out .exit）
  golden/tc/         compiler/ ソースの基準出力
  test_all.sh        全テストスイートのエントリポイント
  test_common.sh     共通ライブラリ（パス、カウンタ、Gen2 ツールビルド等）
  test_unit.sh       単体テスト（parse/typecheck/codegen/interp/bcrun/rv32）
  test_pipeline.sh   Gen2 パイプラインテスト（qemu rv32）
  test_consistency.sh  tc_run_all 全メソッド一致テスト
  test_golden_examples.sh  サンプル .tc の golden テスト
  test_gen3.sh       Gen1 vs golden、Gen2 AST比較、Gen2 vs Gen3 自己ホスト確認
  test_import.sh     複数ファイル import/export のテスト
docs/       仕様・設計ドキュメント
  ast_format.md      AST ファイルフォーマット（.ast/.tast/.th）
  bc_format.md       バイトコード形式仕様
  language.md        TinyC言語仕様
  tinyc_cheatsheet.md  TinyC構文チートシート
  sources.md         ソースファイル一覧
  task/              タスク計画・デバッグノート
os/         OSカーネル（作成中）
```

## ビルド＆実行

```bash
make                              # Gen1 バイナリをビルド（parse, codegen, bc2asm, typecheck, extract-sigs 等）
make test                         # テスト実行（約35秒）
make update-golden                # goldenファイルを再生成
make update-golden-and-run-test   # golden 再生成してからテスト実行
```

## 世代の定義

- **Gen1**: `bootstrap/` の C コードを GCC で x86_64 にコンパイルしたもの
- **Gen2**: `compiler/` の TC コードを Gen1 でコンパイルし RV32 ELF にしたもの（`compile-gen1.sh`）
- **Gen3**: `compiler/` の TC コードを Gen2 でコンパイルし RV32 ELF にしたもの（`compile-gen2.sh`）

## コンパイルスクリプト

```bash
# Gen1 ツール（C版）で .tc → RV32 ELF（Gen2 ツールの生成に使う）
./compile-gen1.sh -o output file.tc

# Gen2 ツール（qemu経由）で .tc → RV32 ELF（Gen3 ツールの生成に使う）
GEN2_DIR=/path/to/gen2 ./compile-gen2.sh -o output file.tc

# Gen3 ツール（qemu経由）で .tc → RV32 ELF（Gen2==Gen3 の確認に使う）
GEN3_DIR=/path/to/gen3 ./compile-gen3.sh -o output file.tc
```

compile-gen1.sh パイプライン:
1. import 先の .tc を再帰的に収集
2. 各 .tc を個別にコンパイル → .s
3. 全 .s を GCC でリンク（crt0.s + runtime_syscall.c）

compile-gen2/gen3.sh パイプライン:
1. import 先の .tc を再帰的に収集
2. Gen1 parse + extract-sigs で import 先の .th（tc header）を生成
3. runtime.tc + 各 .tc を個別にコンパイル → .s
4. crt0_tc.s + runtime.s + 全 .s + crt0_tc_data.s → asm.tc → ELF（GCC 不要）

## 中間ファイル拡張子

| ステージ | 出力 | 拡張子 |
|---|---|---|
| parse | AST（S式） | `.ast` |
| extract-sigs | exportシグネチャ | `.th` (tc header) |
| typecheck | 型付きAST | `.tast` |
| codegen | バイトコード | `.bc` |
| bc2asm | アセンブリ | `.s` |

詳細は `docs/ast_format.md` と `docs/bc_format.md` を参照。

## コンパイルパイプライン

### Gen1（C版、codegen が内部で parse+typecheck+codegen を一体実行）
```
source.tc → ./codegen source.tc → .bc → ./bc2asm → .s
```
codegen 内部の typecheck が import 先ファイルを読んでシグネチャを収集する。

### Gen2/Gen3（各ツール分離、stdin ストリーミング）
```
source.tc → parse → .ast → typecheck → .tast → codegen → .bc → bc2asm → .s
```
import 解決は typecheck が担当。.th で import 先のシグネチャを受け取る:
```bash
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
- `tests/test_all.sh` — 全スイートのエントリポイント（`make test`）
- `tests/test_unit.sh` — Gen1 単体テスト（parse/typecheck/codegen/interp/bcrun/rv32）
- `tests/test_pipeline.sh` — Gen2 パイプラインテスト（qemu rv32 native）
- `tests/test_consistency.sh` — tc_run_all 全メソッド一致テスト
- `tests/test_golden_examples.sh` — サンプル .tc ファイルの golden テスト
- `tests/test_gen3.sh` — Gen1 vs golden、Gen2 AST vs Gen1 AST、Gen2==Gen3 BC
- `tests/test_import.sh` — 複数ファイル import/export のテスト
- `tests/test_common.sh` — 共通ライブラリ（パス、カウンタ、Gen2 ツールビルド等）

### Gen2 ツールのビルド
- `build_gen2_tool` は `compile-gen1.sh` を使用（GCC リンカ + runtime_syscall.c）
- `ensure_gen2_tools` は qemu + riscv-gcc が必要

### テスト内容
- Gen1 出力 vs golden ファイル（AST, BC, ASM）
- Gen2 AST vs Gen1 AST（コメント除去・空白正規化後の構造比較）
- Gen2 BC/ASM vs golden（import なしファイルのみ）
- Gen2 == Gen3 BC（自己ホスト確認、import なしファイルのみ）
- 実行結果テスト（Gen2 rv32 via qemu）

## bc2asm の注意点
- 条件分岐は `bnez/beqz 0f; j target; 0:` パターンを使用
  （B-type ±4KB 制限を回避、J-type ±1MB で十分、数字ラベルでファイル間衝突なし）
- 関数内ジャンプラベルは `.L_FNAME_pcN` 形式（関数マングル名でグローバル一意）
- セクション出力順: .text → .data → .rodata（asm.tc がフラット配置するため）
- eval stack の最大深さを計算し frame_size に含める

## asm.tc の注意点
- セクションディレクティブ（.text, .data, .bss）は無視しフラット配置
- ELF: p_offset=0、ヘッダ(84B)+コードを1つの LOAD セグメントで出力
- 数字ラベル（0:-9:）対応、パス1で定義収集、パス2で参照解決
- MAX_CODE=~4MB、数字ラベル最大1024個/digit

## レガシー: tc_asm.sh

tc_asm.sh は compile-gen2/3.sh 以前の旧パイプライン。
現在は compile-gen1.sh（GCC リンカ）+ compile-gen2/3.sh（asm.tc リンカ）を使用。

## 言語仕様

- `docs/language.md` — TinyC言語仕様
- `docs/bc_format.md` — バイトコード形式仕様
- `docs/ast_format.md` — AST ファイルフォーマット（.ast/.tast/.th）
- `docs/sources.md` — ソースファイル一覧と説明
- `docs/tinyc_cheatsheet.md` — TinyC構文チートシート
