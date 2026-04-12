#
# kernel/crt0_pico2_data.s — BSS for Pico 2 kernel
# Smaller arena (256KB) to fit in SRAM.
#
    .bss
    .align 4
_trap_frame:
    .space 132
_kern_save:
    .space 60
    .globl __arena
__arena:
    .space 262144
