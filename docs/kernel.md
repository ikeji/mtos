# カーネル設計

## 方針

- モノリシック、M-mode 単一空間 (MMU / PMP なし)
- プリエンプティブ round-robin スケジューリング (mtime タイマ割り込み)
- virt と pico2 の両 platform で同一 `kernel/*.tc` が動き、platform
  固有コードは `kernel/platform_{virt,pico2}.s` と
  `kernel/kernel.tc` / `kernel/kernel_pico2.tc` にだけ入れる
- `ecall` で Linux 互換番号のシステムコール (write=64, read=63,
  openat=56, close=57, unlink=87, readdir=89, exit=93, nanosleep=101,
  spawn_fds=219, spawn=220, execve=221, pipe=222, mux_enable=250,
  wait4=260) を提供

## ハードウェア構成

### qemu virt (開発 / CI)

- qemu-system-riscv32 -M virt, `-bios none`, `-m 128`
- 16550 UART (0x10000000) / CLINT mtime 10 MHz / SiFive test finisher
- kernel arena = 96 MB の `__arena .space` (`kernel/crt0_data.s`)。
  phase 7 に必要な peak は 500 KB 程度で、拡大の余地は大きい
- ブロックデバイス: `-drive file=disk.img,if=none,id=drv0 -device
  virtio-blk-device,drive=drv0` で mtfs / FAT ディスクを接続

### Raspberry Pi Pico 2 (実機)

- RP2350B (Hazard3 RISC-V dual-core、現在は core0 のみ使用)
- 内蔵 SRAM 520 KB。そのうち **kernel arena 480 KB** (`crt0_pico2_data.s`)
- 外付 Flash 2 MB。OS イメージ + mtfs image を XIP (0x10000000)
- UART は Debug Probe 経由の PL011 (TX=GP0 / RX=GP1、115200 8N1、
  CDC-ACM として /dev/ttyACM0)

## メモリ配置

実装で使っている割り当て:

```
virt (qemu):
  0x80000000  OS イメージ (text + rodata + data + bss)
              bss 内 __arena = 96 MB
              ここから kmalloc が bump + free-list で切り出す

pico2:
  0x10000000  Flash (XIP) : kernel text + rodata + 埋め込み mtfs image
  0x20000000  SRAM        : kernel data + bss + arena (480 KB)
```

- タスクごとに (arena, stack) を `make_task` で切り出す。既定値
  は廃止済 (K3 案C)。**タスクバイナリの先頭 8 byte** に
  `.word arena_size; .word stack_size` ヘッダが入っており、
  `loader.tc::load_fd` がそれを読んで `make_task(entry+8, arena,
  stack)` を呼ぶ。`task_arena_size()` / `task_stack_size()` を
  `kernel/build.sh` が per-task で header.s として emit、task_crt0.s
  の前にリンクしている
- XIP 可能な backend (pico2 の flash) では `vfs_xip_addr` が非 0 を
  返す。`load_fd` が RAM コピーを skip して Flash 上の entry を直接
  `make_task` に渡すので、text は Flash のまま実行される

## メモリ管理

### kmalloc / kfree (`compiler/runtime.tc`)

- 単一 arena の bump アロケータ + 小ブロック free-list
- `km_dump_peak` / `km_live_count` で peak / live の計測
- タスクの arena も同じ kmalloc から確保される (親プロセスが子の
  frame_buf / ram / stack / img / argv を free する責任)。`make_task`
  直後に `g_last_*` に alloc 元を保存し、`sched_register /
  sched_spawn / sys_exec_handler` がスロットに引き渡す

### タスク構造体

`kernel_common.tc::Task`:

```
struct Task {
    frame:     u32,   // 保存された trap frame (コンテキスト)
    state:     i32,   // 0=ready 1=running 2=waiting 3=done ...
    wait_on:   i32,   // sys_wait で待っている子スロット
    frame_buf: u32,   // kmalloc 元ポインタ (clean up 用)
    ram:       u32,   // arena 先頭 (kmalloc 元)
    stack:     u32,   // stack 先頭 (kmalloc 元)
    img:       u32,   // RAM に展開した image ポインタ (XIP 時 0)
    argv:      u32,   // StringArray
    stdin_fd:  i32,   // redirect された fd (既定 0=UART)
    stdout_fd: i32,   // redirect された fd (既定 1=UART)
    in_buf:    u32,   // UART mux 時の per-task in ring (lazy alloc)
    in_head:   i32,
    in_tail:   i32,
    in_eof:    i32,
    name:      u32,   // /bin/<name> の表示用コピー
    t_ram_sz:  i32,   // ヘッダ由来 arena サイズ
    t_stk_sz:  i32,   // ヘッダ由来 stack サイズ
    wake_time: u32,   // nanosleep の起床 mtime
}
```

- `g_tasks` は `TaskArray`、`g_current` が active スロット
- スロットの free/used 判定は `state` フィールド経由 (`sched_*`)

## スケジューラ

- round-robin。タイマ割り込みで `trap_handler` (kernel_common.tc) が
  次の ready スロットを探して `_trap_restore` で切り替える
- `sched_spawn` / `sched_task_exit` / `sched_wait` で状態遷移
- `sys_read` / `pipe_read` / `pipe_write` が待ちたいときは `-2`
  sentinel を返して ecall ハンドラが `sched_yield_read` → 再実行。
  M-mode 割り込み無効のまま spin せず、他スロットに制御を戻す

## ファイルシステム (VFS)

`kernel/vfs.tc` が 1 段の dispatch レイヤ:

