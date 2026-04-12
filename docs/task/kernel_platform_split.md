# カーネル プラットフォーム共通化設計

## 現状の問題

virt と Pico 2 で以下が重複している:

| コンポーネント | virt | pico2 | 重複度 |
|---|---|---|---|
| カーネル TC | kernel.tc (プリエンプティブ) | kernel_pico2.tc (順次実行) | kputs, run_task が同一 |
| crt0 アセンブリ | crt0_virt.s (408行) | crt0_pico2.s (339行) | trap/ecall/restore ~200行が同一 |
| crt0 データ | crt0_data.s | crt0_pico2_data.s | 構造が同一 |
| タスク | tasks/hello/ (mtime 使用) | tasks/pico2_hello/ (単純出力) | 別実装 |
| ビルドスクリプト | build_virt.sh | build_pico2.sh | 構造が同一 |

## 設計方針

### 1. crt0 の分離: platform.s + common.s

crt0 を 2 ファイルに分割:

**kernel/platform_virt.s** (プラットフォーム固有、~100行):
```
_start, sp/gp 設定, SRAM ゼロクリア (pico2のみ)
.data コピー (pico2のみ)
runtime_init, trap vector 設定
call main, _park
do_uart_write (16550 / PL011)
do_uart_read  (16550 / PL011)
```

**kernel/trap_common.s** (共通、~200行):
```
_trap_entry / _trap_restore
_handle_ecall (_ecall_write, _ecall_read, _ecall_exit)
_task_exit_trampoline
kern_run_task
sched_start, init_task_frame, set_switch_frame
peek/poke builtins
CSR helpers
```

共通部分は `_kern_save`, `_switch_frame` 等の BSS ラベルと
`do_uart_write`, `do_uart_read` という関数名に依存する。
プラットフォーム固有部分がこれらを提供する。

### 2. kernel.tc の統一

kernel.tc を 1 つにして、プリエンプティブ/順次実行を
コンパイル時フラグではなくランタイム判定で切り替える:

```tc
fn main() -> i32 {
    kputs("KERN: starting\r\n");

    // 共通: タスク作成
    var frame0: u32 = make_task(_task_hello_addr());
    var frame1: u32 = make_task(_task_hello2_addr());

    // タイマが使えるかチェック (peek で CLINT アドレスを読む等)
    // または body-less 宣言で has_timer() を提供
    if has_timer() == 1 {
        // プリエンプティブ
        setup_timer();
        sched_start(frame0);
    } else {
        // 順次実行
        kern_run_task_from_frame(frame0);
        kern_run_task_from_frame(frame1);
    }
    kputs("KERN: done\r\n");
    return 0;
}
```

ただし、virt のプリエンプティブカーネルと Pico 2 の順次カーネルでは
タスクの作り方 (RAM サイズ、スタックサイズ) も異なるので、
完全統一よりは **共通ヘルパー関数のみ共有** の方が現実的:

```
kernel/
  kernel_common.tc    kputs, run_task, make_task 等の共通関数
  kernel_virt.tc      virt 向け main (プリエンプティブ、import kernel_common)
  kernel_pico2.tc     pico2 向け main (順次実行、import kernel_common)
```

→ ただし TC の import は export fn のみ共有でき、
グローバル変数の共有が難しい。kputs 程度なら重複を許容するか、
kernel_common.tc に export fn として切り出す。

### 3. タスクの統一

タスクはプラットフォーム非依存にする。現状の違い:

| | virt タスク | pico2 タスク |
|---|---|---|
| 待ち | mtime (0x0200BFF8) | なし |
| 改行 | `\n` | `\r\n` |

修正方針:
- mtime 依存を削除 (プリエンプション用の待ちはカーネル側の責任)
- 改行は `\r\n` に統一 (virt の 16550 でも問題なし)
- pico2_hello/ と pico2_hello2/ を削除し、hello/ と hello2/ を共通化

### 4. ビルドスクリプトの統一

```bash
# 統一ビルドスクリプト
kernel/build.sh --target virt   -o kernel_virt.bin
kernel/build.sh --target pico2  -o kernel_pico2.uf2
```

内部でターゲットに応じて:
- platform.s を選択
- CRT0_DATA を選択
- UF2 変換 (pico2 のみ)

### 5. crt0_data の統一

```
kernel/crt0_data.s (共通):
    .data
    .globl __data_end
    __data_end:
    .bss
    .align 4
    _trap_frame: .space 132
    _kern_save:  .space 60
    _switch_frame: .space 4
    .globl __arena
    __arena: .space ARENA_SIZE   ← ターゲットで異なる
```

ARENA_SIZE の違い (virt: 4.6MB, pico2: 256KB) は、
platform.s で `__arena` を定義して crt0_data.s から分離するか、
ビルドスクリプトで sed 置換する。

## 実装手順

### ステップ 1: タスク統一
- hello/hello.tc と hello2/hello2.tc から mtime 依存を削除
- 改行を `\r\n` に統一
- pico2_hello/, pico2_hello2/ を削除

### ステップ 2: crt0 分割
- kernel/trap_common.s を作成 (共通 trap/ecall/タスク起動コード)
- kernel/platform_virt.s, kernel/platform_pico2.s を作成 (プラットフォーム固有)
- 既存テストが通ることを確認

### ステップ 3: ビルドスクリプト統一
- kernel/build.sh に --target オプション追加
- build_virt.sh, build_pico2.sh を削除

### ステップ 4: kernel.tc 共通化 (オプション)
- 共通部分を kernel_common.tc に切り出し
- または kputs/run_task の重複を許容して別ファイルのまま維持
