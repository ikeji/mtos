# compile-gen1/gen2/gen3.sh スクリプト作成計画

## 背景

ビルドパイプラインを明確化し、bcrun への依存を排除する。
各世代のコンパイラを使ったコンパイルスクリプトを作成する。

## 世代の定義

- **Gen1**: `bootstrap/` の C コード → GCC で x86_64 にコンパイル（`make`）
- **Gen2**: `compiler/` の TC コード → Gen1 ツールで RV32 にコンパイル（`compile-gen1.sh`）
- **Gen3**: `compiler/` の TC コード → Gen2 ツールで RV32 にコンパイル（`compile-gen2.sh`）

## スクリプト仕様

### compile-gen1.sh — Gen1 ツール（C版）でコンパイル

```
compile-gen1.sh [-o output] file.tc
```

パイプライン:
1. import 先の .tc を再帰的に収集
2. 各 .tc を個別に: Gen1 codegen → Gen1 bc2asm → .s
3. 全 .s を GCC でリンク（crt0.s + runtime_syscall.c）

Gen1 codegen は内部で typecheck を行い、import 先のファイルを読んで
export fn のシグネチャと struct の型名を収集する（コード生成はしない）。

**状態: 実装済み、動作確認済み**

### compile-gen2.sh — Gen2 ツール（qemu）でコンパイル

```
GEN2_DIR=/path/to/gen2 compile-gen2.sh [-o output] file.tc
```

パイプライン:
1. import 先の .tc を再帰的に収集
2. 各 .tc を個別に: Gen2 parse → Gen2 typecheck → Gen2 codegen → Gen2 bc2asm → .s
3. 全 .s を GCC でリンク（crt0.s + runtime_syscall.c）

### compile-gen3.sh — Gen3 ツール（qemu）でコンパイル

compile-gen2.sh と同じ構造。GEN3_DIR を指定する。

## 課題: Gen2 typecheck.tc の import 解決

### 現状

- Gen1 typecheck (C版): import ノードを見つけると、import 先の .tc を
  ソースから読み込み、parse して export fn のシグネチャと struct の型名を収集
- Gen2 typecheck.tc: import ノードを**無視**する

### import 解決に必要な情報

typecheck が import 先から必要とするのは:
- **export fn のシグネチャ**: 関数名、引数の型名リスト、返り値型名
- **struct の型名**: 名前のみ（フィールド情報は不要）

AST 全体を読む必要はない。

### 方針: シグネチャ抽出ツール + typecheck.tc 拡張

**1. ヘッダ抽出ツール（extract-sigs）を作る**

AST から export fn / struct のシグネチャだけを抽出するフィルタツール。

入力: AST（stdin、S式）
出力: `.th` ファイル（AST のサブセット、S式）

.th は AST と同じ S式フォーマットだが、以下だけを含む:
- export fn のヘッダ（params + ret のみ、body を除去）
- struct の型名（field を除去）

```
(program
  (fn emit_char :export
    (params (param sb (type StringBuffer)) (param c (type u8)))
    (ret (type void))
  )
  (fn StringBuffer_new :export
    (params)
    (ret (type StringBuffer))
  )
  (struct StringBuffer)
)
```

extract-sigs は AST フィルタ:
- export でない fn を削除
- fn の body（block ノード）を削除
- struct の field を削除
- import, var 等のノードを削除

Gen1 (C版) と Gen2 (TC版) の両方を作る。
TC版は AST を read_node() で読み、フィルタして emit するだけ。

**2. typecheck.tc に .th 読み込みを追加**

typecheck.tc に以下を追加:
- コマンドライン引数で .th ファイルパスを受け取る
- .th を read_node() で読む（既存の AST リーダーをそのまま流用）
- fn ノードから collect_fn() でシグネチャを fntab に登録
- struct ノードから型名を登録
- import ノードをスキップ（解決済み）

**3. compile-gen2.sh のパイプライン**

parse.tc（string_buffer.tc を import）をコンパイルする例:

```bash
# import 先のヘッダ（.th）を抽出
qemu gen2/parse < string_buffer.tc | qemu gen2/extract-sigs > /tmp/string_buffer.th

# メインファイルをコンパイル（.th を渡す — typecheck が read_node() で読む）
qemu gen2/parse < parse.tc \
  | qemu gen2/typecheck /tmp/string_buffer.th \
  | qemu gen2/codegen \
  | qemu gen2/bc2asm > /tmp/parse.s

# import 先もコンパイル
qemu gen2/parse < string_buffer.tc \
  | qemu gen2/typecheck \
  | qemu gen2/codegen \
  | qemu gen2/bc2asm > /tmp/string_buffer.s

# リンク
riscv-gcc crt0.s /tmp/parse.s /tmp/string_buffer.s runtime_syscall.c -o parse
```

### 中間ファイル拡張子

| ステージ | 出力 | 拡張子 |
|---|---|---|
| parse | AST（S式） | `.ast` |
| typecheck | 型付きAST | `.tast` |
| codegen | バイトコード | `.bc` |
| bc2asm | アセンブリ | `.s` |
| extract-sigs | exportシグネチャ | `.th` (tc header) |

### .th フォーマット詳細

AST と同じ S式フォーマットのサブセット。typecheck.tc の既存 read_node() で読める。

```
(program
  (struct <name>)
  (fn <name> :export
    (params (param <name> (type <type>)) ...)
    (ret (type <type>))
  )
  ...
)
```

例（string_buffer.tc の .th）:
```
(program
  (struct StringBuffer)
  (fn StringBuffer_new :export
    (params)
    (ret (type StringBuffer))
  )
  (fn StringBuffer_new :export
    (params (param fd (type i32)))
    (ret (type StringBuffer))
  )
  (fn emit_char :export
    (params (param sb (type StringBuffer)) (param c (type u8)))
    (ret (type void))
  )
  (fn emit_string :export
    (params (param sb (type StringBuffer)) (param s (type StringLiteral)))
    (ret (type void))
  )
  ...
)
```

## 実装順序

1. [x] compile-gen1.sh 作成
2. [x] compile-gen2.sh 雛形作成（import なしファイルのみ）
3. [x] シグネチャフォーマット確定（.th、AST サブセット）
4. [x] C版 extract-sigs 作成（Gen1 用）
5. [x] typecheck.tc / typecheck.c にシグネチャ読み込み追加
6. [x] TC版 extract-sigs 作成（Gen2 用）
7. [x] compile-gen2.sh を import 対応に拡張
8. [x] compile-gen3.sh 作成（compile-gen2.sh と同構造）
9. [x] test_common.sh を compile-gen1.sh / compile-gen2.sh ベースに更新
10. [x] CLAUDE.md 更新

## 既知の制限

- compile-gen2.sh / gen3.sh の .th 生成は Gen1 parse + Gen1 extract-sigs を使用
  （Gen2 parse にコメントノードの括弧バランス問題があるため）
- 将来 Gen2 parse が修正されれば、完全に Gen2 ツールだけで .th 生成が可能になる
