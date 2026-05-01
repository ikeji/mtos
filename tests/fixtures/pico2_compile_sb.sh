# Compile compiler/string_buffer.tc front-end + link on the OS.
# string_buffer.tc has no imports so we can wrap with empty_imports
# directly. The default `main` stub in task_crt0.s makes the linked
# binary just exit 0 — useful for measuring the full
# parse → asm_pass2 cost end-to-end on a real compiler source.
parse < /src/string_buffer.tc > /sd/sb.ast
sigscan < /sd/sb.ast > /sd/sb.th
cat /empty_imports.txt /self_open.txt /sd/sb.th /wrap_close.txt /sd/sb.ast > /sd/sb.wr
tcheck < /sd/sb.wr > /sd/sb.tast
codegen < /sd/sb.tast > /sd/sb.bc
bc2asm < /sd/sb.bc > /sd/sb.s
cat /prelude.s /sd/sb.s /prelude_tail.s > /sd/sb.full
asm_pass1 /sd/sb.full /sd/sb.strip > /sd/sb.lab
cat /sd/sb.lab /sd/sb.strip /sd/sb.strip /sd/sb.strip > /sd/sb.p2in
asm_pass2 < /sd/sb.p2in > /sd/sb.bin
echo BENCH_DONE
