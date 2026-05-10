EXTRA_GUEST_TASKS += asm_pass3
# 360 KB. asm_pass3 step 3 (13-input merged .lab → kernel.bin) peaks
# at ~306 KB live ~306 KB after the pad_n fix (commit d2543e5
# eliminated the ~384 KB pre-blob zero-pad allocation). 320 KB had
# only 14 KB headroom and OOMed at the next 16 KB I32Array allocation
# in the reloc table grow. 384 KB caused `make_task` OOM in the
# kernel arena. 360 KB is the sweet spot, matching asm_pass2.
# See docs/problem.md K14.
TASK_ARENA_asm_pass3 := 344064
TASK_STACK_asm_pass3 := 16384
