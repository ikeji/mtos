EXTRA_GUEST_TASKS += asm_pass1
# 288 KB. Hello World peak 224 KB (label name pool 128 KB + label table
# ~50 KB + line table 50 KB + buffers). Mostly fixed-size, doesn't grow
# much with input size. See docs/scaling.md Q5.
TASK_ARENA_asm_pass1 := 294912
TASK_STACK_asm_pass1 := 16384
