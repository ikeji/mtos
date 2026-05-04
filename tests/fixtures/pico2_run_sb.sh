# Run /sd/sb.bin (OS-compiled string_buffer.tc) — has no main of its
# own, so the default `main` stub from task_crt0.s makes it exit 0.
# This is a smoke test: if /sd/sb.bin spawns and exits cleanly, the
# OS-side compile produced a runnable binary; if it hangs or traps,
# something in the parse..asm_pass2 chain is broken.
/sd/sb.bin
echo RUN_SB_DONE
