# カーネル設計: タスク管理とプラットフォーム抽象化

## 概要

TC 言語で書かれたカーネルが、独立にコンパイルされたゲストタスク（raw バイナリ）
を起動・管理する。タイマ割り込みによるプリエンプティブ・ラウンドロビンスケジューラ
で複数タスクを並行実行する。現在は qemu virt で動作確認済み。

## ディレクトリ構成

```
kernel/
  kernel.tc           カーネル本体（スケジューラ、trap handler、タスク管理）
  crt0_virt.s         virt 向け crt0（UART、trap entry/exit、ecall handler、タスク起動）
  crt0_data.s         共通 BSS（__arena、_trap_frame、_kern_save、_switch_frame）
  build_virt.sh       virt 向けビルドスクリプト（タスクビルド → bin2s → カーネルビルド）
  bin2s.sh            raw バイナリ → .s データ変換スクリプト
  tasks/
    task_crt0.s       タスク用 crt0（ecall ベース syscall）
    task_data.s       タスク用 BSS（最小 __arena ラベルのみ）
    hello/
      hello.tc        タスク1: "A" を5回出力
    hello2/
      hello2.tc       タスク2: "B" を5回出力
```

## アーキテクチャ

### 全体像

```
+--------------------------------------------------+
|  カーネル (M-mode)                                 |
|  - trap_handler (TC): タイマ割り込み → ラウンドロビン |
|  - ecall handler (asm): sys_write → UART、         |
|    sys_exit → sched_task_exit → 次タスク or 復帰   |
|  - sched_start: mret でタスク起動                   |
+--------------------------------------------------+
|  ゲストタスク (M-mode、別スタック・別 gp)             |
|  - ecall で syscall 発行 (Linux 互換 ABI)          |
|  - カーネルとは別の raw バイナリとしてコンパイル        |
|  - bin2s でカーネルイメージの .rodata に埋め込み       |
+--------------------------------------------------+
|  プラットフォーム crt0 (crt0_virt.s)                 |
|  - ハードウェア初期化 (16550 UART)                  |
|  - trap vector (_trap_entry / _trap_restore)       |
|  - ecall dispatcher、コンテキストスイッチ            |
+--------------------------------------------------+
```

全コードが M-mode で動作する（MMU/U-mode は将来対応）。
タスクの「分離」は別スタック + 別 gp + per-task トラップフレームで実現。

### タスクのビルドフロー

```
hello.tc
  → compile-gen2.sh (task_crt0.s + task_data.s, ; raw)
  → hello.bin                           # raw バイナリ（text+rodata+data）
  → bin2s.sh hello.bin _task_hello
  → hello_task.s                        # .byte + _task_hello_start/end/size
```

### カーネルのビルドフロー

```
kernel.tc + hello_task.s + hello2_task.s
  → compile-gen2.sh (crt0_virt.s + crt0_data.s + task .s, ; raw)
  → kernel_virt.bin
```

`build_virt.sh` がタスクビルド → bin2s → カーネルビルドを一括実行:
```bash
GEN2_DIR=/path/to/gen2 ./kernel/build_virt.sh -o kernel.bin
```

### タスクバイナリ形式

タスクは `; raw` モードで生成:

| 領域    | 内容                              |
|---------|-----------------------------------|
| text    | 命令コード（_start がオフセット 0）  |
| rodata  | 文字列リテラル等                    |
| data    | 初期化済みグローバル変数             |
| (bss)   | filesz に含まれない、data+bss < 4KB |

タスクコードは .rodata に埋め込まれ、in-place で実行される（virt では RAM 上）。

### タスク起動プロトコル

カーネルが `init_task_frame` で per-task トラップフレーム (132B) を初期化:

| フレームオフセット | 設定値                           |
|-------------------|----------------------------------|
| 8 (sp)            | タスク用スタックトップ              |
| 12 (gp)           | タスク用 RAM + 0x800              |
| 40 (a0)           | arena アドレス                     |
| 44 (a1)           | arena サイズ                       |
| 128 (mepc)        | タスクの _start アドレス            |

