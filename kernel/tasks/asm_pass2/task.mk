EXTRA_GUEST_TASKS += asm_pass2
# 360 KB. asm_pass2 --link's 13-input self_replicate merge measured
# peak 300 KB / live 292 KB on a successful run. 320 KB ran but only
# with 20 KB headroom (which was too tight in some virt-reproduced
# scenarios). 384 KB caused `make_task` OOM in the kernel arena —
# the loader's `U8Array(arena_size)` couldn't fit alongside ~122 KB
# of live kernel state. 360 KB is the sweet spot: enough headroom for
# the merge, small enough that the kernel can serve U8Array(368640)
# from its 508 KB arena. See docs/problem.md K14.
# Earlier history: 288 KB was the sweet spot for walked-source +
# /hw.tc-sized user (195 KB) / parse.tc M7-full (165 KB).
TASK_ARENA_asm_pass2 := 344064
TASK_STACK_asm_pass2 := 16384
