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
compiler/   自作TinyC製の自己ホスト型コンパイラ
  parse.tc      レキサー＋パーサー（ソース→AST）
  typecheck.tc  型チェック＋オーバーロード解決（AST→型付きAST）
  codegen.tc    コード生成（型付きAST→バイトコード、ストリーミング処理）
  bc2asm.tc     アセンブラ（バイトコード→RISC-V asm）
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
make                              # 全バイナリをビルド（parse, codegen, bcrun, bc2asm, interp, typecheck）
make test                         # テスト実行
make update-golden                # goldenファイルを再生成
make update-golden-and-run-test   # golden 再生成してからテスト実行
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

## GCC不要のセルフホスト版ビルド

```bash
./tc_asm.sh -o output.elf foo.tc      # runtime.tc + asm.tc で ELF 生成（GCCリンカ不要）
```

tc_asm.sh パイプライン:
```
foo.tc → codegen(--no-builtins runtime.tc + foo.tc) → bc2asm → crt0_tc.s + asm.tc → ELF
```

- import 解決を自動で行う（compile_tc_to_bc と同等）
- crt0_tc_data.s（プールメタデータ+アリーナ）はコード末尾に配置
  （asm.tc はセクションディレクティブを無視するため）
- asm.tc はラベル→アドレスのマップを stderr に出力（デバッグ用）

## 複数ファイルのコンパイル

```bash
./tc_build.sh -o prog main.tc lib.tc  # 複数 .tc ファイルをコンパイル＋リンク
```

`import "lib.tc";` で他ファイルの `export fn` を呼べる。struct は**型名として**使えるが、
自動生成関数（コンストラクタ、getter/setter、delete）は import 先から呼べないので、
必要なら `export fn` のラッパーを定義する。詳細は `docs/task/multi_file.md`。

## コンパイルパイプライン

```
source.tc
  → ./parse source.tc              # AST（S式テキスト形式）
  → ./codegen source.tc            # バイトコード（.bc形式、typecheck込み、import 解決）
  → ./codegen source.tc | ./bc2asm # RISC-V アセンブリ（.s形式）
  → ./bcrun                        # バイトコード実行（stdin経由でbcを渡す）
```

import を含むファイルは `./codegen source.tc` のようにファイル引数で渡す必要がある
（パイプ経由ではファイル名情報が失われ相対パス解決ができない）。

自己ホスト版のパイプライン: `parse.tc → typecheck.tc → codegen.tc → bc2asm.tc/bcrun.tc`
（C版の `codegen` は内部で typecheck を呼ぶが、自己ホスト版は明示的に分離）

## テスト構造

### 世代の定義
- **Gen1 (C実装)**: `bootstrap/` の C コンパイラ（ブートストラップ用）
- **Gen2**: `compiler/` のコンパイラを Gen1 でコンパイルし、tc_asm.sh で RISC-V ELF にしたもの
- **Gen3**: `compiler/` のコンパイラを Gen2 でコンパイルしたもの

### テストスクリプト構成
- `tests/test_all.sh` — 全7スイートを実行するエントリポイント（`make test`）
- `tests/test_common.sh` — 共通ライブラリ（パス、カウンタ、Gen2 ツールビルド等）
- `tests/test_unit.sh` — 単体テスト（parse/typecheck/codegen/interp/bcrun/rv32）
- `tests/test_pipeline.sh` — 自己ホスト版パイプラインテスト
- `tests/test_consistency.sh` — tc_run_all 全メソッド一致テスト
- `tests/test_golden_examples.sh` — サンプル .tc ファイルの golden テスト（Gen1 vs Gen2）
- `tests/test_golden_compiler.sh` — compiler/ ソースの golden テスト（rv32 ネイティブ高速化）
- `tests/test_gen3.sh` — Gen2 vs Gen3 自己ホスト確認
- `tests/test_import.sh` — 複数ファイル import/export のテスト
- goldenファイルの更新: `make update-golden`

### Gen2 ツールのビルド
- `build_gen2_tool` は `tc_asm.sh` を使用（GCC リンカ不要）
- `ensure_gen2_tools` は qemu のみ必要（riscv-gcc は不要）

### 現在のテスト（Gen1 vs Gen2 の比較）
- `AST - C` / `AST - parse.tc` — パーサー出力の一致確認（Gen1 vs Gen2）
- `BC - C` / `BC - codegen.tc` — バイトコードの一致確認（Gen1 vs Gen2）
- `ASM - C` / `ASM - bc2asm.tc` — アセンブリの一致確認（Gen1 vs Gen2）
- `Exec - bcrun C` / `Exec - bcrun tc` — 実行結果の確認
- `Exec - rv32 C` / `Exec - rv32 tc` — RISC-V（qemu）での実行確認

### Gen2 vs Gen3 の比較（真の自己ホスト確認）
- `tests/test_gen3.sh` — Gen2 BC == Gen3 BC を確認
  - `compiler/parse.tc (Gen2 == Gen3)` / `compiler/typecheck.tc (Gen2 == Gen3)` / `compiler/codegen.tc (Gen2 == Gen3)` / `compiler/bc2asm.tc (Gen2 == Gen3)`
  - Gen2 コンパイラを tc_asm.sh で RISC-V ELF にして Gen3 を生成
  - 自己ホストコンパイラが正しく自分自身をコンパイルできることを証明する

## tc_asm.sh / runtime.tc / asm.tc の注意点

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

## 既知の問題

### bcrun の参照型キャストバグ
- bcrun は値を `{kind, ival, ref}` で管理。参照型は kind=REF, ival=0, ref=ポインタ
- `cast i32` で参照型を整数に変換せず、ival=0 のまま返す
- そのため `ref as i32 == 0` は**参照がNULLでなくても常に true** になる
- rv32 ネイティブでは参照型=メモリアドレス(i32)なので正常に動作する
- **対策**: TinyC コード内で `ref as i32` による NULL チェックを使わないこと
