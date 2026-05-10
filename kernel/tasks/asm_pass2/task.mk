EXTRA_GUEST_TASKS += asm_pass2
# 384 KB needed for self_replicate LINKMODE step 2 — asm_pass2 --link
# loads 13 input idx files (prelude + user + 11 --add extras) into a
# single merged label table. Previous estimate said peak ~244 KB
# (which was actually the OOM-aborted value, not the true peak); a
# successful run measures peak ~300 KB live ~292 KB. 320 KB ran but
# only with 20 KB headroom, so we bump to 384 KB to match asm_pass3
# (the bigger of the pair) and leave room for future input growth.
# self_replicate's step boundary (openocd reset between steps) gives
# us a fresh kernel arena per step, so the larger make_task fits.
# Earlier history: 288 KB was the sweet spot for walked-source +
# /hw.tc-sized user (195 KB) / parse.tc M7-full (165 KB).
TASK_ARENA_asm_pass2 := 393216
TASK_STACK_asm_pass2 := 16384
