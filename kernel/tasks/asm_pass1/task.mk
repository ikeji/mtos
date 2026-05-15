EXTRA_GUEST_TASKS += asm_pass1
# asm_pass1 unions the lab-build (asm_pass2 mode) and encoder
# (asm_pass3 mode) duties, so it needs roughly asm_pass3's working
# set. After kernel-arena fragmentation was eliminated (K16/K17 +
# Hello World 1-boot work), we can afford bigger task arenas. Bumped
# to 360 KB so parse self-build can pre-encode parse.s (whose
# bc2asm output is ~700 KB and pushes asm_pass1 peak to ~250 KB +
# the next contiguous alloc above that).
# 2026-05-15 再計測: worst-case peak 185 KB (compiler 4-file 連結
# .s ~750 KB を 1 本で pre-encode)。multi-input 化後は per-file 実行
# なので実 worst case はもっと低い。360 KB は 2.0× 余裕だが、kernel
# arena のピーク要求は asm_pass2 が決めるので縮小は見送り。
TASK_ARENA_asm_pass1 := 368640
TASK_STACK_asm_pass1 := 16384
