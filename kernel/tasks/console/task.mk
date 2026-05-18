GUEST_TASKS += console
# The Japanese font is .incbin'd into console's binary (jpfont_inc.s),
# read in place via peek8 — it does not live in the arena.
# TASK_EXTRA_S_console (set in the Makefile) links the font wrapper .s.
# Landscape mode allocates a COLS*ROWS i32 codepoint grid (~4.8 KB) for
# software scrolling, so the arena is sized to hold it with headroom.
TASK_ARENA_console := 32768
TASK_STACK_console := 8192
