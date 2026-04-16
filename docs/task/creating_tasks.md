# ゲストタスク (ユーザープログラム) の作成方法

このドキュメントでは OS 上で動くゲストタスクを新規に作成する手順を説明する。

---

## 概要

ゲストタスクは kernel から独立した raw バイナリとしてコンパイルされ、
mtfs (MyTinyFS) ディスクイメージに `/bin/<name>` として格納される。
カーネルの `loader.tc` が VFS 経由で読み込み、`make_task` でスケジューラに
登録する。タスクは ecall で syscall を発行し、カーネルがタイマ割り込みで
プリエンプティブにスケジューリングする。

## ディレクトリ構成

```
kernel/tasks/<name>/
    <name>.tc     # タスクのメインソース
```

例: `/bin/echo` を作る場合 → `kernel/tasks/echo/echo.tc`

## 最小限のタスク

```tc
// minimal.tc — 何もしないタスク

fn main() -> i32 {
    return 0;
}
```

`fn main() -> i32` がエントリポイント。戻り値は `sys_exit` のコードになる。

### コマンドライン引数を受け取る

```tc
fn main(argv: StringArray) -> i32 {
    // argv[0] = プログラム名 (sh が設定), argv[1..] = 引数
    var n: i32 = len(argv);
    return n;
}
```

`fn main(argv: StringArray) -> i32` に切り替えるだけでよい。
`task_crt0.s` が両方のシグネチャを fallback スタブで受け付ける。

## syscall

タスクは `task_crt0.s` のスタブ経由で ecall を発行する。
使いたい syscall は本体なし関数宣言で参照する:

```tc
// 本体なし宣言 — crt0 のアセンブリスタブにリンクされる
fn do_write(fd: i32, buf_addr: u32, count: i32) -> i32;
fn do_read(fd: i32, buf_addr: u32, count: i32) -> i32;
fn do_openat(dirfd: i32, path_addr: u32, flags: i32) -> i32;
fn do_close(fd: i32) -> i32;
fn do_exit(code: i32) -> void;
fn do_exec(path: u32, argv: u32, in_path: u32, out_path: u32) -> i32;
fn do_spawn(path: u32, argv: u32, in_path: u32, out_path: u32) -> i32;
fn do_wait(slot: i32) -> u32;
```

### syscall 一覧

| 関数 | ecall a7 | 説明 |
|---|---|---|
| `do_write(fd, buf_addr, count)` | 64 | fd にバイト列を書き込む。fd=1 で stdout |
| `do_read(fd, buf_addr, count)` | 63 | fd からバイト列を読む。fd=0 で stdin |
| `do_openat(dirfd, path_addr, flags)` | 56 | ファイルを開く。`path_addr` は NUL 終端パス文字列の先頭アドレス |
| `do_close(fd)` | 57 | fd を閉じる |
| `do_exit(code)` | 93 | タスク終了 (main の return で自動呼び出し) |
| `do_spawn(path, argv, in_path, out_path)` | 220 | 子タスクを spawn。戻り値はスロット番号 |
| `do_exec(path, argv, in_path, out_path)` | 221 | 現在のタスクを別バイナリに置き換える |
| `do_wait(slot)` | 260 | 子タスクの終了を待つ。戻り値は終了コード |

**注意**: `buf_addr` / `path_addr` は U8Array のデータ先頭アドレス。
TinyC では `buf as u32 + 4u32` でヘッダ (4 バイトの長さフィールド) を
スキップして実データアドレスを得る。

### sys_write / sys_read のショートカット

`sys_write` / `sys_read` は組み込み関数として直接呼べる:

```tc
sys_write(1, buf, count);     // stdout に書く
sys_read(0, buf, count);      // stdin から読む
```

これらは buf を `U8Array` として受け取り、内部で data ポインタに変換する。
do_write/do_read と違い `as u32 + 4u32` のキャストは不要。

### ファイル操作の例

```tc
fn do_openat(dirfd: i32, path_addr: u32, flags: i32) -> i32;
fn do_close(fd: i32) -> i32;

var O_WRONLY: i32 = 1;
var O_CREAT:  i32 = 64;
var O_TRUNC:  i32 = 512;

fn main() -> i32 {
    var path: U8Array = str_nul("/tmp/test");
    var fd: i32 = do_openat(0, path as u32 + 4u32, O_WRONLY | O_CREAT | O_TRUNC);
    if fd < 0 { delete(path); return 1; }
    var data: U8Array = str_nul("hello\n");
    sys_write(fd, data, len(data) - 1);  // -1 で NUL を除外
    do_close(fd);
    delete(data);
    delete(path);
    return 0;
}
```

**パスの制約**:
- `/bin/*` — mtfs (読み取り専用)
- `/tmp/*` — tmpfs (読み書き可、最大 16 ファイル)
- `/hello.txt` 等 — mtfs ルート

## libtc (ユーザー空間ライブラリ)

`kernel/tasks/libtc/libtc.tc` をインポートすると便利関数が使える:

