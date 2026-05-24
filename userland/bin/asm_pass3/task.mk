EXTRA_GUEST_TASKS += asm_pass3
# 384 KB. asm_pass3 final step (compiler self-build, 8 inputs) hits
# OOM at 344 KB: same I32Array doubling pattern as asm_pass2 — the
# reloc/edge tables jump 32 KB → 64 KB while live ~316 KB sits in
# arena. 384 KB gives a 49 KB top free block, plus accumulated 23 KB
# fragments = 72 KB, enough for the 64 KB doubling step.
# K14 (2026-05-11) noted 384 KB caused make_task OOM in the kernel
# arena when kernel live was ~122 KB; post-K16/K17 kernel live runs
# lower so 384 KB now fits. See docs/problem.md K14.
# 2026-05-15 再計測: pico2 kernel 17-input link で worst-case peak
# 298 KB (asm_pass2 と同じ 17 input でも encoder 主体で一段低い)。
# 372 KB は 1.3× 余裕。asm_pass2 と arena を揃えてある。
TASK_ARENA_asm_pass3 := 380928
TASK_STACK_asm_pass3 := 16384
