- [x] getCharはgetという名前で。
- [x] newU8ArrayやnewPointなどnewがついてるけど、U8ArrayやPointで。(型名としてのU8Arrayと関数としてのU8Arrayは別)
- [x] ソースファイルの一覧を中身の説明付きでして。
- [x] OS本体を作る前にディレクトリを分けたい。
- [x] +=やその他の-=, *=などの演算子
- [x] .bcファイルの1行目は、".bc"ではじめて欲しい。
- [x] .bcファイルの仕様をドキュメントに書いて。
- [x] .astのstrはダブルクオートして欲しい。
      `(str "Hello, world\n")`
- [x] .astにはコメントブロックとしてソースを入れて欲しい。
      ```
      (comment "a = 3;")
      (assign a (int 3))
      ```
- [x] .bcにも、元のソースをコメントとして入れて欲しい。
      ```
      ; a = 3;
      push_int 3
      store a
      ```
- [x] Golden testsの対象に、parser.tcなどのコンパイラのコードを入れる。
- [x] Gen2とGen3の一致検証（真の自己ホスト確認）をテストに追加する。
      - Gen1(C)でtc/を → Gen2 BC
      - Gen2でtc/を → Gen3 BC
      - Gen2 BC == Gen3 BC を確認
- [x] 各テストや、テストグループごとの実行時間を結果に表示する。
- [x] 今の compiler ディレクトリを、bootstrapとかの名前にし、tcディレクトリのコンパイラ関連コードをcompilerディレクトリにする。
- [x] 引数の型や数が違う同名の関数(オーバーロード)をサポートしないといけない。
      - [x] .bcのcallは今は`call to_buf 1`という形式だが、`call to_buf String`という形式にする必要がある。
      - [x] 関数は引数の型をつけた名前にマングルする必要がある。`to_buf`->`to_buf__String`
- [x] ./tests/run_compiler_tests.sh が非常に遅い。このテストは、bcrunを使っていて遅い。これをbc2asmを使ってネイティブコードに変換して実行する事で高速化したい。
- [x] docs/language.md の配列のコンストラクタが間違ってる newXxxArray→XxxArray
- [x] struct のランタイムサポートを追加する（struct を U32Array の別名として扱う方式で実装）。
      - parser が struct 宣言から合成関数 AST を生成（C 側・self-hosted 側両方）
      - 参照型の as キャストを no-op として扱うよう codegen を修正
      - interp の find_fn で ref 型の型チェックを緩和
      - bcrun / bc2asm / runtime.c への変更は不要
      - tests/import/main_struct.tc と tests/struct_basic.tc が動作
      - 詳細は docs/task/struct_runtime.md
- [x] ob.tc に、OutputBuffer構造体を定義し、バッファと位置を持つ。ob変数の変わりに使う。
      - ob_new/ob_delete/ob_peek のラッパー関数も追加（import 先で struct 自動
        生成関数が使えないため）。
- [x] parse.tcで、ob_set_posで巻き戻さず、別なobを定義しそこに出し、確定したらメインの物に移動させる方針で書き直し、ob_set_posを削除したい。
- [x] string_buffer.tc の sb_ プリフィックスを除去する。
      - リネーム案: sb_delete→destroy, sb_append→append, sb_len→length,
        sb_get→char_at, sb_write→write, sb_new→StringBuffer_new,
        sb_new_output→StringBuffer_new
- [x] 組み込み関数（get/set/len/delete/append/equals）をオーバーロード対応にする。
      - 詳細: docs/task/builtin_overload.md
      - is_builtin を廃止、全 call をマングル名で統一
- [x] heap_mark/heap_resetを廃止し、倍々サイズのプールアロケータを導入する。
      - 事前調査: docs/task/pool_allocator.md
      - 実装: bootstrap/runtime_syscall.c の bump allocator を置き換え
- [x] parse.tcのexpect_tokで、errorbufを使ってるのが汚ない。print_errorみたいな関数を定義してくくり出して。
- [x] parse.tcのsb_op関数は、emit_op(sb, op)の方がいいかな。
- [x] parse.tcのtype_tok_name用に、set(buf, bstart, "void")みたいな事ができる関数を定義しよう。
- [x] parse.tcで、emit_typeなどの、emit_ではじまる関数は、StringBuffer(出力先)を最初の引数にしよう。
- [x] parse.tcのpars_struct_declは、field infoを構造体にして、それの配列を持つ事にしよう。
- [x] gen2でgen3コンパイラをコンパイルした時にどれぐらいの時間とメモリを使ったか知りたい。時間はすでにあるから、ピークメモリも表示して。
- [ ] スクリプトが増えすぎて把握できなくなった。それぞれの意味、どれがどれを呼ぶか、などをドキュメントにまとめて。
- [ ] 実装が多すぎる。2つを残して消していいかな。
- [ ] update_golden.sh が遅すぎる。rv32版のコンパイラを使ったら早くならないかな？
