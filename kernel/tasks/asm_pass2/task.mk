EXTRA_GUEST_TASKS += asm_pass2
# Pre-encode (Step 5+): asm_pass2 buffers the prelude.text.bin into
# memory for reloc patching, so the worst-case allocation grows with
# the prelude size. The current 44 KB prelude + 64 KB initial growable
# buffer + label hash + per-section emit buffer + reloc records puts
# the peak at ~270 KB; bump arena from 200 KB to 320 KB with headroom.
TASK_ARENA_asm_pass2 := 327680
TASK_STACK_asm_pass2 := 16384
