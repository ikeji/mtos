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
    rfd: i32,          // 入力ファイルディスクリプタ (0 = stdin)
    buf: U8Array,      // 読み込みバッファ (4092B = 4096 バケットに収まる)
    buf_pos: i32,      // buf 内の現在位置
    buf_len: i32,      // buf 内の有効バイト数
    is_eof: i32,       // EOF に達したか (0 or 1)
    line: StringBuffer, // 行テキスト蓄積用
    lnum: i32          // 現在の行番号 (1-origin)
}
```

### API

```tinyc
// コンストラクタ・デストラクタ
fn SourceReader_new(fd: i32) -> SourceReader
fn close(r: SourceReader) -> void

// 読み込み
fn peek(r: SourceReader) -> u8       // 次の1バイトを見る（消費しない）、EOF時は 0
fn next(r: SourceReader) -> u8       // 1バイト読んで進める、line に蓄積
fn at_eof(r: SourceReader) -> bool   // EOF に達したか
fn line_num(r: SourceReader) -> i32  // 現在の行番号

// 行テキスト管理
fn line_buf_reset(r: SourceReader) -> void
    // line バッファをリセット。次の next 呼び出しから蓄積を開始する。
fn line_buf(r: SourceReader, sb: StringBuffer) -> void
    // 現在行の全テキストを sb に emit:
    //   1. line_buf_reset 以降に next で消費された分（line に蓄積済み）
    //   2. buf 内の buf_pos から改行/EOF まで（peek、buf_pos は動かさない）
    // これにより行全体のテキストが得られる。
```

### 内部動作

- `peek` / `next`: buf_pos < buf_len なら buf から返す。
  buf_pos >= buf_len なら sys_read で 4KB 読み込み。
- `next` は毎回 `emit_char(line(r), c)` で行テキストを蓄積。
  改行 (0x0A) を読んだら `line_num` をインクリメント。
- `line_buf_reset`: StringBuffer の pos を 0 にリセット。
  次の `next` 呼び出しから蓄積が始まる。
- `line_buf`: 2段階で行全体を sb にコピー:
  1. line StringBuffer の内容（next で消費済み分）を sb に emit
  2. buf 内の buf_pos 以降を改行/EOF まで走査し sb に emit
     （buf_pos は動かさない — lexer に影響しない）
  必要に応じて fill を呼び、buf を補充する。
  4KB を超える行の場合、buf 境界で切れる可能性があるが実用上問題ない。

### emit_stmt_comment の変更

現在の方式（ソース全体をランダムアクセス）:
```
emit_stmt_comment(sb, src, line_number):
    ソース全体を先頭から走査して line_number 行目を見つける
    その行テキストを sb に emit
```

変更後の方式（line_buf を使う）:
```
// pars_block 内のループ:
line_buf_reset(src);              // 蓄積開始
// → この後 lex_tok が skip_ws + トークン読み取りで next を呼ぶ
// → next が line に文字を蓄積
// → lex_tok 完了時点で、空白スキップ後〜トークン末尾まで line に入っている
// → ただし行の残り（まだ読んでいない部分）は含まれない
emit_stmt_comment(sb, src);       // line_buf の内容をコメントとして出力
pars_stmt(src, tok, sb, indent);  // 文をパース
```

line_buf は消費済み分 + buf 内の未消費分を合わせて返すので、
buf に行末まで入っていれば行全体が得られる。
C版と同じ出力になるはず（4KB を超える行でなければ）。

### 変更パターン

```tinyc
// 現在:
fn emit_stmt_comment(sb: StringBuffer, src: StringBuffer, line: i32) -> void {
    // src 全体から line 行目を検索...
}
fn pars_block(src: StringBuffer, ...) {
    while g_tok != TK_RBRACE {
        var stmt_line: i32 = g_tok_line;
        emit_stmt_comment(sb, src, stmt_line);
        pars_stmt(src, ...);
    }
}

// 変更後:
fn emit_stmt_comment(sb: StringBuffer, src: SourceReader) -> void {
    // line_buf の内容をコメントとして出力
    line_buf(src, comment_sb);
}
fn pars_block(src: SourceReader, ...) {
    while g_tok != TK_RBRACE {
        line_buf_reset(src);           // ← 追加
        // この後の lex_tok/skip_ws が next を呼び、line に蓄積
        emit_stmt_comment(sb, src);    // line → "stmt_line まで" ではなく "今の line_buf"
        pars_stmt(src, ...);
    }
}
```

struct の合成関数用には、struct 宣言のパース開始時に line_buf の中身を
StringBuffer にコピーして保存しておく:
```tinyc
fn pars_struct_decl(src: SourceReader, ...) {
    var struct_cmt: StringBuffer = StringBuffer_new();
    line_buf(src, struct_cmt);  // struct 行のテキストをコピー
    ...
    // 合成関数の emit 時に struct_cmt を使う
    destroy(struct_cmt);
}
```

### メモリ

| 項目 | 現在 | 変更後 |
|------|------|--------|
| ソースバッファ | 124B → grow → 最大 64KB | 4KB 固定 (読み込みバッファ) |
| 行バッファ | なし | StringBuffer (124B 初期、最長行分まで grow) |
| read_tmp | 4KB | 不要（buf が兼ねる） |
| tok_buf | 4KB | そのまま |

予想削減: 65536 + 32768 + 16384 + 8192 バケット → 4096 バケット1つ。

## 実装順

1. `compiler/source_reader.tc` を作成
   - SourceReader struct
   - SourceReader_new, close
   - peek, next, at_eof, line_num
   - line_buf_reset, line_buf
2. テスト (`tests/source_reader_test.tc`) で API を検証
3. parse.tc の lexer を SourceReader ベースに変更
   - `src: StringBuffer` → `src: SourceReader`
   - `char_at(src, g_pos)` → `peek(src)`, `g_pos++` → `next(src)`
   - `g_pos`, `g_len` を削除
   - skip_ws_and_comments: peek で先読みして `/` を消費しない
4. emit_stmt_comment を line_buf 方式に変更
   - pars_block で line_buf_reset + line_buf
   - pars_struct_decl で line_buf コピー
5. main を変更: StringBuffer src_buf + read_tmp → SourceReader_new(0)
6. golden ファイル更新・テスト

## 注意: zsh と RISCV_FLAGS

test_common.sh の `RISCV_FLAGS` は文字列として定義されているが、
zsh では `$RISCV_FLAGS` が word split されない。
配列 `RISCV_FLAGS=(...)` + `"${RISCV_FLAGS[@]}"` に変更する必要がある。

test_common.sh の `build_gen2_tool` は shallow import のみ対応。
source_reader.tc → string_buffer.tc の再帰的 import を解決するため、
`collect_imports` を再帰的に実装する必要がある。

## 影響範囲

- `compiler/source_reader.tc` — 新規ファイル
- `compiler/string_buffer.tc` — `reset()` 関数を追加（line_buf_reset 用）
- `compiler/parse.tc` — lexer + emit_stmt_comment + main
- `tests/test_common.sh` — RISCV_FLAGS 配列化、collect_imports 再帰化
- C版 `bootstrap/parser.c` — 変更不要
- テスト — golden 更新（コメント内容が部分行になる差分あり）
