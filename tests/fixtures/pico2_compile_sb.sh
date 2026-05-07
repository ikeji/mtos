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
asm_pass1 /sd/sb_user.s --idx-out /sd/u.idx --text-bin /sd/utx.bin --rodata-bin /sd/uro.bin --data-bin /sd/udt.bin --reloc-out /sd/url
asm_pass2 --link --prelude-idx /prelude.idx --user-idx /sd/u.idx --idx-source /prelude.s --prelude-text-bin /prelude.text.bin --prelude-rodata-bin /prelude.rodata.bin --prelude-data-bin /prelude.data.bin --prelude-reloc /prelude.reloc --user-text-bin /sd/utx.bin --user-rodata-bin /sd/uro.bin --user-data-bin /sd/udt.bin --user-reloc /sd/url --lab-out /sd/sb.lab
asm_pass3 --lab /sd/sb.lab --out /sd/sb.bin
wc /sd/sb.bin
echo COMPILE_SB_DONE
