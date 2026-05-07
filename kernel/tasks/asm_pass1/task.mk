EXTRA_GUEST_TASKS += asm_pass1
# asm_pass1 unions the lab-build (asm_pass2 mode) and encoder
# (asm_pass3 mode) duties, so it needs roughly asm_pass3's working
# set. Keep at 288 KB — same sweet spot as asm_pass2 / asm_pass3:
# bigger doesn't fit in the fragmented 504 KB kernel arena after
# spawn/exit cycles in the compiler pipeline, smaller OOMs on
# parse.tc-class user.s walks.
TASK_ARENA_asm_pass1 := 294912
TASK_STACK_asm_pass1 := 16384
