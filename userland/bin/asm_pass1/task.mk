EXTRA_GUEST_TASKS += asm_pass1
# asm_pass1 unions the lab-build (asm_pass2 mode) and encoder
# (asm_pass3 mode) duties, so it needs roughly asm_pass3's working
# set. After kernel-arena fragmentation was eliminated (K16/K17 +
# Hello World 1-boot work), we can afford bigger task arenas. Bumped
# to 360 KB so parse self-build can pre-encode parse.s (whose
# bc2asm output is ~700 KB and pushes asm_pass1 peak to ~250 KB +
# the next contiguous alloc above that).
# 2026-05-15 再計測: approach A 後 asm_pass1 は per-file 実行なので
# worst case は単一の最大 .s = asm_common.s (1.27 MB) を pre-encode
# したとき。実測 peak 222 KB (parse.s 726 KB→141 KB、fatfs.s 536 KB
# →134 KB)。360 KB は 1.7× 余裕。kernel arena のピーク要求は
# asm_pass2 が決めるので縮小は見送り。docs/scaling.md 参照。
TASK_ARENA_asm_pass1 := 368640
TASK_STACK_asm_pass1 := 16384
