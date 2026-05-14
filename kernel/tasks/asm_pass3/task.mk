EXTRA_GUEST_TASKS += asm_pass3
# 384 KB. asm_pass3 final step (compiler self-build, 8 inputs) hits
# OOM at 344 KB: same I32Array doubling pattern as asm_pass2 — the
# reloc/edge tables jump 32 KB → 64 KB while live ~316 KB sits in
# arena. 384 KB gives a 49 KB top free block, plus accumulated 23 KB
# fragments = 72 KB, enough for the 64 KB doubling step.
# K14 (2026-05-11) noted 384 KB caused make_task OOM in the kernel
# arena when kernel live was ~122 KB; post-K16/K17 kernel live runs
# lower so 384 KB now fits. See docs/problem.md K14.
TASK_ARENA_asm_pass3 := 380928
TASK_STACK_asm_pass3 := 16384
