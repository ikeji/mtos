#
# kernel/crt0_pico2_data.s — data/BSS for Pico 2 kernel
# __data_end marks the .data/.bss boundary for Flash→SRAM copy.
#
# Pico 2 SRAM: 0x20000000 .. 0x20082000 (520 KB). Layout:
#   0x20000000 .. 0x20000120: .data (small, copied from flash, ~288 B)
#   0x20000120 .. ~0x20078100: kernel .bss + __arena
#   0x20080000 .. 0x20082000:   kernel stack (8 KB reserved in platform_pico2.s)
#
# __arena at 491520 B (480 KB). Leaves ~32 KB slack between the end of
# bss and the kernel stack so the kernel's own scratch has room to grow.
# Sized to hold one full compiler task (asm_pass1 430 KB / asm_pass2
# 441 KB peak + stack + img) on pico2. Must stay in sync with
# platform_pico2.s's `li a1, N` runtime_init argument.
    .data
    .globl __data_end
__data_end:
    .bss
    .align 4
_trap_frame:
    .space 132
_kern_save:
    .space 60
_switch_frame:
    .space 4
    .globl __arena
__arena:
    .space 491520
