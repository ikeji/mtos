GUEST_TASKS += rm
# 32 KB for `-r` recursion: each level allocates a 4 KB readdir buf +
# StringArray + per-child path strings, freed when the level returns.
# Deep trees (8+ levels) need elbow room for the ancestors' live state.
TASK_ARENA_rm := 32768
TASK_STACK_rm := 8192
