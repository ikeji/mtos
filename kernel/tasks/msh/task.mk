GUEST_TASKS += msh
# msh is a script driver only — reads command lines, spawns + waits.
# No history / tab completion / readdir. Real peak ~3 KB. Page-aligned
# alloc rounds to 16 KB total task ram.
TASK_ARENA_msh := 8192
TASK_STACK_msh := 4096
