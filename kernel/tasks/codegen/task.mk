EXTRA_GUEST_TASKS += codegen
# 192 KB needed when codegen processes bc2asm.tc-sized input (nc=1656,
# sp=23892). 128 KB peaks at 126 KB just before final emit and leaves
# no room for the per-fn epilogue allocations.
# 2026-05-15 再計測: worst-case peak 128 KB (bc2asm.tc の .tast)。
# 192 KB は 1.5× 余裕。docs/scaling.md の worst-case 表参照。
TASK_ARENA_codegen := 196608
TASK_STACK_codegen := 16384
