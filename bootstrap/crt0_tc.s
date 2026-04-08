#
#
    .text
    .globl _start
_start:
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

#
    .data
    .align 4
    .globl __pool_sizes
__pool_sizes:
    .word 16
    .word 32
    .word 64
    .word 128
    .word 256
    .word 512
    .word 1024
    .word 2048
    .word 4096
    .word 8192
    .word 16384
    .word 32768
    .word 65536
    .word 131072
    .word 262144
    .word 524288

    .globl __pool_counts
__pool_counts:
    .word 256
    .word 4096
    .word 128
    .word 64
    .word 32
    .word 128
    .word 32
    .word 32
    .word 16
    .word 8
    .word 4
    .word 2
    .word 2
    .word 1
    .word 1
    .word 1

#
    .bss
    .align 4
    .globl __pool_free
__pool_free:
    .space 64
    .globl __pool_base
__pool_base:
    .space 64
    .globl __pool_end
__pool_end:
    .space 64
    .globl __pools_ready
__pools_ready:
    .space 4
    .globl __arena
__arena:
    .space 1634304
    .space 8192
__stack_end:
