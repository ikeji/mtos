GUEST_TASKS += sh
# Interactive shell: history (8 entries × StringArray), readdir tab
# completion (dirbuf 4 KB), pipe arg parsing. Real peak well under
# 16 KB. Page-aligned alloc rounds to 24 KB total task ram.
TASK_ARENA_sh := 16384
TASK_STACK_sh := 4096
