EXTRA_GUEST_TASKS += codegen
# 192 KB needed when codegen processes bc2asm.tc-sized input (nc=1656,
# sp=23892). 128 KB peaks at 126 KB just before final emit and leaves
# no room for the per-fn epilogue allocations.
TASK_ARENA_codegen := 196608
TASK_STACK_codegen := 16384
