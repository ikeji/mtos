# mr is also in GUEST_TASKS so the default pico2 disk.img can host
# the SD provisioning flow (`mr -a > /sd/<file>`) without needing the
# larger disk-extra.img. K22 DOOM upload + any future SD-asset
# workflows can stay self-contained on the small flash budget.
GUEST_TASKS       += mr
EXTRA_GUEST_TASKS += mr
TASK_ARENA_mr := 65536
TASK_STACK_mr := 8192
