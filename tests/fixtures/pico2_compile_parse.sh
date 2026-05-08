# Compile compiler/parse.tc + 3 transitive imports on pico2 (M7-full).
# Each .tc gets its own parse → sigscan → tcheck → codegen → bc2asm
# pipeline producing a .s, then all .s files plus prelude_tail.s feed
# into asm_pass2/asm_pass3 for final link. The default `main` stub
# in task_crt0.s keeps the linked binary just exit 0 — the goal here
# is to prove the OS-side compile pipeline can handle a multi-file
# source with imports and produce a runnable binary on real hardware.
#
# Step 1: per-import .th (sigscan extended format)
parse < /src/string_buffer.tc > /sd/sb.ast
sigscan < /sd/sb.ast > /sd/sb.th
parse < /src/source_reader.tc > /sd/sr.ast
sigscan < /sd/sr.ast > /sd/sr.th
parse < /src/strlib.tc > /sd/sl.ast
sigscan < /sd/sl.ast > /sd/sl.th
# Step 2: parse.tc
parse < /src/parse.tc > /sd/p.ast
sigscan < /sd/p.ast > /sd/p.th
# Step 3: per-tc tcheck → codegen → bc2asm. string_buffer has no imports;
# source_reader and strlib import string_buffer; parse imports all 3.
tcheck --tgth /sd/sb.th --tgt /sd/sb.ast --out /sd/sb.tast
codegen < /sd/sb.tast > /sd/sb.bc
bc2asm < /sd/sb.bc > /sd/sb.s
tcheck --exth /sd/sb.th --tgth /sd/sr.th --tgt /sd/sr.ast --out /sd/sr.tast
codegen < /sd/sr.tast > /sd/sr.bc
bc2asm < /sd/sr.bc > /sd/sr.s
tcheck --exth /sd/sb.th --tgth /sd/sl.th --tgt /sd/sl.ast --out /sd/sl.tast
codegen < /sd/sl.tast > /sd/sl.bc
bc2asm < /sd/sl.bc > /sd/sl.s
cat /sd/sb.th /sd/sr.th /sd/sl.th > /sd/p_imports.th
tcheck --exth /sd/p_imports.th --tgth /sd/p.th --tgt /sd/p.ast --out /sd/p.tast
codegen < /sd/p.tast > /sd/p.bc
bc2asm < /sd/p.bc > /sd/p.s
# Step 4: link — concat all .s + prelude_tail
cat /sd/p.s /sd/sb.s /sd/sr.s /sd/sl.s /prelude_tail.s > /sd/user.s
asm_pass1 /sd/user.s --idx-out /sd/u.idx --text-bin /sd/utx.bin --rodata-bin /sd/uro.bin --data-bin /sd/udt.bin --reloc-out /sd/url
asm_pass2 --link --prelude-idx /prelude.idx --user-idx /sd/u.idx --prelude-text-bin /prelude.text.bin --prelude-rodata-bin /prelude.rodata.bin --prelude-data-bin /prelude.data.bin --prelude-reloc /prelude.reloc --user-text-bin /sd/utx.bin --user-rodata-bin /sd/uro.bin --user-data-bin /sd/udt.bin --user-reloc /sd/url --lab-out /sd/p.lab
asm_pass3 --lab /sd/p.lab --out /sd/parse.bin
wc /sd/parse.bin
echo COMPILE_PARSE_DONE
