# String 型の分離: StringLiteral (rodata) と String (heap)

## 動機

現在、文字列リテラル `"hello"` もヒープ上の動的文字列も同じ `String` 型で
HeapObj を経由して扱われている。しかし:

- 文字列リテラルは .rodata 上の静的 HeapObj で、`is_literal=1` フラグで
  delete を抑制している
- 動的文字列（`append` で構築）はヒープ HeapObj で、delete 可能
- `is_literal` フラグのためだけに HeapObj に 4 バイトのフィールドがある
- 型を分ければ `is_literal` フィールドが不要になり、HeapObj が 16B → 12B に

## 設計

### 新しい型

| 型名 | 表現 | 生成元 | delete |
|------|------|--------|--------|
| `StringLiteral` | .rodata 上の HeapObj | `push_str`（文字列リテラル） | no-op（安全に呼べる） |
| `String` | ヒープ上の HeapObj | `append` で構築 | ヒープを free |

両方とも同じ HeapObj レイアウト（`is_literal` フィールド削除）:
```c
typedef struct {
    int   kind;   // OBJ_ARRAY=0, OBJ_STRING=1
    int   count;
    void *data;
} HeapObj;  // 12 bytes
```

### 型の関係

- **暗黙変換なし** — `StringLiteral` と `String` は別々の型
- 操作はそれぞれの型ごとにオーバーロードを用意
- ユーザーが `fn foo(s: StringLiteral)` や `fn foo(s: String)` と
  明示的に書き分ける

### 組み込み関数の登録（全オーバーロード一覧）

#### len
- `len(StringLiteral) -> i32`
- `len(String) -> i32`

#### get
- `get(StringLiteral, i32) -> u8`
- `get(String, i32) -> u8`

#### delete
- `delete(StringLiteral) -> void` — **no-op**（.rodata は free しない）
- `delete(String) -> void` — ヒープを free

#### append（全 2×2 組み合わせ + char 版）
- `append(StringLiteral, u8) -> String`
- `append(StringLiteral, StringLiteral) -> String`
- `append(StringLiteral, String) -> String`
- `append(String, u8) -> String`
- `append(String, StringLiteral) -> String`
- `append(String, String) -> String`

#### equals（全 2×2 組み合わせ）
- `equals(StringLiteral, StringLiteral) -> bool`
- `equals(StringLiteral, String) -> bool`
- `equals(String, StringLiteral) -> bool`
- `equals(String, String) -> bool`

#### print
- `print_str(StringLiteral) -> void`
- `print_str(String) -> void`

### 変更箇所

#### 1. typecheck（C 版 + 自己ホスト版）

- `StringLiteral` 型を組み込み型として認識
- `push_str` の結果型を `String` → `StringLiteral` に変更
- 上記の全オーバーロードを登録
- `StringArray` は変更なし（要素型は String のまま）

#### 2. codegen（C 版 + 自己ホスト版）

- `push_str` で値をスタックに積む際の型注釈を `StringLiteral` に変更

#### 3. bc2asm（C 版 + 自己ホスト版）

- .rodata 上の HeapObj を 3 word に変更（is_literal 削除）:
  ```asm
  __tc_strobj0:
      .word 1              ; kind = OBJ_STRING
      .word 5              ; count
      .word __tc_strdata0  ; data
  ```

#### 4. runtime_syscall.c

- HeapObj から `is_literal` フィールドを削除（12 バイトに）
- `delete__String` はヒープを free（現在の delete_impl）
- `delete__StringLiteral` は no-op
- StringLiteral 版の組み込み関数をマングル名で追加:
  ```c
  int32_t len__StringLiteral(HeapObj *o) { return len_impl(o); }
  int32_t get__StringLiteral__i32(HeapObj *o, int32_t i) { ... }
  HeapObj *append__StringLiteral__u8(HeapObj *s, int32_t c) { ... }
  HeapObj *append__StringLiteral__StringLiteral(HeapObj *s, HeapObj *t) { ... }
  HeapObj *append__StringLiteral__String(HeapObj *s, HeapObj *t) { ... }
  HeapObj *append__String__StringLiteral(HeapObj *s, HeapObj *t) { ... }
  int32_t equals__StringLiteral__StringLiteral(HeapObj *s, HeapObj *t) { ... }
  int32_t equals__StringLiteral__String(HeapObj *s, HeapObj *t) { ... }
  int32_t equals__String__StringLiteral(HeapObj *s, HeapObj *t) { ... }
  void print_str__StringLiteral(HeapObj *s) { ... }
  void delete__StringLiteral(HeapObj *o) { /* no-op */ }
  ```
  全て内部実装は String 版と共通（delete__StringLiteral のみ例外）。

#### 5. bcrun / interp

- `push_str` の結果型を `StringLiteral` として記録
- bcrun の `call_builtin` は base_name でディスパッチするため、
  StringLiteral のオーバーロードは自動的に処理される
- interp は型を区別しないので変更不要

#### 6. parser（C 版 + 自己ホスト版）

- パーサー自体の変更なし
- `.tc` ソースで `StringLiteral` 型を引数型として使えるようにする
  （typecheck で型として認識されれば自動的に使える）

### 既存 .tc コードへの影響

- `fn tok_cmp(tok: U8Array, tlen: i32, target: String)` のような関数は
  `target: StringLiteral` に変更が必要（リテラルを渡しているため）
- または `StringLiteral` 版のオーバーロードを追加
- `emit_string(sb: StringBuffer, s: String)` も同様

### 実装順

1. runtime_syscall.c: `is_literal` 削除、HeapObj 12B 化、
   StringLiteral 版マングル名追加
2. bc2asm.c / bc2asm.tc: .rodata HeapObj を 3 word に
3. typecheck.c / typecheck.tc: StringLiteral 型登録、push_str 型変更、
   オーバーロード登録
4. codegen.c / codegen.tc: push_str 型注釈変更
5. bcrun.c: push_str 結果型を StringLiteral に
6. compiler/*.tc: 必要に応じて引数型を StringLiteral に変更
7. golden ファイル更新

### メモリ改善

HeapObj: 16B → **12B**。pool バケットは 16B のまま（12B が収まる最小バケット）。
.rodata 上の静的 HeapObj は 4 word → 3 word (16B → 12B) に縮小。
