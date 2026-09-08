GUEST_TASKS += console
# The Japanese font is .incbin'd into console's binary (jpfont_inc.s),
# read in place via peek8 — it does not live in the arena.
# TASK_EXTRA_S_console (set in the Makefile) links the font wrapper .s.
# Landscape mode allocates a COLS*ROWS i32 codepoint grid (~4.8 KB) for
# software scrolling. Text mode (-t, tn20k) additionally copies the ~276 KB
# zenkaku font from the .incbin'd blob into a malloc'd SDRAM buffer that the
# hw text_lcd engine reads, so the arena is sized to hold that with headroom.
TASK_ARENA_console := 393216
TASK_STACK_console := 8192
