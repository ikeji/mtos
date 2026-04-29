EXTRA_GUEST_TASKS += bc2asm
# 144 KB. Hello World peak 113 KB. Per-fn emission keeps peak nearly
# constant in input size. See docs/scaling.md Q5.
TASK_ARENA_bc2asm := 147456
TASK_STACK_bc2asm := 16384
