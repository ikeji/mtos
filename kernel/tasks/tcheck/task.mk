EXTRA_GUEST_TASKS += tcheck
# 224 KB. Hello World peak 74 KB, bc2asm.tc self-host estimate ~170 KB
# (nc=1656 vs Hello World nc=11). bcrun.tc no longer applicable as worst
# case (vartab=128 overflow blocks compile). See docs/scaling.md Q5.
TASK_ARENA_tcheck := 229376
TASK_STACK_tcheck := 16384
