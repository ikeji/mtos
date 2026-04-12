# カーネル設計: タスク管理とプラットフォーム抽象化

## 概要

TC 言語で書かれたカーネルが、独立にコンパイルされたゲストタスク（raw バイナリ）
を起動・管理する。カーネルは qemu virt と RP2350 (Pico 2) の両方で動作する。

## ディレクトリ構成

```
kernel/
  kernel.tc           カーネル本体（タスク管理、syscall ハンドラ、スケジューラ）
  crt0_virt.s         virt 向け crt0（16550 UART、SiFive test exit）
  crt0_pico2.s        Pico 2 向け crt0（XOSC/UART0 初期化、IMAGE_DEF）
  crt0_data.s         共通 BSS（__arena、トラップフレーム等）
  build_virt.sh       virt 向けビルドスクリプト
  build_pico2.sh      Pico 2 向けビルドスクリプト
  bin2s.sh            raw バイナリ → .s データ変換スクリプト
  tasks/
    hello/
      hello.tc         ゲストタスク: hello world
      task_crt0.s      タスク用 crt0（ecall ベース syscall）
      task_data.s      タスク用 BSS/data（最小限）
```

## アーキテクチャ

### 全体像

```
+--------------------------------------------------+
|  カーネル (M-mode)                                 |
|  - trap handler (割り込み + ecall)                  |
|  - syscall dispatcher (write, exit)               |
|  - タスク管理 (起動、停止)                          |
+--------------------------------------------------+
|  ゲストタスク (M-mode、別スタック)                    |
|  - ecall で syscall 発行                           |
|  - カーネルとは別の raw バイナリとしてコンパイル        |
|  - bin2s でカーネルイメージに埋め込み                  |
+--------------------------------------------------+
|  プラットフォーム crt0                               |
|  - ハードウェア初期化 (UART, クロック)               |
|  - trap vector 設定                                |
|  - do_uart_write / do_uart_read (カーネル内部用)     |
+--------------------------------------------------+
```

全コードが M-mode で動作する（MMU/U-mode は将来対応）。
タスクの「分離」は別スタック + 保存レジスタで実現する。

### タスクのビルドフロー

```
hello.tc
  → compile-gen2.sh (task_crt0.s + task_data.s, ; raw)
  → hello.bin                         # raw バイナリ（text+rodata+data）
  → bin2s.sh hello.bin _task_hello
  → hello_task.s                      # .byte データ + _task_hello_start/end/size
```

`bin2s.sh` の出力例:
```asm
    .section .rodata
    .globl _task_hello_start
    .align 4
_task_hello_start:
    .byte 0x97,0x02,0x00,0x00, ...    # raw バイナリの内容
    .globl _task_hello_end
_task_hello_end:
    .globl _task_hello_size
_task_hello_size:
    .word _task_hello_end - _task_hello_start
```

### カーネルのビルドフロー

```
kernel.tc + hello_task.s
  → compile-gen2.sh (crt0_virt.s + crt0_data.s, ; raw)
  → kernel_virt.bin
```

compile-gen2.sh はアセンブリ連結時に hello_task.s も含める。
カーネルの TC コードからは `_task_hello_start` を peek32 等で参照する。

### タスクバイナリ形式

タスクは compile-gen2.sh の `; raw` モードで生成される。出力は：

| 領域    | 内容                              |
|---------|-----------------------------------|
| text    | 命令コード（_start がオフセット 0）  |
| rodata  | 読み取り専用データ                  |
| data    | 初期化済みグローバル変数             |
| (bss)   | filesz に含まれない、実行時にゼロ化  |

`_start` → `la gp, __global_pointer$` → `call main` → ecall exit。

asm.tc は PIC (Position Independent Code) を生成するので、
ロードアドレスに依存しない。gp は `la gp, __global_pointer$`
（PC 相対 fallback）で実行時に解決される。

### タスク用 crt0 (task_crt0.s)

```asm
    .text
    .globl _start
_start:
    # sp はカーネルが設定済み
    la   gp, __global_pointer$   # PC 相対 (in-place 実行なので動作)
    la   a0, __arena
    li   a1, 65536               # 64KB arena
    call __runtime_init__u32__i32
    call main
    # sys_exit(return value of main) — ecall でカーネルに戻る
    li   a7, 93
    ecall
1:  j    1b

# syscall stubs (ecall ベース — カーネルの trap handler が処理)
    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    li   a7, 64
    ecall
    ret

    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    li   a7, 63
    ecall
    ret

    .globl do_exit__i32
do_exit__i32:
    li   a7, 93
    ecall
    ret
```

これは既存の `compiler/crt0_tc.s` (Linux ユーザ空間用) と同じ ecall ABI。

**カーネルからのタスク起動プロトコル** (現行 virt 版):
カーネルの `kern_run_task` がタスク _start にジャンプする前に:
- `sp` = タスク用スタックトップ

