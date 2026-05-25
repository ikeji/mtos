# Compile compiler/string_buffer.tc with pre-encoded prelude on pico2.
# string_buffer.tc has no imports so tcheck takes only --tgth.
# The default `main` stub in task_crt0.s makes the linked binary
# just exit 0 — this is the M7-minimal stepping stone toward
# compiling parse.tc + transitive imports.
parse < /src/string_buffer.tc > /sd/sb.ast
sigscan < /sd/sb.ast > /sd/sb.th
tcheck --tgth /sd/sb.th --tgt /sd/sb.ast --out /sd/sb.tast
codegen < /sd/sb.tast > /sd/sb.bc
bc2asm < /sd/sb.bc > /sd/sb.s
cat /sd/sb.s /prelude_tail.s > /sd/sb_user.s
asm_pass1 /sd/sb_user.s --idx-out /sd/u.idx --text-bin /sd/u.tx --rodata-bin /sd/u.ro --data-bin /sd/u.dt --reloc-out /sd/u.rl
asm_pass2 --add /prelude.idx --add /sd/u.idx --lab-out /sd/sb.lab
asm_pass3 --lab /sd/sb.lab --out /sd/sb.bin
wc /sd/sb.bin
echo COMPILE_SB_DONE
