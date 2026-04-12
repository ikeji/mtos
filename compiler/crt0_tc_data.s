#
# crt0_tc_data.s — arena BSS for tc runtime (kmalloc heap)
# Must be placed AFTER all .text code in the assembly stream
#
    .bss
    .align 4
    .globl __arena
__arena:
    .space 4648960
