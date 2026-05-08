# Compile compiler/bc2asm.tc + 3 transitive imports on pico2.
# bc2asm imports string_buffer + source_reader + strlib only — no
# ast_node (it walks bytecode, not the AST).
parse < /src/string_buffer.tc > /sd/sb.ast
sigscan < /sd/sb.ast > /sd/sb.th
parse < /src/source_reader.tc > /sd/sr.ast
sigscan < /sd/sr.ast > /sd/sr.th
parse < /src/strlib.tc > /sd/sl.ast
sigscan < /sd/sl.ast > /sd/sl.th
parse < /src/bc2asm.tc > /sd/t.ast
sigscan < /sd/t.ast > /sd/t.th
tcheck --tgth /sd/sb.th --tgt /sd/sb.ast --out /sd/sb.tast
codegen < /sd/sb.tast > /sd/sb.bc
bc2asm < /sd/sb.bc > /sd/sb.s
tcheck --exth /sd/sb.th --tgth /sd/sr.th --tgt /sd/sr.ast --out /sd/sr.tast
codegen < /sd/sr.tast > /sd/sr.bc
bc2asm < /sd/sr.bc > /sd/sr.s
tcheck --exth /sd/sb.th --tgth /sd/sl.th --tgt /sd/sl.ast --out /sd/sl.tast
codegen < /sd/sl.tast > /sd/sl.bc
bc2asm < /sd/sl.bc > /sd/sl.s
cat /sd/sb.th /sd/sr.th /sd/sl.th > /sd/t_imports.th
tcheck --exth /sd/t_imports.th --tgth /sd/t.th --tgt /sd/t.ast --out /sd/t.tast
codegen < /sd/t.tast > /sd/t.bc
bc2asm < /sd/t.bc > /sd/t.s
cat /sd/t.s /sd/sb.s /sd/sr.s /sd/sl.s /prelude_tail.s > /sd/user.s
asm_pass1 /sd/user.s --idx-out /sd/u.idx --text-bin /sd/utx.bin --rodata-bin /sd/uro.bin --data-bin /sd/udt.bin --reloc-out /sd/url
asm_pass2 --link --prelude-idx /prelude.idx --user-idx /sd/u.idx --prelude-text-bin /prelude.text.bin --prelude-rodata-bin /prelude.rodata.bin --prelude-data-bin /prelude.data.bin --prelude-reloc /prelude.reloc --user-text-bin /sd/utx.bin --user-rodata-bin /sd/uro.bin --user-data-bin /sd/udt.bin --user-reloc /sd/url --lab-out /sd/t.lab
asm_pass3 --lab /sd/t.lab --out /sd/bc2asm.bin
md5sum /sd/bc2asm.bin
echo COMPILE_BC2ASM_DONE
