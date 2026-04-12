#
# kernel/crt0_data.s — BSS for kernel
# _trap_frame and _kern_save must be near __global_pointer$ (gp-relative ±2KB).
# __arena is large and placed last since it is only accessed via peek/poke.
#
    .bss
    .align 4
_trap_frame:
    .space 132
_kern_save:
    .space 60
    .globl __arena
__arena:
    .space 4648960
