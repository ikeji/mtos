EXTRA_GUEST_TASKS += tcheck
# 256 KB needed when tcheck checks parse.tc + transitive imports
# (M7-full): peak measured ~120 KB on hello world but parse.tc has
# nc=1080 / sp=20827 vs hello world's nc=11 / sp=1457, so peak grows
# significantly once 178 fn signatures + 4 transitive .th are loaded.
# 2026-05-15 再計測: worst-case peak 176 KB (bc2asm.tc + 3 imports)。
# 256 KB は 1.5× 余裕。docs/scaling.md の worst-case 表参照。
TASK_ARENA_tcheck := 327680  # 2026-07-07: nodes pool 4096 (bcrun.tc self-host) で peak 287K
TASK_STACK_tcheck := 16384
