EXTRA_GUEST_TASKS += asm_pass1
# asm_pass1 (Phase C/D/E of the 3-binary asm split) drives the
# pre-encode flow: lab build over prelude+tail, then run_pass2 over
# the same combined source for per-section .bin + .reloc, plus the
# single-source user.s mode under LINK_MODE. Memory-wise it's the
# union of asm_pass2 (lab build) + asm_pass3 (encoder + reloc emit),
# so size between asm_pass2's 288 KB and asm_pass3's 320 KB.
TASK_ARENA_asm_pass1 := 327680
TASK_STACK_asm_pass1 := 16384