`sched_start(frame)` でフレームからレジスタを復元し、mret でタスク起動。
**mstatus.MPP = M-mode (0x1800) と MPIE (0x80) のセットが必須**
（未設定だと U-mode に落ちて PMP で命令フェッチフォールト）。

### タスク用 gp とメモリ管理

カーネルが各タスクに 64KB の RAM を確保:
```
ram_base (64KB):
  [0..4095]       data + bss 領域 (gp 相対アクセス先)
  [4096..65535]   arena (kmalloc ヒープ)
```
- `gp = ram_base + 0x800` (asm.tc の `__global_pointer$ = data_base + 0x800` に対応)
- タスクの gp 相対アクセスはこの RAM に向かう
- タスクの .bss はバイナリに含まれない→ kmalloc の zero 初期化が代替
- 初期化済みグローバル変数のコピーは将来 task_crt0 が担当

### ecall ハンドラ (アセンブリ)

`_handle_ecall` は `_trap_entry` 内でアセンブリ処理:

| a7  | syscall   | 処理                                        |
|-----|-----------|---------------------------------------------|
| 64  | sys_write | トラップフレームの a1/a2 で `do_uart_write`   |
| 93  | sys_exit  | TC `sched_task_exit()` を呼び次タスクへ切替  |

sys_write: mepc += 4 して mret (タスクに復帰)。
sys_exit: `sched_task_exit()` が次の ready タスクのフレームアドレスを返す。
0 なら全タスク完了 → `_task_exit_trampoline` でカーネルに復帰。

### コンテキストスイッチ

```
_trap_entry:
  csrrw sp, mscratch, sp     # sp ↔ 現タスクのトラップフレーム
  全31レジスタ + mepc を保存
  mcause で ecall / タイマ を判別

_trap_restore:
  _switch_frame が非0なら mscratch を切り替え (コンテキストスイッチ)
  mscratch のフレームから全レジスタ + mepc を復元
  mret
```

TC の `trap_handler` がタイマ割り込みで `set_switch_frame(next_frame)` を呼ぶと、
`_trap_restore` が mscratch を新フレームに切り替えてから mret する。

### プラットフォーム抽象化

| 機能              | virt (crt0_virt.s)        | Pico 2 (将来)            |
|-------------------|--------------------------|---------------------------|
| UART 出力         | 16550 @ 0x10000000       | PL011 UART0 @ 0x40070000 |
| 終了              | SiFive test @ 0x100000   | j _park                   |
| RAM               | 0x80000000 (128MB)       | SRAM 0x20000000 (520KB)  |
| タイマ (CLINT)    | 0x02004000               | 未調査                     |

### メモリレイアウト (virt)

```
0x80000000  +------------------+
            | kernel text      |  crt0 + runtime + kernel.tc
            | kernel rodata    |  タスクバイナリ (bin2s 埋め込み)
            | kernel data      |
            +------------------+
            | BSS              |  _trap_frame, _kern_save, _switch_frame
            | __arena          |  kmalloc ヒープ (~4.4MB)
            +------------------+
            | タスク RAM × N    |  各 64KB (kmalloc で確保)
            | タスクスタック × N |  各 64KB (kmalloc で確保)
            +------------------+
            :                  :
0x88000000  | kernel stack top |
```

## 組み込み関数 (カーネル向け)

| 関数                                              | 説明                        |
|---------------------------------------------------|-----------------------------|
| `kern_run_task(id, sp, gp, arena, size) -> i32`   | 協調的タスク実行 (直接ジャンプ) |
| `init_task_frame(frame, id, sp, gp, arena, size)` | トラップフレーム初期化         |
| `sched_start(frame)`                              | mret でタスク起動             |
| `set_switch_frame(addr)`                          | 次回 mret で復元するフレーム設定 |
| `csr_read/write_mstatus/mie/mcause`               | CSR アクセス                  |

## 実装状況

- [x] ステップ 1: 最小カーネル + ecall ハンドラ (1タスク、協調的)
- [x] ステップ 2: 複数タスク逐次実行
- [x] ステップ 3: タイマ割り込みによるプリエンプティブスケジューリング
- [ ] ステップ 4: Pico 2 対応
- [ ] タスクの .data セクション初期化コピー (task_crt0 で実装予定)
