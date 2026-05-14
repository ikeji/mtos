EXTRA_GUEST_TASKS += asm_pass2
# 384 KB. asm_pass2 8-input link (compiler self-build) hits OOM at
# 344 KB: g_ds_edges (dead-strip edge table) doubles 8K → 16K entries
# = needs +64 KB during which live = 315 KB; max contig free was
# 20 KB. Bumping to 384 KB gives an extra 49 KB at the arena top
# (one contig large_alloc free block) so the doubling fits.
# K14 (2026-05-11) noted 384 KB caused make_task OOM in the kernel
# arena when kernel live state was ~122 KB. Post-K16/K17 (auto-close
# fds + 1-boot self_replicate) kernel live runs lower so 384 KB now
# fits — empirically verified by compiler self-build.
TASK_ARENA_asm_pass2 := 380928
TASK_STACK_asm_pass2 := 16384
