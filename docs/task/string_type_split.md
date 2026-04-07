# String 型の分離: StrLit (rodata) と String (heap)

## 動機

現在、文字列リテラル `"hello"` もヒープ上の動的文字列も同じ `String` 型で
HeapObj を経由して扱われている。しかし:

- 文字列リテラルは .rodata 上の静的 HeapObj で、`is_literal=1` フラグで
  delete を抑制している
- 動的文字列（`append` で構築）はヒープ HeapObj で、delete 可能
- `is_literal` フラグのためだけに HeapObj に 4 バイトのフィールドがある
- 型を分ければ `is_literal` フィールドが不要になり、HeapObj が 16B → 12B に
- コンパイル時に静的 vs 動的が判別でき、不正な delete をコンパイルエラーにできる

## 設計

### 新しい型

| 型名 | 表現 | 生成元 | delete |
|------|------|--------|--------|
| `StrLit` | .rodata 上の HeapObj（kind + count + data） | `push_str` （文字列リテラル） | 不可（コンパイルエラー） |
| `String` | ヒープ HeapObj（kind + count + data） | `append` で構築 | 可 |

両方とも同じ HeapObj レイアウトを共有（`is_literal` フィールド削除）:
```c
typedef struct {
    int   kind;   // OBJ_ARRAY=0, OBJ_STRING=1
    int   count;
    void *data;
} HeapObj;  // 12 bytes
```

### 型の互換性

- `StrLit` は `String` を受け取る関数に暗黙変換可能（read-only アクセスのみ）
- `String` は `StrLit` に変換不可
- `get(StrLit, i32) -> u8` と `get(String, i32) -> u8` を両方登録
- `len(StrLit) -> i32` と `len(String) -> i32` を両方登録
- `append(StrLit, u8) -> String`, `append(StrLit, StrLit) -> String` 等
- `equals(StrLit, StrLit) -> bool` 等の全組み合わせ
- `print_str(StrLit)` と `print_str(String)` を両方登録
- `delete(String)` のみ登録、`delete(StrLit)` は未登録（コンパイルエラー）

### 変更箇所

#### 1. typecheck（C 版 + 自己ホスト版）

- `StrLit` 型を組み込み型として登録
- `push_str` の結果型を `String` → `StrLit` に変更
- `StrLit` 引数を `String` パラメータに渡す際の暗黙変換ルールを追加
  - オーバーロード解決で `StrLit` を `String` として扱う
  - または `StrLit` 用のオーバーロードを全て登録
- 組み込み関数を StrLit 対応で登録:
  - `len(StrLit) -> i32`
  - `get(StrLit, i32) -> u8`
  - `append(StrLit, u8) -> String`
  - `append(StrLit, String) -> String`
  - `append(StrLit, StrLit) -> String`
  - `append(String, StrLit) -> String`
  - `equals(StrLit, StrLit) -> bool`
  - `equals(StrLit, String) -> bool`
  - `equals(String, StrLit) -> bool`
  - `print_str(StrLit) -> void`

#### 2. codegen（C 版 + 自己ホスト版）

- `push_str` の型アノテーションを `String` → `StrLit` に変更
  （BC に `push_str N` の型情報が付く場合）

#### 3. bc2asm（C 版 + 自己ホスト版）

- .rodata 上の HeapObj を 3 word に変更（is_literal 削除）:
  ```asm
  __tc_strobj0:
      .word 1            ; kind = OBJ_STRING
      .word 5            ; count
      .word __tc_strdata0 ; data
  ```

#### 4. runtime_syscall.c

- HeapObj から `is_literal` フィールドを削除（12 バイトに）
- `delete_impl`: `is_literal` チェック不要に。`StrLit` の delete は
  コンパイル時に弾かれるため、ランタイムに到達しない
- `StrLit` 版の組み込み関数を追加（マングル名）:
  - `len__StrLit`, `get__StrLit__i32`
  - `append__StrLit__u8`, `append__StrLit__String` 等
  - `equals__StrLit__StrLit` 等
  - `print_str__StrLit`
  - 内部実装は String 版と共通

#### 5. bcrun / interp

- `push_str` の値に StrLit タグを付ける（またはしない — bcrun/interp は
  StrLit と String を区別せず同じ HeapObj で扱っても問題ない。delete は
  bcrun では元々 no-op）

#### 6. parser（C 版 + 自己ホスト版）

- `.tc` ソース中の `String` 型注釈はそのまま（ユーザーが `StrLit` を
  明示する必要はない — リテラルは自動的に `StrLit` 型になる）
- `fn foo(s: String)` は `StrLit` 引数も受け入れる

### 段階的実装

1. **Phase 1**: runtime_syscall.c で `is_literal` を削除、HeapObj を 12B に。
   `delete_impl` は無条件 free。bc2asm の .rodata HeapObj を 3 word に。
   - StrLit の delete 防止はまだコンパイル時チェックなし
   - delete(StrLit) がランタイムに到達すると .rodata を free → bad free
   - → pool_free_blk でアドレス範囲チェック済みなので安全に無視できる
     （pool 外のポインタは何もしない設計に変更）

2. **Phase 2**: typecheck で `StrLit` 型を導入。`push_str` を `StrLit` に。
   暗黙変換ルールを追加。`delete(StrLit)` をコンパイルエラーに。

3. **Phase 3**: runtime にマングル名エイリアス追加（`len__StrLit` 等）。

### メモリ改善

HeapObj: 16B → **12B**。全 HeapObj（配列含む）が恩恵を受ける。
ただし 12B は 16B pool バケットに入るため、pool 単位では変化なし
（16B バケットのまま）。実際の改善は `.rodata` の静的 HeapObj が
4 バイト小さくなること。
