#
# kernel/platform/tn20k/crt0_tn20k_data.s — BSS for the Tang Nano 20K kernel
# _trap_frame and _kern_save must be near __global_pointer$ (gp-relative ±2KB).
# __arena is placed last; its real size is computed at boot by
# platform_tn20k.s (RAM top - 64 KB - __arena), the .space here only
# sets the nominal memsz (raw mode never emits .bss bytes).
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
    .space 4194304
