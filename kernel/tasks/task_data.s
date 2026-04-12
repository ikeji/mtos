#
# task_data.s — minimal BSS for guest tasks
# Arena memory is provided by the kernel at runtime (a0, a1 args to _start).
# __arena label must exist for linker but is unused.
#
    .bss
    .align 4
    .globl __arena
__arena:
    .space 4
