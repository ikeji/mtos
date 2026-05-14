# Self-build /sd/codegen.bin on pico2 (Gen2 → Gen3, byte-exact vs
# build/kernel/tasks/codegen.bin). Per-file asm_pass1 pipeline matching
# host kernel/build.sh + compile-gen2.sh.
#
# Imports of codegen.tc (compile-gen2.sh recursive collect order):
#   string_buffer, source_reader, ast_node, strlib  → in_0..in_3
# Then codegen itself → in_4, task_data.s → in_5.
#
# Prerequisites: /sd/runtime.s present (REFRESH 0a).

# ===== Phase 1: per-import .ast + .th + .s =====
parse < /src/string_buffer.tc > /sd/sb.ast
sigscan < /sd/sb.ast > /sd/sb.th
tcheck --tgth /sd/sb.th --tgt /sd/sb.ast --out /sd/sb.tast
codegen < /sd/sb.tast > /sd/sb.bc
bc2asm < /sd/sb.bc > /sd/sb.s

parse < /src/source_reader.tc > /sd/sr.ast
sigscan < /sd/sr.ast > /sd/sr.th
tcheck --exth /sd/sb.th --tgth /sd/sr.th --tgt /sd/sr.ast --out /sd/sr.tast
codegen < /sd/sr.tast > /sd/sr.bc
bc2asm < /sd/sr.bc > /sd/sr.s

parse < /src/ast_node.tc > /sd/an.ast
sigscan < /sd/an.ast > /sd/an.th
tcheck --tgth /sd/an.th --tgt /sd/an.ast --out /sd/an.tast
codegen < /sd/an.tast > /sd/an.bc
bc2asm < /sd/an.bc > /sd/an.s

parse < /src/strlib.tc > /sd/sl.ast
sigscan < /sd/sl.ast > /sd/sl.th
tcheck --exth /sd/sb.th --tgth /sd/sl.th --tgt /sd/sl.ast --out /sd/sl.tast
codegen < /sd/sl.tast > /sd/sl.bc
bc2asm < /sd/sl.bc > /sd/sl.s

# ===== Phase 2: codegen.tc itself =====
parse < /src/codegen.tc > /sd/cg.ast
sigscan < /sd/cg.ast > /sd/cg.th
tcheck --exth /sd/sb.th --exth /sd/sr.th --exth /sd/an.th --exth /sd/sl.th --tgth /sd/cg.th --tgt /sd/cg.ast --out /sd/cg.tast
codegen < /sd/cg.tast > /sd/cg.bc
bc2asm < /sd/cg.bc > /sd/cg.s

# ===== Phase 3: link =====
cat /src/hdr_codegen.s /src/task_crt0.s /sd/runtime.s > /sd/prelude.s
asm_pass1 /sd/prelude.s --idx-out /sd/prelude.idx --text-bin /sd/prelude.tx --rodata-bin /sd/prelude.ro --data-bin /sd/prelude.dt --reloc-out /sd/prelude.rl
asm_pass1 /sd/sb.s --idx-out /sd/in_0.idx --text-bin /sd/in_0.tx --rodata-bin /sd/in_0.ro --data-bin /sd/in_0.dt --reloc-out /sd/in_0.rl
asm_pass1 /sd/sr.s --idx-out /sd/in_1.idx --text-bin /sd/in_1.tx --rodata-bin /sd/in_1.ro --data-bin /sd/in_1.dt --reloc-out /sd/in_1.rl
asm_pass1 /sd/an.s --idx-out /sd/in_2.idx --text-bin /sd/in_2.tx --rodata-bin /sd/in_2.ro --data-bin /sd/in_2.dt --reloc-out /sd/in_2.rl
asm_pass1 /sd/sl.s --idx-out /sd/in_3.idx --text-bin /sd/in_3.tx --rodata-bin /sd/in_3.ro --data-bin /sd/in_3.dt --reloc-out /sd/in_3.rl
asm_pass1 /sd/cg.s --idx-out /sd/in_4.idx --text-bin /sd/in_4.tx --rodata-bin /sd/in_4.ro --data-bin /sd/in_4.dt --reloc-out /sd/in_4.rl
asm_pass1 /src/task_data.s --idx-out /sd/in_5.idx --text-bin /sd/in_5.tx --rodata-bin /sd/in_5.ro --data-bin /sd/in_5.dt --reloc-out /sd/in_5.rl
asm_pass2 --add /sd/prelude.idx --add /sd/in_0.idx --add /sd/in_1.idx --add /sd/in_2.idx --add /sd/in_3.idx --add /sd/in_4.idx --add /sd/in_5.idx --lab-out /sd/codegen.lab
asm_pass3 --lab /sd/codegen.lab --out /sd/codegen.bin
md5sum /sd/codegen.bin

echo COMPILE_CODEGEN_DONE
