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

## 修正方針: 組み込み関数もマングル名で統一

### 核心のアイデア

bc2asm の `is_builtin()` を廃止する。代わりに、**全ての call を
マングル名で出力**し、runtime_syscall.c 側でマングル名のシンボルを
export する。リンカが自然に解決する。

```
従来:
  call get U8Array i32  → is_builtin("get") → call __tc_get

新:
  call get U8Array i32  → call get__U8Array__i32
  (リンカが runtime_syscall.c の get__U8Array__i32 に解決)

  call len StringBuffer → call len__StringBuffer
  (リンカがユーザーコードの len__StringBuffer に解決)
```

### 影響箇所と変更内容

#### 1. bootstrap/runtime_syscall.c — マングル名シンボルの export

現在の `__tc_get`, `__tc_len` 等を、マングル名で export する。
内部実装は共有:

```c
static int32_t get_impl(HeapObj *o, int32_t idx) { /* 現在の __tc_get */ }

int32_t __tc_get__U8Array__i32 (HeapObj *o, int32_t idx) { return get_impl(o, idx); }
int32_t __tc_get__U16Array__i32(HeapObj *o, int32_t idx) { return get_impl(o, idx); }
int32_t __tc_get__U32Array__i32(HeapObj *o, int32_t idx) { return get_impl(o, idx); }
int32_t __tc_get__String__i32  (HeapObj *o, int32_t idx) { return get_impl(o, idx); }
// ... 他の型も同様
```

同様に `len`, `set`, `delete`, `append`, `equals` もマングル名で export。

peek/poke/sys_*/print_* は引数型が固定なのでマングル名 1 つずつ:
```c
uint32_t __tc_peek8__u32(uint32_t addr) { ... }
void __tc_print_i32__i32(int32_t v) { ... }
// etc.
```

XxxArray コンストラクタも同様:
```c
HeapObj *__tc_U8Array__i32(int32_t sz) { return new_array(sz); }
```

#### 2. bootstrap/bc2asm.c — is_builtin 廃止

`is_builtin()` と `base_name()` を削除。call 命令の出力を統一:

```c
case OP_CALL: {
    // 全ての call を __tc_ + マングル名 で出力
    // ユーザー関数はマングル名そのまま
    // → リンカが解決
    E("    call %s\n", ins->sarg);  // マングル名をそのまま使用
    break;
}
```

ただし `__tc_` prefix の扱い:
- 組み込みシンボルは `__tc_` prefix 付きで runtime に存在
- ユーザー関数は prefix なし
- → bc2asm は全てに `__tc_` を付けず、runtime 側も prefix なしにする？
- → または: codegen が組み込み関数の call に `__tc_` prefix を付ける？

**最もシンプルな案**: `__tc_` prefix を廃止し、runtime のシンボルを
マングル名そのまま（`get__U8Array__i32`, `len__String` 等）にする。
ユーザー関数とリンカレベルで同居する。bc2asm は一律
`call MANGLED_NAME` を出力するだけ。

#### 3. compiler/bc2asm.tc — 同上

is_builtin() を削除。全 call をマングル名で出力。

#### 4. bootstrap/bcrun.c — ディスパッチ順変更

```c
static Value vm_dispatch(VM *vm, const char *name, Value *args, int nargs) {
    // まずユーザー関数をマングル名で検索
    for (int i = 0; i < vm->prog->nfuncs; i++) {
        if (strcmp(vm->prog->funcs[i].name, name) == 0)
            return vm_exec(vm, &vm->prog->funcs[i], args, nargs);
    }
    // ユーザー関数が見つからなければ組み込みにフォールバック
    return call_builtin(name, args, nargs);
}
```

`call_builtin()` はマングル名を受け取り、ベース名で分岐:
```c
static Value call_builtin(const char *mangled, Value *args, int nargs) {
    char name[128]; base_name(mangled, name, sizeof(name));
    if (!strcmp(name, "get") && nargs == 2) { ... }
    // ...
}
```

`is_builtin()` は不要（ユーザー関数検索で見つからなければ自動的に
call_builtin に到達するため）。

#### 5. bootstrap/interp.c — 同様

```c
static Value dispatch_call(Interp *ip, const char *name,
                           Value *args, int nargs) {
    AstNode *fn = find_fn(ip, name, args, nargs);
    if (fn) return call_fn(ip, fn, args, nargs);
    return call_builtin(ip, name, args, nargs);
}
```

#### 6. typecheck — 変更不要

既に型ベースで正しくオーバーロード解決している。

### sys_exit のインライン化

現在 bc2asm は `sys_exit` を `ecall` にインライン展開している。
is_builtin 廃止後もこの特殊処理は維持:

```c
case OP_CALL:
    if (is_sys_exit(ins->sarg)) {
        E("    li   a7, 93\n");
        E("    ecall\n");
    } else {
        E("    call %s\n", ins->sarg);
    }
```

### テスト

- tests/struct_overload.tc:
  - `fn len(mb: MyBuf) -> i32` がユーザー関数にディスパッチされること
  - `fn get(mb: MyBuf, idx: i32) -> u8` が同上
  - builtin の `len(U8Array)`, `get(U8Array, i32)` は従来通り動くこと
  - bcrun / rv32 / interp 全てで一致すること

## 未対応事項

- `delete` の struct 自動生成版との衝突は別問題
  （自動生成 delete は buf を free しないため、カスタム delete が必要）
  → struct 宣言時に自動生成 delete を登録しないオプション、または
    `destroy` 等の別名を使う
