#
# crt0_tc_data.s — pool metadata and arena for tc runtime
# Must be placed AFTER all .text code in the assembly stream
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
    .word 1048576

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
    .word 2
    .word 2
    .word 2
    .word 2

#
    .bss
    .align 4
    .globl __pool_free
__pool_free:
    .space 68
    .globl __pool_base
__pool_base:
    .space 68
    .globl __pool_end
__pool_end:
    .space 68
    .globl __pools_ready
__pools_ready:
    .space 4
    .globl __arena
__arena:
    .space 4648960
    .space 65536
__stack_end:
