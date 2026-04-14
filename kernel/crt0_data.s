#
# kernel/crt0_data.s — BSS for kernel
# _trap_frame and _kern_save must be near __global_pointer$ (gp-relative ±2KB).
# __arena is large and placed last since it is only accessed via peek/poke.
#
# Arena size: 96 MB. Each spawned task now gets a flat 16 MB RAM
# block (loader.tc TASK_RAM_SIZE) so that the asm.tc assembler — which
# statically allocates ~9 MB at startup (g_code + g_lines +
# g_line_offs/lens + labels) — fits in a single task with working
# space to spare. Peak memory with 5 live slots stays under 80 MB,
# leaving the rest of qemu virt's 128 MB for the kernel text, stacks,
# and qemu overhead. Raw mode output (ASM_PROLOGUE="; raw") means
# the .bss .space never actually shows up in the emitted binary, so
# this only affects runtime memory use.
#
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
    .space 100663296
