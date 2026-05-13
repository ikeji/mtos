EXTRA_GUEST_TASKS += asm_pass1
# asm_pass1 unions the lab-build (asm_pass2 mode) and encoder
# (asm_pass3 mode) duties, so it needs roughly asm_pass3's working
# set. After kernel-arena fragmentation was eliminated (K16/K17 +
# Hello World 1-boot work), we can afford bigger task arenas. Bumped
# to 360 KB so parse self-build can pre-encode parse.s (whose
# bc2asm output is ~700 KB and pushes asm_pass1 peak to ~250 KB +
# the next contiguous alloc above that).
TASK_ARENA_asm_pass1 := 368640
TASK_STACK_asm_pass1 := 16384
