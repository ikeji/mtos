#
# crt0_tc.s — startup code for tc runtime pipeline
# Text section: _start + syscall/peek/poke stubs
# Data/BSS sections are in crt0_tc_data.s (must be linked AFTER all code)
#
    .text
    .globl _start
_start:
    la   gp, __global_pointer$
    la   sp, __stack_end
    #
    la   a0, __arena
    la   a1, __pool_sizes
    la   a2, __pool_counts
    la   a3, __pool_free
    la   a4, __pool_base
    la   a5, __pool_end
    la   a6, __pools_ready
    call __runtime_init__u32__u32__u32__u32__u32__u32__u32
    call main
    #
    li   a7, 93
    ecall
1:  j    1b

#
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

# peek/poke builtins
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
