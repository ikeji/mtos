#
# task_data.s — data/BSS boundary marker + minimal BSS for guest tasks
# __data_end marks the end of .data; task_crt0.s uses it to compute copy size.
# Arena memory is provided by the kernel at runtime (a0, a1 args to _start).
#
    .data
    .globl __data_end
__data_end:
    .bss
    .align 4
    .globl __arena
__arena:
    .space 4
