# kernel/platform_virt.s — qemu-system-riscv32 -M virt platform code
#
# UART: 16550 @ 0x10000000, exit via SiFive test @ 0x100000.
# Used together with kernel/trap_common.s and kernel/crt0_data.s.

    .text
    .globl _start
_start:
    la   gp, __global_pointer$
    li   sp, 0x88000000
    la   a0, __arena
    # Must match crt0_data.s:__arena .space size (kept deliberately
    # generous so loader.tc's 16 MB-per-task budget has room for
    # multiple live spawn/wait chains including asm.tc, which
    # statically allocates ~9 MB at startup).
    li   a1, 100663296
    call __runtime_init__u32__i32
    la   t0, _trap_frame
    csrw 0x340, t0
    la   t0, _trap_entry
    csrw 0x305, t0
    call main
_park:
    li   t0, 0x100000
    li   t1, 0x5555
    sw   t1, 0(t0)
1:  j    1b

# ===== Set kernel gp (called from trap_common.s) =====
# On virt, __global_pointer$ is PC-relative-reachable from text.
    .globl _set_kern_gp
_set_kern_gp:
    la   gp, __global_pointer$
    ret

# ===== Kernel runtime stubs =====
# do_uart_write / do_uart_read / do_uart_try_read / do_write / do_read
# moved to kernel/platform_virt.tc (Phase 8). Only do_exit needs raw
# asm — the kernel exit path never returns and must not touch the TC
# runtime, so we just park here.
    .globl do_exit__i32
do_exit__i32:
    j    _park
