EXTRA_GUEST_TASKS += asm_pass2
# Pre-encode (Step 4+): asm_pass2 buffers the prelude.text.bin in
# memory while applying reloc patches. The OOM size pattern matches
# arena_size+4 which suggests the growable buffer's `new_cap < needed
# → new_cap = needed` branch is firing for a needed of arena_size.
# Bump to 458752 (448 KB) — at 480 KB pico2 kernel arena this leaves
# only ~30 KB for sh/msh + kernel state, but the bench runs with msh
# alone so we still fit.
TASK_ARENA_asm_pass2 := 458752
TASK_STACK_asm_pass2 := 16384