```tc
import "../libtc/libtc.tc";

fn main() -> i32 {
    puts("Hello from task\n");      // stdout に文字列リテラルを出力
    var s: U8Array = str_nul("/tmp/x");  // StringLiteral → NUL終端 U8Array
    var n: i32 = strlen(s);         // NUL終端バイト列の長さ
    delete(s);
    return 0;
}
```

| 関数 | 説明 |
|---|---|
| `puts(s: StringLiteral)` | 文字列リテラルを stdout (fd 1) に書き出す |
| `str_nul(s: StringLiteral) -> U8Array` | 末尾に NUL を付けた U8Array を返す。`delete()` が必要 |
| `strlen(buf: U8Array) -> i32` | U8Array 内の NUL までのバイト数を返す |

## ビルドへの組み込み

### 1. タスクリストに追加

`kernel/build.sh` の `TASKS` 変数にタスク名を追加:

```bash
TASKS="hello hello2 catfile sh tmpdemo echo launcher cat <name>"
```

Makefile の `GUEST_TASKS` にも同じ名前を追加:

```makefile
GUEST_TASKS := hello hello2 catfile sh tmpdemo echo launcher cat <name>
```

### 2. arena / stack サイズを設定

`kernel/tasks/<name>/task.mk` に arena / stack サイズを宣言:

```makefile
GUEST_TASKS += <name>
TASK_ARENA_<name> := 16384    # 16 KB (目安: ピーク + 25%)
TASK_STACK_<name> := 8192     # 8 KB (大半のタスクはこれで十分)
```

Makefile が `kernel/tasks/*/task.mk` を自動 include し、
`build/kernel/task_sizes.sh` を生成して kernel/build.sh に渡す。
kernel/build.sh や Makefile 本体を編集する必要はない。

compiler タスク (phase 7 用) は `EXTRA_GUEST_TASKS +=` を使う。
EXTRA_TASKS 環境変数で kernel/build.sh に渡したときだけビルドされる。
```

**サイズの目安**:
- arena: kmalloc のプール。`[kmem peak=N live=M]` の stderr 出力で実測
- stack: 関数呼び出しの深さ次第。再帰がなければ 8 KB で十分。
  深い再帰 (AST 走査等) には 16 KB

### 3. ビルド＆テスト

```bash
# kernel + disk.img を再ビルド (タスクが /bin/<name> として入る)
make virt-kernel

# qemu で起動して sh から実行
qemu-system-riscv32 -smp 1 -nographic -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -drive "file=build/kernel/disk.img,format=raw,if=none,id=blk0" \
    -device "virtio-blk-device,drive=blk0" \
    -device "loader,file=build/kernel/virt_kernel.bin,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0"

# sh プロンプトが出たらタスク名を入力
> <name>
> quit
```

## コンパイルの仕組み

タスクのバイナリは以下の流れで生成される:

```
<name>.tc
  → compile-gen2.sh (Gen2 パイプライン)
    → parse → sigscan → tcheck → codegen → bc2asm → .s
  → task_crt0.s + runtime.s + <name>.s + task_data.s
    → asm_pass1 → asm_pass2
  → raw binary (先頭 8B = arena_size + stack_size ヘッダ)
```

`task_crt0.s` が提供するもの:
- `_start`: .data コピー + runtime 初期化 + `main()` 呼び出し
- `main` / `main__StringArray` の fallback スタブ
- syscall スタブ (`do_write`, `do_read`, `do_openat`, `do_close`, `do_exit`,
  `do_exec`, `do_spawn`, `do_wait`)
- peek/poke 組み込み

`runtime.tc` が提供するもの:
- `kmalloc` / `kfree` (メモリアロケータ)
- 配列操作 (U8Array, U32Array, StringArray 等)
- `sys_write` / `sys_read` (組み込み関数)
- `km_dump_peak` (タスク終了時の peak メモリ表示)

## seed task (カーネル起動時に自動起動)

カーネルの `kernel.tc` (virt) / `kernel_pico2.tc` で `load_task()` に
パスを渡すと起動時に自動実行される:

```tc
// kernel.tc の例
load_task("/bin/hello");   // slot 0
load_task("/bin/hello2");  // slot 1
load_task("/bin/sh");      // slot 2
```

sh から `spawn` → `wait` で動的にタスクを起動する場合は seed 登録不要。

## 実例

| タスク | ファイル | 説明 |
|---|---|---|
| hello | `kernel/tasks/hello/hello.tc` | "A" を出力するだけ |
| echo | `kernel/tasks/echo/echo.tc` | argv を stdout に出力 |
| catfile | `kernel/tasks/catfile/catfile.tc` | ファイルの内容を表示 |
| tmpdemo | `kernel/tasks/tmpdemo/tmpdemo.tc` | tmpfs の書き込み→読み戻しテスト |
| sh | `kernel/tasks/sh/sh.tc` | 最小シェル (spawn + wait + redirect) |
| cat | `kernel/tasks/cat/cat.tc` | 複数ファイルを連結出力 |
