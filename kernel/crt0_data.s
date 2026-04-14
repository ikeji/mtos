#
# kernel/crt0_data.s — BSS for kernel
# _trap_frame and _kern_save must be near __global_pointer$ (gp-relative ±2KB).
# __arena is large and placed last since it is only accessed via peek/poke.
#
# Arena size: 32 MB. Each spawned task gets a flat 4 MB RAM + 64 KB
# stack from loader.tc (phase 7 E-step1), so we need room for the
# seeded tasks plus a few live spawn/wait chains simultaneously.
# qemu virt has 128 MB of RAM, so 32 MB of arena still leaves
# plenty of headroom for the kernel ELF itself, stacks, etc.
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
    .space 33554432
