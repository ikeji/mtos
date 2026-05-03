EXTRA_GUEST_TASKS += tcheck
# 256 KB needed when tcheck checks parse.tc + transitive imports
# (M7-full): peak measured ~120 KB on hello world but parse.tc has
# nc=1080 / sp=20827 vs hello world's nc=11 / sp=1457, so peak grows
# significantly once 178 fn signatures + 4 transitive .th are loaded.
TASK_ARENA_tcheck := 262144
TASK_STACK_tcheck := 16384
