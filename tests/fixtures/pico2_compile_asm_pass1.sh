# Compile compiler/asm_pass2.tc + asm_common + 3 base imports on pico2.
# asm_common is itself ~3000 lines and pulls in string_buffer +
# source_reader + strlib, so we end up tcheck'ing a very large chain.
parse < /src/string_buffer.tc > /sd/sb.ast
sigscan < /sd/sb.ast > /sd/sb.th
parse < /src/source_reader.tc > /sd/sr.ast
sigscan < /sd/sr.ast > /sd/sr.th
parse < /src/strlib.tc > /sd/sl.ast
sigscan < /sd/sl.ast > /sd/sl.th
parse < /src/asm_common.tc > /sd/ac.ast
sigscan < /sd/ac.ast > /sd/ac.th
parse < /src/asm_pass2.tc > /sd/t.ast
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
cat /sd/sb.th /sd/sr.th /sd/sl.th > /sd/ac_imp.th
tcheck --exth /sd/ac_imp.th --tgth /sd/ac.th --tgt /sd/ac.ast --out /sd/ac.tast
codegen < /sd/ac.tast > /sd/ac.bc
bc2asm < /sd/ac.bc > /sd/ac.s
cat /sd/sb.th /sd/sr.th /sd/sl.th /sd/ac.th > /sd/t_imports.th
tcheck --exth /sd/t_imports.th --tgth /sd/t.th --tgt /sd/t.ast --out /sd/t.tast
codegen < /sd/t.tast > /sd/t.bc
bc2asm < /sd/t.bc > /sd/t.s
cat /sd/t.s /sd/ac.s /sd/sb.s /sd/sr.s /sd/sl.s /prelude_tail.s > /sd/user.s
asm_pass1 /sd/user.s --idx-out /sd/u.idx --text-bin /sd/utx.bin --rodata-bin /sd/uro.bin --data-bin /sd/udt.bin --reloc-out /sd/url
asm_pass2 --link --prelude-idx /prelude.idx --user-idx /sd/u.idx --idx-source /prelude.s --prelude-text-bin /prelude.text.bin --prelude-rodata-bin /prelude.rodata.bin --prelude-data-bin /prelude.data.bin --prelude-reloc /prelude.reloc --user-text-bin /sd/utx.bin --user-rodata-bin /sd/uro.bin --user-data-bin /sd/udt.bin --user-reloc /sd/url --lab-out /sd/t.lab
asm_pass3 --lab /sd/t.lab --out /sd/ap1.bin
md5sum /sd/ap1.bin
echo COMPILE_ASM_PASS1_DONE
