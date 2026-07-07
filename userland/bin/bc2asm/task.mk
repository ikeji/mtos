EXTRA_GUEST_TASKS += bc2asm
# 2026-05-15 再計測: worst-case peak 96 KB (bc2asm.tc の .bc)。
# 128 KB は 1.4× 余裕。docs/scaling.md の worst-case 表参照。
TASK_ARENA_bc2asm := 180224  # 2026-07-07: locals_pool 512 + 実測 peak 148K (bc2asm.tc 入力)
TASK_STACK_bc2asm := 16384
