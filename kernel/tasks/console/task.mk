GUEST_TASKS += console
# The Japanese font is .incbin'd into console's binary (jpfont_inc.s),
# read in place via peek8 — it does not live in the arena, so the
# arena stays small. TASK_EXTRA_S_console (set in the Makefile) links
# the font wrapper .s.
TASK_ARENA_console := 16384
TASK_STACK_console := 8192
