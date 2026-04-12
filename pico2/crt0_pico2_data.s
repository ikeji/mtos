# pico2/crt0_pico2_data.s — arena BSS for Pico 2 (kmalloc heap)
#
# Concatenated at the END of the asm stream in compile-pico2.sh so that
# __arena ends up in .bss (SRAM-resident, zero-initialised by crt0_pico2.s).
# The arena is 256 KB; crt0_pico2.s passes this to __runtime_init.

    .section .bss
    .align 2
    .globl __arena
__arena:
    # No .space needed: the SRAM region crt0_pico2.s zeros (0x20000000..
    # 0x20080000) provides the backing memory. __runtime_init receives
    # the arena size (262144) as an argument from crt0_pico2.s.
