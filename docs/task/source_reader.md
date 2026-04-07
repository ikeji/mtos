# SourceReader: ストリーミング入力への移行

## 動機

現在の parse.tc はソース全体を StringBuffer に読み込んでからパースする。
これにより:

- `StringBuffer_new()` が grow を繰り返し、32KB〜64KB のバッファを確保
- grow のたびに旧バッファのコピー＋解放が発生
- `emit_stmt_comment` がソース全体をランダムアクセス（行番号→行テキスト検索）
- 43KB のソース (codegen.tc) で pool 65536B バケットを消費

SourceReader を導入し、4KB バッファでストリーミング読み込みすることで
大きなバッファが不要になる。

## 設計

### SourceReader 構造体

```tinyc
struct SourceReader {
    fd: i32,           // 入力ファイルディスクリプタ (0 = stdin)
    buf: U8Array,      // 読み込みバッファ (4092B = 4096B バケットに収まる)
    buf_pos: i32,      // buf 内の現在位置
    buf_len: i32,      // buf 内の有効バイト数
    eof: i32,          // EOF に達したか (0 or 1)
    line: StringBuffer, // 現在の行テキスト（StringBuffer の grow に任せる）
    line_num: i32      // 現在の行番号 (1-origin)
}
```

### API

```tinyc
fn SourceReader_new(fd: i32) -> SourceReader
fn peek(r: SourceReader) -> u8         // 次の1バイトを見る（消費しない）、EOF時は 0
fn next(r: SourceReader) -> u8         // 1バイト読んで進める
fn at_eof(r: SourceReader) -> bool     // EOF に達したか
fn line_num(r: SourceReader) -> i32    // 現在の行番号
fn current_line(r: SourceReader, sb: StringBuffer) -> void
    // 現在の行テキストを sb に emit（先頭空白を除去、末尾改行なし）
```

### 内部動作

- `peek` / `next`: buf_pos < buf_len なら buf から返す。
  buf_pos >= buf_len なら sys_read で 4KB 読み込み。
- `next` が改行 (0x0A) を返すとき:
  - `line_num` をインクリメント
  - `pos(line(r), 0)` で StringBuffer をリセット（メモリ解放不要）
- `next` が改行以外を返すとき:
  - `emit_char(line(r), c)` で現在行のテキストを蓄積
  - StringBuffer が自動で grow を管理
- `current_line`: `line(r)` の内容を sb に emit

### メモリ

| 項目 | 現在 | 変更後 |
|------|------|--------|
| ソースバッファ | 124B → grow → 最大 64KB | 4KB 固定 (読み込みバッファ) |
| 行バッファ | なし | StringBuffer (124B 初期、最長行分まで grow) |
| read_tmp | 4KB | 不要（buf が兼ねる） |
| tok_buf | 4KB | そのまま（トークン用バッファ） |

予想削減: 65536 + 32768 + 16384 + 8192 バケットの大部分 → 4096 バケット1つ。

## emit_stmt_comment の変更

### 現在の方式

```
emit_stmt_comment(sb, src, line):
    ソース全体を先頭から走査して line 行目を見つける
    その行テキストを sb に emit
```

### 変更後の方式

lex_tok でトークンを読むたびに、トークンの行番号を記録している（g_tok_line）。
文の先頭で lex_tok が呼ばれたとき、SourceReader の current_line で
その行のテキストを別バッファにキャプチャしておく。

```
// 文の解析開始時:
var stmt_line: i32 = g_tok_line;
var comment_sb: StringBuffer = StringBuffer_new();
current_line(reader, comment_sb);

// AST 出力時:
emit_stmt_comment_from_buf(sb, comment_sb);
destroy(comment_sb);
```

問題: 現在のコードでは `emit_stmt_comment` を AST 出力の途中で呼ぶ。
つまりソース読み込みと AST 出力が交互に行われる。
SourceReader の current_line は「今読んでいる行」なので、
文の先頭トークンを読んだ時点でキャプチャする必要がある。

### 具体的な変更パターン

現在:
```tinyc
fn pars_var_decl(src: StringBuffer, tok: U8Array, sb: StringBuffer, ...) {
    var stmt_line: i32 = g_tok_line;
    ...パース...
    emit_stmt_comment_line(sb, indent, src, stmt_line);  // src全体を参照
}
```

変更後:
```tinyc
fn pars_var_decl(reader: SourceReader, tok: U8Array, sb: StringBuffer, ...) {
    var stmt_line: i32 = g_tok_line;
    var comment_text: StringBuffer = capture_current_line(reader);
    ...パース...
    emit_comment_from(sb, indent, comment_text);  // キャプチャ済みテキストを使用
    destroy(comment_text);
}
```

### 注意点

- `emit_stmt_comment_line` は struct の合成関数（getter/setter/ctor/delete）
  でも使われている。struct パース時は全フィールドを読み終わった後に
  合成関数を出力するので、struct 宣言の行テキストを保持しておく必要がある。
  現在も `struct_line` 変数で行番号を保存しているので、
  同じタイミングでテキストもキャプチャすればよい。

- 複数行にまたがる式（改行を含む引数リストなど）では、
  コメントは最初の行のみ出力される。これは現在と同じ動作。

- `tok_buf` (4096B) は SourceReader とは独立。
  トークン文字列用のバッファなので変更不要。
  ただし 4096B は大きすぎるので、将来的には縮小可能
  （最長の識別子/文字列リテラル分あれば十分）。

## 実装順

1. `SourceReader` 構造体と `peek`/`next`/`at_eof`/`line_num`/`current_line` を
   `compiler/source_reader.tc` に定義
2. parse.tc の lexer (`src_char`, `skip_ws`, `lex_tok`) を
   SourceReader ベースに変更
3. `emit_stmt_comment` を current_line キャプチャ方式に変更
4. main から StringBuffer ソースバッファと read_tmp を削除
5. golden ファイル更新・テスト

## 影響範囲

- `compiler/parse.tc` — lexer + emit_stmt_comment + main
- `compiler/source_reader.tc` — 新規ファイル
- C版 `bootstrap/parser.c` — 変更不要（C版は独自の読み込み方式）
- テスト — golden 更新のみ（AST 出力は同一になるはず）
