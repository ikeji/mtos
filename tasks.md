- [x] getCharはgetという名前で。
- [x] newU8ArrayやnewPointなどnewがついてるけど、U8ArrayやPointで。(型名としてのU8Arrayと関数としてのU8Arrayは別)
- [ ] ソースファイルの一覧を中身の説明付きでして。
- [ ] OS本体を作る前にディレクトリを分けたい。
- [ ] +=やその他の-=, *=などの演算子
- [ ] .bcファイルの1行目は、".bc"ではじめて欲しい。
- [ ] .bcファイルの仕様をドキュメントに書いて。
- [ ] .astのstrはダブルクオートして欲しい。
      `(str "Hello, world\n")`
- [ ] .astにはコメントブロックとしてソースを入れて欲しい。
      ```
      (comment "a = 3;")
      (assign a (int 3))
      ```
- [ ] .bcにも、元のソースをコメントとして入れて欲しい。
      ```
      ; a = 3;
      push_int 3
      store a
      ```
