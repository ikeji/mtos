EXTRA_GUEST_TASKS += sigscan
# 2026-05-15 再計測: worst-case peak 9.4 KB (bc2asm.tc の .ast)。
# 32 KB は 3.5× 余裕だが、kernel arena のピーク要求は asm_pass2
# (~398 KB RAM block) が決めるので縮小しても効果なし。現状維持。
TASK_ARENA_sigscan := 32768
TASK_STACK_sigscan := 16384
