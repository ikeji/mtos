#
# kernel/crt0_pico2_data.s — data/BSS for Pico 2 kernel
# __data_end marks the .data/.bss boundary for Flash→SRAM copy.
# Smaller arena (256KB) to fit in SRAM.
#
    .data
    .globl __data_end
__data_end:
    .bss
    .align 4
_trap_frame:
    .space 132
_kern_save:
    .space 60
    .globl __arena
__arena:
    .space 262144
