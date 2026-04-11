# tests/virt_crt0.s — minimal crt0 for qemu-system-riscv32 -M virt
#
# Used by tests/test_asm.sh to run TC programs end-to-end on the virt
# machine. UART output goes to 16550 @ 0x10000000 (no THRE wait — qemu
# is always ready). Pairs with bootstrap/crt0_tc_data.s for pool
# metadata and __arena.

    .text
    .globl _start
_start:
    la   sp, __stack_end
    la   a0, __arena
    la   a1, __pool_sizes
    la   a2, __pool_counts
    la   a3, __pool_free
    la   a4, __pool_base
    la   a5, __pool_end
    la   a6, __pools_ready
    call __runtime_init__u32__u32__u32__u32__u32__u32__u32
    call main
    # Shut qemu down via the SiFive test MMIO (virt machine only).
    # Writing 0x5555 to 0x100000 exits qemu with status 0.
_park:
    li   t0, 0x100000
    li   t1, 0x5555
    sw   t1, 0(t0)
1:  j    1b

    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    # a0 = fd (ignored), a1 = buf, a2 = len
    li   t0, 0x10000000         # 16550 UART data register
    mv   t2, a2
1:  beqz t2, 2f
    lbu  t1, 0(a1)
    sb   t1, 0(t0)
    addi a1, a1, 1
    addi t2, t2, -1
    j    1b
2:  mv   a0, a2                 # return count
    ret

    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    li   a0, 0
    ret

    .globl do_exit__i32
do_exit__i32:
    # do_exit(code) — shut qemu down with status. code != 0 → fail.
    beqz a0, 1f
    # Fail: write 0x3333 | (code << 16) to 0x100000
    slli a0, a0, 16
    li   t1, 0x3333
    or   t1, t1, a0
    j    2f
1:  li   t1, 0x5555
2:  li   t0, 0x100000
    sw   t1, 0(t0)
3:  j    3b

    .globl peek8__u32
peek8__u32:
    lbu  a0, 0(a0)
    ret
    .globl peek16__u32
peek16__u32:
    lhu  a0, 0(a0)
    ret
    .globl peek32__u32
peek32__u32:
    lw   a0, 0(a0)
    ret
    .globl poke8__u32__u8
poke8__u32__u8:
    sb   a1, 0(a0)
    ret
    .globl poke16__u32__u16
poke16__u32__u16:
    sh   a1, 0(a0)
    ret
    .globl poke32__u32__u32
poke32__u32__u32:
    sw   a1, 0(a0)
    ret
