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
    # generous so loader.tc's 4 MB-per-task budget has room for a
    # handful of live spawn/wait chains).
    li   a1, 33554432
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

# ===== UART write (16550 TX) =====
    .globl do_uart_write__u32__i32
do_uart_write__u32__i32:
    li   t0, 0x10000000
    mv   t2, a1
1:  beqz t2, 2f
    lbu  t1, 0(a0)
    sb   t1, 0(t0)
    addi a0, a0, 1
    addi t2, t2, -1
    j    1b
2:  mv   a0, a1
    ret

# ===== UART read (16550 RX) =====
    .globl do_uart_read__u32__i32
do_uart_read__u32__i32:
    li   t0, 0x10000000
    beqz a1, 5f
    mv   t2, a1
    mv   t3, a0
3:  lbu  t1, 5(t0)            # LSR
    andi t1, t1, 1            # Data Ready
    beqz t1, 3b
    lbu  t1, 0(t0)            # RBR
    sb   t1, 0(t3)
    addi t3, t3, 1
    addi t2, t2, -1
4:  beqz t2, 5f
    lbu  t1, 5(t0)
    andi t1, t1, 1
    beqz t1, 5f
    lbu  t1, 0(t0)
    sb   t1, 0(t3)
    addi t3, t3, 1
    addi t2, t2, -1
    j    4b
5:  sub  a0, a1, t2
    ret

# ===== Kernel runtime stubs (sys_write/read/exit from kernel itself) =====
    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    mv   a0, a1
    mv   a1, a2
    j    do_uart_write__u32__i32
    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    mv   a0, a1
    mv   a1, a2
    j    do_uart_read__u32__i32
    .globl do_exit__i32
do_exit__i32:
    j    _park
