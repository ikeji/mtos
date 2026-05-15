EXTRA_GUEST_TASKS += bc2asm
# 2026-05-15 再計測: worst-case peak 96 KB (bc2asm.tc の .bc)。
# 128 KB は 1.4× 余裕。docs/scaling.md の worst-case 表参照。
TASK_ARENA_bc2asm := 131072
TASK_STACK_bc2asm := 16384
