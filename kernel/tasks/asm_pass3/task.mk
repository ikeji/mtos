EXTRA_GUEST_TASKS += asm_pass3
# 320 KB needed for self_replicate LINKMODE step 3 — the 13-input
# merged .lab pre-allocates 128 KB name pool (asm_pass3_lib.tc) to
# avoid grow churn, peaks at ~280 KB, and the next 4 KB alloc then
# OOMed on the 288 KB arena. self_replicate's openocd reset between
# steps gives a fresh kernel arena so the 320 KB make_task succeeds.
# Outside self_replicate (in-pipeline use after parse..asm_pass2
# spawn cycle) the same task may OOM at make_task on a fragmented
# arena — see docs/task/asm_pre_encode.md.
TASK_ARENA_asm_pass3 := 327680
TASK_STACK_asm_pass3 := 16384
