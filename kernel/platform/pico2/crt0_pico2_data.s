#
# kernel/crt0_pico2_data.s — data/BSS for Pico 2 kernel
# __data_end marks the .data/.bss boundary for Flash→SRAM copy.
#
# Pico 2 SRAM: 0x20000000 .. 0x20082000 (520 KB). Layout:
#   0x20000000 .. 0x20000120: .data (small, copied from flash, ~288 B)
#   0x20000120 .. 0x200001E4: kernel .bss head (_trap_frame +
#                              _kern_save + _switch_frame ≈ 196 B)
#   0x200001E4 .. 0x20030000: __arena, 196124 B / ~191 KB kmalloc pool
#   0x20030000 .. 0x20080000: __gcc_sram, 320 KB SRAM block reserved
#                              for one gcc-built guest task at a time
#                              (gcc_doom_pico2's .data + .bss live
#                              here at link-time VMA). Not part of
#                              kmalloc's working set — gcc tasks write
#                              to it directly via absolute lui+addi
#                              addressing baked at link time.
#   0x20080000 .. 0x20082000: kernel stack (8 KB reserved in
#                              platform_pico2.s, sp starts at 0x20082000)
#
# Why __arena shrunk from 520192 B (504 KB) to 196124 B (~191 KB):
# carving __gcc_sram out of the high SRAM was the smallest change
# that let gcc_doom_pico2 boot without rewriting kmalloc. The cost
# is a ~310 KB drop in the kernel's compiler-task budget — asm_pass2
# / asm_pass3 (430-440 KB peak) no longer fit, so this layout is for
# DOOM testing only. Bring back the larger arena (this file + the
# li a1 below) before re-running pico2 self-replicate.
#
# Must stay in sync with platform_pico2.s's `li a1, N` runtime_init
# argument (currently 196124).
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
    .space 196124
    .globl __gcc_sram
__gcc_sram:
    .space 327680