タスク _start は自身で gp を PC 相対 la で初期化し、__arena を設定する。
virt では RAM 上で in-place 実行するため PC 相対アドレッシングが動作する。

**将来 (Pico 2 対応時)**: Flash 上のコードが SRAM 上のデータを参照する場合、
タスク自身の PC 相対 la では正しい gp が得られない。カーネルがタスク起動前に
gp, a0, a1 を設定し、タスク _start は gp 初期化をスキップする設計に変更する。

### カーネルの trap handler

```
trap_handler(cause, epc):
    if cause == 0x80000007:    # M-mode timer interrupt
        schedule_next()
        rearm_timer()
    elif cause == 11:          # Environment call from M-mode
        handle_ecall(epc)
    else:
        panic()
```

ecall のディスパッチ (a7 レジスタで syscall 番号を判定):

| a7  | syscall   | 引数                    | 処理                    |
|-----|-----------|-------------------------|-------------------------|
| 64  | sys_write | a0=fd, a1=buf, a2=len   | UART に出力              |
| 63  | sys_read  | a0=fd, a1=buf, a2=len   | UART から入力 (将来)      |
| 93  | sys_exit  | a0=status               | タスク終了、カーネルに復帰 |

ecall は mepc を ecall 命令のアドレスにセットするので、
復帰時は mepc + 4 (次の命令) に戻す必要がある。

### タスク起動シーケンス

1. カーネルがタスクバイナリのアドレスを取得（`_task_hello_start`）
2. タスク用スタックを kmalloc で確保
3. タスクの BSS 領域をゼロクリア（必要に応じて）
4. mscratch にタスクのトラップフレームをセット
5. sp = スタックトップ、pc = タスクの `_start` に設定した状態を
   トラップフレームに格納し、mret で起動
   - または単純に: sp をセットしてタスクの _start を call
     （最初は協調的実行で十分）

### プラットフォーム抽象化

crt0 がプラットフォーム差異を吸収する:

| 機能              | virt (crt0_virt.s)        | Pico 2 (crt0_pico2.s)    |
|-------------------|--------------------------|---------------------------|
| UART 出力         | 16550 @ 0x10000000       | PL011 UART0 @ 0x40070000 |
| 終了              | SiFive test @ 0x100000   | j _park (無限ループ)       |
| RAM               | 0x80000000 (128MB)       | SRAM 0x20000000 (520KB)  |
| クロック初期化     | 不要                      | XOSC + clk_peri           |
| タイマ (CLINT)    | 0x02004000               | 未調査                     |
| trap vector       | _trap_entry (共通)        | _trap_entry (共通)         |

カーネルの TC コードは `do_uart_write(buf, len)` のようなプラットフォーム
非依存関数を呼ぶ。crt0 がこれを実際のハードウェア操作に変換する。

### メモリレイアウト

**virt (qemu-system-riscv32 -M virt -m 128)**:
```
0x80000000  +------------------+
            | kernel code      |  text (crt0 + runtime + kernel.tc)
            | kernel rodata    |
            | task binaries    |  .rodata (bin2s で埋め込み)
            | kernel data      |
            +------------------+
            | kernel BSS       |  __arena (kmalloc ヒープ)
            +------------------+
            | タスクスタック     |  kmalloc で動的確保
            +------------------+
            :                  :
0x88000000  | kernel stack (top)|  sp 初期値
```

**Pico 2 (RP2350 RISC-V)**:
```
0x10000000  +------------------+  Flash (読み取り専用)
            | IMAGE_DEF        |
            | kernel code      |
            | task binaries    |  (Flashから直接実行可能)
            +------------------+
0x20000000  +------------------+  SRAM
            | data + bss       |  (crt0 が Flash から SRAM にコピー、将来)
            | __arena          |
            | タスクスタック     |
            +------------------+
0x20082000  | stack (top)      |
```

## 実装ステップ

### ステップ 1: 最小カーネル + ecall ハンドラ

- `kernel/` ディレクトリ作成
- `kernel/bin2s.sh`: raw → .s 変換スクリプト
- `kernel/tasks/hello/`: 最小ゲストタスク (ecall で文字列出力 + exit)
- `kernel/kernel.tc`: タスクを起動して ecall を処理するカーネル
- `kernel/crt0_virt.s`: trap handler で ecall をディスパッチ
- テスト: qemu virt で HELLO_OK + KERN_OK を確認

### ステップ 2: 複数タスク + 協調的切り替え

- 2つのタスクを埋め込み
- sys_exit で次のタスクに切り替え
- テスト: TASK1_OK + TASK2_OK + KERN_OK

### ステップ 3: タイマ割り込みによるプリエンプション

- per-task トラップフレーム
- タイマ割り込みハンドラでコンテキストスイッチ
- テスト: 2タスクが交互に実行される

### ステップ 4: Pico 2 対応

- `kernel/crt0_pico2.s` 作成
- `kernel/build_pico2.sh` 作成
- 実機テスト
