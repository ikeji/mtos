GUEST_TASKS += console
# console loads jpfont.dat (~307 KB PC-98 font) into its arena when
# the Japanese font is present, so the arena must hold it + headroom.
# On qemu virt the kernel arena is 96 MB; ample. (A pico2 build would
# instead peek the font from XIP flash — not yet wired.)
TASK_ARENA_console := 393216
TASK_STACK_console := 8192
