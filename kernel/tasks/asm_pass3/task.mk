EXTRA_GUEST_TASKS += asm_pass3
# 384 KB needed for self_replicate LINKMODE step 3. The 13-input
# merged .lab loads ~5000 labels into a 64 KB pre-allocated name pool
# (asm_pass3_lib.tc), and the doubling reloc table (offs/kinds/names
# triple at ~12 B/reloc, plus pre_addrs/pre_secs at 8 B/reloc during
# the relocation apply phase) pushes peak to ~306 KB. 320 KB OOMed
# at the next 16 KB allocation. 384 KB gives ~78 KB headroom while
# still fitting the 508 KB pico2 kernel arena (self_replicate's
# openocd reset between steps gives a fresh arena per step).
# Outside self_replicate (in-pipeline use after parse..asm_pass2
# spawn cycle) the same task may OOM at make_task on a fragmented
# arena — see docs/task/asm_pre_encode.md.
TASK_ARENA_asm_pass3 := 393216
TASK_STACK_asm_pass3 := 16384
