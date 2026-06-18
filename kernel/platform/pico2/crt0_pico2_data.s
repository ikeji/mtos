#
# kernel/crt0_pico2_data.s — data/BSS for Pico 2 kernel
# __data_end marks the .data/.bss boundary for Flash→SRAM copy.
#
# Pico 2 SRAM: 0x20000000 .. 0x20082000 (520 KB). Layout:
#   0x20000000 .. 0x20000120: .data (small, copied from flash, ~288 B)
#   0x20000120 .. 0x200001E4: kernel .bss head (_trap_frame +
#                              _kern_save + _switch_frame ≈ 196 B)
#   0x200001E4 .. 0x20008000: __arena, ~31.5 KB kmalloc pool (just
#                              enough for kernel startup + DOOM spawn;
#                              console/sh boot still OOM)
#   0x20008000 .. 0x20080000: __gcc_sram, 480 KB SRAM block reserved
#                              for one gcc-built guest task at a time.
#                              K22 path-A: 64 KB DG_ScreenBuffer +
#                              ~280 KB other .bss + 16 KB stack + 60+
#                              KB DOOM zone = fits with picolibc slack.
#   0x20080000 .. 0x20082000: kernel stack (8 KB reserved in
#                              platform_pico2.s, sp starts at 0x20082000)
#
# Why __arena shrunk twice — first from 520192 B (504 KB) to
# 196124 B (~191 KB), then to 130588 B (~127 KB) for K22 Phase 5:
# carving __gcc_sram out of the high SRAM was the smallest change
# that let gcc_doom_pico2 boot without rewriting kmalloc. The cost
# is a ~310 KB drop in the kernel's compiler-task budget — asm_pass2
# / asm_pass3 (430-440 KB peak) no longer fit, so this layout is for
# DOOM testing only. Bring back the larger arena (this file + the
# li a1 below) before re-running pico2 self-replicate.
#
# Must stay in sync with platform_pico2.s's `li a1, N` runtime_init
# argument (currently 32284).
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
    .space 32284
    .globl __gcc_sram
__gcc_sram:
    .space 491520
