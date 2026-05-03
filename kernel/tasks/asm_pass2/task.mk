EXTRA_GUEST_TASKS += asm_pass2
# 288 KB fits asm_pass2's measured ~280 KB peak with headroom while leaving
# the kernel a contiguous block under the 504 KB arena after fragmentation
# from the parse..asm_pass1 spawn cycle. 320 KB still OOMs even with the
# 504 KB kernel arena because the largest free chunk after asm_pass1 exits
# is only ~280-300 KB. See docs/task/asm_pre_encode.md.
TASK_ARENA_asm_pass2 := 294912
TASK_STACK_asm_pass2 := 16384
