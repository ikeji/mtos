# Compile compiler/parse.tc with 3 transitive imports on pico2 (M7-full).
# parse.tc imports string_buffer + source_reader + strlib (which itself
# only imports string_buffer). For each import we run parse + sigscan
# to produce a .th, then cat them as the --exth argument to tcheck.
# The default `main` stub in task_crt0.s makes the linked binary just
# exit 0 — the goal here is to prove the OS-side compile pipeline can
# handle a multi-file source with imports.
#
# imports first
parse < /src/string_buffer.tc > /sd/sb.ast
sigscan < /sd/sb.ast > /sd/sb.th
parse < /src/source_reader.tc > /sd/sr.ast
sigscan < /sd/sr.ast > /sd/sr.th
parse < /src/strlib.tc > /sd/sl.ast
sigscan < /sd/sl.ast > /sd/sl.th
cat /sd/sb.th /sd/sr.th /sd/sl.th > /sd/imports.th
# parse.tc itself
parse < /src/parse.tc > /sd/p.ast
sigscan < /sd/p.ast > /sd/p.th
tcheck --exth /sd/imports.th --tgth /sd/p.th --tgt /sd/p.ast --out /sd/p.tast
codegen < /sd/p.tast > /sd/p.bc
bc2asm < /sd/p.bc > /sd/p.s
cat /sd/p.s /prelude_tail.s > /sd/p_user.s
# No strip-out arg → asm_pass1 skips ref collection + dead-strip BFS,
# saves ~88 KB peak. asm_pass2 reads /sd/p_user.s directly via the
# `src` line in /sd/p.lab (asm_set_src_path2 falls back to the user
# source when strip is absent).
asm_pass1 --load-idx /prelude.idx --idx-source /prelude.s --prelude-text-bin /prelude.text.bin --prelude-rodata-bin /prelude.rodata.bin --prelude-data-bin /prelude.data.bin --prelude-reloc /prelude.reloc --lab-out /sd/p.lab /sd/p_user.s
asm_pass2 --lab /sd/p.lab --out /sd/parse.bin
wc /sd/parse.bin
echo COMPILE_PARSE_DONE
