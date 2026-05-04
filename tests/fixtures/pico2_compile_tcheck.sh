# Compile compiler/tcheck.tc + 4 transitive imports on pico2.
parse < /src/string_buffer.tc > /sd/sb.ast
sigscan < /sd/sb.ast > /sd/sb.th
parse < /src/source_reader.tc > /sd/sr.ast
sigscan < /sd/sr.ast > /sd/sr.th
parse < /src/ast_node.tc > /sd/an.ast
sigscan < /sd/an.ast > /sd/an.th
parse < /src/strlib.tc > /sd/sl.ast
sigscan < /sd/sl.ast > /sd/sl.th
parse < /src/tcheck.tc > /sd/t.ast
sigscan < /sd/t.ast > /sd/t.th
tcheck --tgth /sd/sb.th --tgt /sd/sb.ast --out /sd/sb.tast
codegen < /sd/sb.tast > /sd/sb.bc
bc2asm < /sd/sb.bc > /sd/sb.s
tcheck --exth /sd/sb.th --tgth /sd/sr.th --tgt /sd/sr.ast --out /sd/sr.tast
codegen < /sd/sr.tast > /sd/sr.bc
bc2asm < /sd/sr.bc > /sd/sr.s
tcheck --tgth /sd/an.th --tgt /sd/an.ast --out /sd/an.tast
codegen < /sd/an.tast > /sd/an.bc
bc2asm < /sd/an.bc > /sd/an.s
tcheck --exth /sd/sb.th --tgth /sd/sl.th --tgt /sd/sl.ast --out /sd/sl.tast
codegen < /sd/sl.tast > /sd/sl.bc
bc2asm < /sd/sl.bc > /sd/sl.s
cat /sd/sb.th /sd/sr.th /sd/an.th /sd/sl.th > /sd/t_imports.th
tcheck --exth /sd/t_imports.th --tgth /sd/t.th --tgt /sd/t.ast --out /sd/t.tast
codegen < /sd/t.tast > /sd/t.bc
bc2asm < /sd/t.bc > /sd/t.s
cat /sd/t.s /sd/sb.s /sd/sr.s /sd/an.s /sd/sl.s /prelude_tail.s > /sd/user.s
asm_pass1 --load-idx /prelude.idx --idx-source /prelude.s --prelude-text-bin /prelude.text.bin --prelude-rodata-bin /prelude.rodata.bin --prelude-data-bin /prelude.data.bin --prelude-reloc /prelude.reloc --lab-out /sd/t.lab /sd/user.s
asm_pass2 --lab /sd/t.lab --out /sd/tcheck.bin
md5sum /sd/tcheck.bin
echo COMPILE_TCHECK_DONE
