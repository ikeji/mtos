# 組み込み関数のオーバーロード対応

## 課題

`get`, `set`, `len`, `delete`, `append`, `equals` は組み込み関数として
ハードコードされており、ユーザー定義の struct 型に対して同名関数を
定義しても、実行時に組み込み版が呼ばれてしまう。

例: `fn len(sb: StringBuffer) -> i32` を定義しても、
`len(sb)` は組み込みの `len(U32Array)` にディスパッチされる。

## 原因

bc2asm と bcrun の `is_builtin()` がマングル名からベース名だけを
取り出し、ハードコードリストと照合している。型情報を見ていない。

```
マングル名 "len__StringBuffer"
  → ベース名 "len"
  → is_builtin("len") == true
  → call __tc_len    ← 組み込みに直行、ユーザー関数は無視
```

## 影響箇所

| ファイル | 関数 | 行 | 内容 |
|----------|------|----|------|
| bootstrap/bc2asm.c | is_builtin() | ~258 | ベース名でハードコード照合 |
| bootstrap/bc2asm.c | emit_fn() | ~415 | is_builtin → `call __tc_X` |
| compiler/bc2asm.tc | is_builtin() | ~642 | 同上（自己ホスト版） |
| compiler/bc2asm.tc | emit_fn() | ~890 | 同上 |
| bootstrap/bcrun.c | is_builtin() | ~530 | ベース名でハードコード照合 |
| bootstrap/bcrun.c | vm_dispatch() | ~664 | is_builtin → call_builtin 優先 |
| bootstrap/interp.c | is_builtin() | ~425 | ベース名でハードコード照合 |
| bootstrap/interp.c | dispatch_call() | ~462 | is_builtin → call_builtin 優先 |
| bootstrap/typecheck.c | — | — | ✅ 変更不要（型ベースで正しく解決） |
| compiler/typecheck.tc | — | — | ✅ 変更不要 |

## 修正方針

### 方針: is_builtin をマングル名全体で判定する

現在の `is_builtin()` はベース名だけを見てるが、**マングル名の引数型**
も見て、組み込み型（U8Array, U32Array, String 等）の場合だけ true を
返すようにする。

組み込み型リスト（is_builtin で true にする型）:
- 配列型: `U8Array`, `U16Array`, `U32Array`, `I8Array`, `I16Array`,
  `I32Array`, `StringArray` + ユーザー定義の `XxxArray`
- 文字列型: `String`
- プリミティブ型: `i32`, `u32`, `u8` 等（peek/poke/print 用）

ユーザー定義 struct 型（`StringBuffer`, `OutputBuffer`, `MyBuf` 等）
が引数に含まれる場合は `is_builtin() == false` → ユーザー関数を呼ぶ。

### 具体的な変更

#### 1. bc2asm.c — `is_builtin()` 改修

```c
static int is_builtin(const char *mangled) {
    char name[128];
    base_name(mangled, name, sizeof(name));

    // peek/poke/sys_*/print_*/heap_* は常に組み込み
    if (is_always_builtin(name)) return 1;

    // XxxArray コンストラクタは常に組み込み
    if (is_array_ctor(name)) return 1;

    // len/get/set/delete/append/equals は引数型を見て判定
    if (is_overloadable_builtin(name)) {
        // マングル名から第一引数の型を取得
        // 組み込み型なら true、ユーザー struct なら false
        return has_builtin_arg_types(mangled);
    }

    return 0;
}
```

`has_builtin_arg_types()`: マングル名の `__` 以降を見て、
第一引数型が `U8Array`, `U32Array`, `String` 等なら true。
`StringBuffer` や `MyBuf` など未知の型なら false。

#### 2. bcrun.c — `vm_dispatch()` のディスパッチ順変更

```c
static Value vm_dispatch(VM *vm, const char *name, Value *args, int nargs) {
    // まずユーザー関数を完全名で検索
    for (int i = 0; i < vm->prog->nfuncs; i++) {
        if (strcmp(vm->prog->funcs[i].name, name) == 0)
            return vm_exec(vm, &vm->prog->funcs[i], args, nargs);
    }
    // ユーザー関数が見つからなければ組み込みにフォールバック
    if (is_builtin(name)) return call_builtin(name, args, nargs);
    return val_void();
}
```

#### 3. interp.c — `dispatch_call()` の修正

```c
static Value dispatch_call(Interp *ip, const char *name,
                           Value *args, int nargs) {
    // まずユーザー関数を検索
    AstNode *fn = find_fn(ip, name, args, nargs);
    if (fn) return call_fn(ip, fn, args, nargs);
    // なければ組み込み
    if (is_builtin(name)) return call_builtin(ip, name, args, nargs);
    fprintf(stderr, "unknown function: %s\n", name);
    exit(1);
}
```

#### 4. bc2asm.tc — 自己ホスト版の同等修正

bc2asm.c と同じロジックを文字操作で実装。

### テスト

- tests/struct_overload.tc を拡張:
  - `fn len(mb: MyBuf) -> i32` が正しくユーザー関数にディスパッチされること
  - `fn get(mb: MyBuf, idx: i32) -> u8` が同上
  - builtin の `len(U8Array)`, `get(U8Array, i32)` は従来通り動くこと
  - bcrun / rv32 / interp 全てで一致すること

## 未対応事項

- `delete` の struct 自動生成版との衝突は別問題
  （自動生成 delete は buf を free しないため、カスタム delete が必要）
  → struct 宣言時に自動生成 delete を登録しないオプション、または
    `destroy` 等の別名を使う
