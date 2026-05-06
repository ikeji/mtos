EXTRA_GUEST_TASKS += asm_pass2
# 288 KB sweet spot. /hw.tc-sized user.s peaks at 195 KB; parse.tc
# without --no-strip / no ref collection peaks ~165 KB (M7-full path).
# 320 KB OOMs at kernel-side make_task because the kernel's fragmented
# 508 KB arena can't carve a contiguous 320 KB chunk after the
# parse..bc2asm spawn cycle (same pattern as asm_pass3).
TASK_ARENA_asm_pass2 := 294912
TASK_STACK_asm_pass2 := 16384
