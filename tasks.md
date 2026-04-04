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
- [ ] 今の compiler ディレクトリを、bootstrapとかの名前にし、tcディレクトリのコンパイラ関連コードをcompilerディレクトリにする。
- [ ] 引数の型や数が違う同名の関数(オーバーロード)をサポートしないといけない。
      - [ ] .bcのcallは今は`call to_buf 1`という形式だが、`call to_buf String`という形式にする必要がある。
      - [ ] 関数は引数の型をつけた名前にマングルする必要がある。`to_buf`->`to_buf__String`
