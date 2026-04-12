# 作業ルール

- タスクは1つずつ実装し、完了したら必ずgitコミットしてから一時停止する。
- 次のタスクに進む前にユーザーの確認を待つ。
- `make test` の実行時間は 1 分以内を維持する。新規テストを追加するときは
  既存テストの合計時間と合わせてこの上限を超えないか確認する。

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
  crt0_tc.s          asm.tcリンク用 Linux crt0（_start, syscall stub, peek/poke）
  crt0_tc_data.s     asm.tcリンク用プールメタデータ (`.data` + `.bss` + __arena)
pico2/      Raspberry Pi Pico 2 (RP2350 RISC-V) 向け
  hello.tc           TC 言語で書いた UART hello world
  crt0_pico2.s       IMAGE_DEF + _start + XOSC/UART 初期化 + UART syscall
  crt0_pico2_data.s  pool metadata / __arena (.rodata + .bss)
  bin2uf2.py         raw bin → UF2 コンバータ
  build.sh           hello.tc を hello.uf2 にビルド
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
  test_asm.sh        hello2.tc を virt crt0 でビルドして qemu-system-riscv32 で実行
  virt_crt0.s        qemu-system-riscv32 -M virt 用 crt0（16550 UART + SiFive test 終了）
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
make test                         # テスト実行（約50秒、上限 60 秒）
make update-golden                # goldenファイルを再生成
make update-golden-and-run-test   # golden 再生成してからテスト実行
```

## Pico 2 (RP2350 RISC-V) ビルド

```bash
./pico2/build.sh                  # pico2/hello.tc → pico2/hello.uf2
```

内部では Gen1 parse + Gen2 (typecheck/codegen/bc2asm/asm, qemu-riscv32 経由)
+ `pico2/crt0_pico2.s` + `pico2/crt0_pico2_data.s` + `compile-pico2.sh` の
パイプラインで raw bin を作り、`pico2/bin2uf2.py` で UF2 化する。
Gen2 ツールは `/tmp/gen2_pico2/` にキャッシュされる。

実機テスト:
1. Pico 2 の BOOTSEL ボタンを押しながら USB 接続 → マスストレージとしてマウント
2. `pico2/hello.uf2` をドラッグ&ドロップ
3. GPIO0 (TX) / GPIO1 (RX) / GND をシリアルアダプタに接続
4. 115200 bps, 8N1 で `Hello, Pico 2!` を受信

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
- `tests/test_asm.sh` — hello2.tc を `; raw` モードで compile-gen2.sh にかけ、
  qemu-system-riscv32 -M virt で実行して "Hello, World" 出力を検証
- `tests/test_common.sh` — 共通ライブラリ（パス、カウンタ、Gen2 ツールビルド等）

### Gen2 ツールのビルド
- `build_gen2_tool` は `compile-gen1.sh` を使用（GCC リンカ + runtime_syscall.c）
- `ensure_gen2_tools` は qemu-riscv32 + riscv-gcc が必要。parse / typecheck /
  codegen / bc2asm / bcrun / asm を Gen2 として一式ビルドする。
- `tests/test_asm.sh` は追加で qemu-system-riscv32 が必要（無ければ SKIP）。

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
- asm.tc はこのツールチェーンの「アセンブラ兼リンカ」。入力 `.s` を per-section
  cursor で集計し、出力では text → rodata → data → bss の順に物理的に並べ替える
  (pass 2 の `g_pos` を行ごとに `section_base[sec] + sec_pos[sec]` に切り替える)。
- ラベルアドレスは常にコード先頭からのオフセット（PIC）。`la`/`jal`/分岐は
  PC 相対で unchanged、`.word symbol` はオフセット値を埋め込む。
- data/bss セクションのラベルへの `la` は常に gp 相対 (`auipc rd, 0` +
  `addi rd, gp, offset`) に展開される。12-bit signed 範囲外の場合は自動的に
  PC 相対 (`auipc + addi`) にフォールバック。text と data/bss が同じ LOAD
  segment に入る環境 (Linux/virt) ではフォールバックが通常動作する。
- `__global_pointer$` は pass 1 終了後に asm.tc が自動的に `data_base + 0x800`
  に定義する。Linux/virt 用 `crt0_tc.s` は `la gp, __global_pointer$` で
  runtime gp を初期化する (PC 相対 la なので gp 未初期化でも動作)。Pico 2 用
  crt0 は同じラベルを参照するか、または SRAM の絶対値で `li gp, 0x20000800`
  のようにセットする。
- 各セクションのサイズは 16 バイトにアラインされる。これは `.align 4`
  (RISC-V GNU as で 2^4 = 16 バイトアラインメント) を pass 1 (intra 0 から
  始まる) と pass 2 (section_base から始まる) で整合させるため。
- ELF 出力: p_offset=0、ヘッダ(84B)+コードを 1 つの LOAD セグメントで出力。
  `g_code_end` までを filesz、`mem_size` を memsz として書き出すので、
  末尾の `.space`（`__arena` 等）は filesz に含まれず memsz だけ広がる。
- 数字ラベル（0:-9:）対応、パス1で定義収集、パス2で参照解決 (text セクション
  前提で section_base の fixup は行わない)
- MAX_CODE=~4MB、数字ラベル最大1024個/digit
- stdin 先頭ディレクティブ:
  - `; raw` — ELF ヘッダを出さず、code 部分だけを raw bin として出力
  - `; load_base 0xHHHHHHHH` — ELF 出力時の `e_entry`/`p_vaddr`/`p_paddr` を
    この値ベースに設定（デフォルト 0x10000）

## compile-gen2.sh の環境変数
デフォルトは Linux ELF 用の crt0 だが、以下を設定すると別ターゲット
（qemu virt, Pico 2 等）向けにビルドできる:
- `CRT0` — `.s` ファイルパス。デフォルト `compiler/crt0_tc.s`
- `CRT0_DATA` — `.s` ファイルパス。デフォルト `compiler/crt0_tc_data.s`
- `ASM_PROLOGUE` — asm.tc 入力先頭に注入する 1 行（例 `; raw`）
- `GEN2_DIR` — Gen2 ツール (parse/typecheck/codegen/bc2asm/asm) の置き場所

## レガシー: tc_asm.sh

tc_asm.sh は compile-gen2/3.sh 以前の旧パイプライン。
現在は compile-gen1.sh（GCC リンカ）+ compile-gen2/3.sh（asm.tc リンカ）を使用。

## 言語仕様

- `docs/language.md` — TinyC言語仕様
- `docs/bc_format.md` — バイトコード形式仕様
- `docs/ast_format.md` — AST ファイルフォーマット（.ast/.tast/.th）
- `docs/sources.md` — ソースファイル一覧と説明
- `docs/tinyc_cheatsheet.md` — TinyC構文チートシート