| prefix | 実装 | 特性 |
|---|---|---|
| `/tmp/...`  | `tmpfs.tc`  | RAM backed, kmalloc backed, grow-on-write, O_CREAT/O_TRUNC |
| `/proc/...` | `procfs.tc` | read-only virtual (tasks, meminfo, cpuinfo, uptime) |
| (その他絶対パス) | `mtfs.tc` | read-only、Flash に埋め込んだ MyTinyFS |
| `/fat/...` / SD 系 | `fatfs.tc` + `block_fat_virtio.tc` | FAT (bring-up 中) |

fd=0 / fd=1 は current task の `stdin_fd` / `stdout_fd` を参照して
`<` / `>` リダイレクトに対応。fd=2 stderr は常に UART 直行。
UART mux ON のときは fd=1 が tag 付きフレームで emit され、fd=0 は
per-task `in_buf` 経由で入力される。

## システムコール一覧

`trap_common.s::_handle_ecall` で a7 → ハンドラの dispatch。

| a7 | 名前 | ハンドラ | 備考 |
|---|---|---|---|
| 56 | openat | `vfs_open` | **path は String layout**。fd=-1 失敗 |
| 57 | close  | `vfs_close` | |
| 63 | read   | `vfs_read` | empty ＆ UART 等は `-2` で sched yield |
| 64 | write  | `vfs_write` | pipe 満杯は `-2` yield |
| 87 | unlink | `vfs_unlink` | tmpfs は未実装 (#30) |
| 89 | readdir | `vfs_readdir` | mtfs / procfs / tmpfs 対応 |
| 93 | exit   | (trap_common の schedule 分岐) | `km_dump_peak` で peak を stderr に |
| 101 | nanosleep | `sched_nanosleep` | wake_time + state=waiting |
| 219 | spawn_fds | `sys_spawn_fds_handler` | パイプ fd を子に渡す spawn |
| 220 | spawn  | `sys_spawn_handler` | 4 引数 ABI (path, argv, in_path, out_path) |
| 221 | execve | `sys_exec_handler`  | 同じ 4 引数 ABI |
| 222 | pipe   | `sys_pipe_handler`  | 4 KB ring を作って [read_fd, write_fd] を返す |
| 250 | mux_enable | `sys_mux_enable` | UART フレーミング有効化 (runtime 切替) |
| 260 | wait4  | `sys_wait_handler`  | 呼び出し元を waiting に |

**path は NUL 終端の C-string ではなく `String` layout (4 バイト
count + bytes)** を直接渡す。`task_crt0.s` の stub は
`do_openat__i32__String__i32` と `do_openat__i32__StringLiteral__i32`
を同一本体に alias、kernel 側は `peek32(addr)` で count を読む。

## ローダ (`kernel/loader.tc`)

1. `load_task(path)` が VFS で path を open
2. `load_fd(fd)` が先頭 8 バイトを read し `.word arena; .word stack`
   を取り出す (K3 案C)
3. XIP 可能ならその flash アドレス + 8 を entry に、そうでなければ
   RAM に image をコピーして entry に
4. `make_task(entry, arena, stack)` が stack を積んで frame を構築、
   `g_last_*` を埋めた状態で returna
5. `sched_register` / `sched_spawn` / `sys_exec_handler` が
   `g_last_*` を対応 Task に移してスロットを ready 化

ELF ではなく `compile-gen2.sh` が `; raw` で吐く生バイナリ + 8 byte
header。再配置情報なしで済むように asm_pass2 が gp 相対 la を
常用する。

## 割り込み・例外処理

- M-mode で動作。mtvec に `_trap_entry` (trap_common.s) を登録
- 対応する割り込み / 例外:
  - タイマ (CLINT / SIO mtime): round-robin preempt
  - 外部 (UART RX、pico2 で PL011 interrupt 有効化は TODO)
  - `ecall`: syscall
  - fault / illegal / ...: `trap_handler` が task を殺して次に切り替え
- platform 差分は `rearm_timer()` と `read_mtime()` でラップ
  (kernel.tc: CLINT; kernel_pico2.tc: SIO MTIME)

## UART 多重化

host ←→ kernel 双方で `1F <tag:4> <len:1> <payload:N>` フレームを
使う。kernel 側の `uart_emit_frame` (`kernel_common.tc`) が kputs /
kdbg_chr は `KERN` タグ、per-task fd=1 は `T00N` (N = slot hex) タグで
wrap する。RX 側は `uart_rx_dispatch` が tag を見て対応 Task の
`in_buf` に enqueue。

ランタイム切替: userspace から `muxon` / `muxoff` タスク (ecall 250)。
実装詳細は `docs/task/uart_multiplex.md`。

## ブートシーケンス

```
1. platform_*.s の _start: stack 設定、BSS 初期化、__runtime_init で
   kmalloc arena 登録 (arena_size は crt0_data.s の .space と一致)
2. kernel_main (kernel.tc / kernel_pico2.tc): UART 初期化、mtvec 登録
3. block デバイス初期化 (virtio-mmio または flash XIP backend)
4. mtfs_mount → VFS ready
5. /etc/kern.conf を読む (省略時は /bin/sh のみ seed)
   - init=/bin/... 行で起動時タスクを指定
   - mux=on で UART mux を有効化
6. sched_start で最初のスロットに切り替え、mtime タイマ起動
```

詳細は以下を参照:
- `docs/task/kernel_design.md` — 初期設計メモ
- `docs/task/kernel_platform_split.md` — virt / pico2 共通化の経緯
- `docs/task/phase6_userland.md` — ユーザランド / sh の設計
- `docs/task/phase7_compiler_on_os.md` — phase 7 (compiler on OS)
- `docs/task/pipeline_100kb.md` — compiler タスクのメモリ削減
- `docs/filesystem.md` — VFS + mtfs 詳細
- `docs/task/uart_multiplex.md` — UART mux フォーマット
- `docs/task/pico2_port.md` / `docs/task/pico2_tc_runtime.md` — pico2 移植
