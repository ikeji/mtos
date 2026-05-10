EXTRA_GUEST_TASKS += asm_pass2
# 320 KB needed for self_replicate LINKMODE step 2 — asm_pass2 --link
# loads 13 input idx files (prelude + user + 11 --add extras) into a
# single merged label table, peaking around 244 KB after all idxs are
# loaded. The previous 288 KB OOMed (`OOM: 65540 p=244096 l=235368`).
# Earlier history: 288 KB was the sweet spot for walked-source +
# /hw.tc-sized user (195 KB) / parse.tc M7-full (165 KB). 320 KB had
# OOMed at kernel-side make_task on heavily fragmented arenas, but
# self_replicate's step boundary (openocd reset between steps) gives
# us a fresh kernel arena per step so that's not an issue here.
TASK_ARENA_asm_pass2 := 327680
TASK_STACK_asm_pass2 := 16384
