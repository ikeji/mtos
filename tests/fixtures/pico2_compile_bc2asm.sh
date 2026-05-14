# Self-build /sd/bc2asm.bin on pico2 (Gen2 → Gen3, byte-exact vs
# build/kernel/tasks/bc2asm.bin). Per-file asm_pass1 pipeline matching
# host kernel/build.sh + compile-gen2.sh.
#
# Imports of bc2asm.tc (no ast_node since bc2asm walks bytecode, not AST):
#   string_buffer, source_reader, strlib  → in_0..in_2
# Then bc2asm itself → in_3, task_data.s → in_4.
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

parse < /src/strlib.tc > /sd/sl.ast
sigscan < /sd/sl.ast > /sd/sl.th
tcheck --exth /sd/sb.th --tgth /sd/sl.th --tgt /sd/sl.ast --out /sd/sl.tast
codegen < /sd/sl.tast > /sd/sl.bc
bc2asm < /sd/sl.bc > /sd/sl.s

# ===== Phase 2: bc2asm.tc itself =====
parse < /src/bc2asm.tc > /sd/bf.ast
sigscan < /sd/bf.ast > /sd/bf.th
cat /sd/sb.th /sd/sr.th /sd/sl.th > /sd/bf_imp.th
tcheck --exth /sd/bf_imp.th --tgth /sd/bf.th --tgt /sd/bf.ast --out /sd/bf.tast
codegen < /sd/bf.tast > /sd/bf.bc
bc2asm < /sd/bf.bc > /sd/bf.s

# ===== Phase 3: link =====
cat /src/hdr_bc2asm.s /src/task_crt0.s /sd/runtime.s > /sd/prelude.s
asm_pass1 /sd/prelude.s --idx-out /sd/prelude.idx --text-bin /sd/prelude.tx --rodata-bin /sd/prelude.ro --data-bin /sd/prelude.dt --reloc-out /sd/prelude.rl
asm_pass1 /sd/sb.s --idx-out /sd/in_0.idx --text-bin /sd/in_0.tx --rodata-bin /sd/in_0.ro --data-bin /sd/in_0.dt --reloc-out /sd/in_0.rl
asm_pass1 /sd/sr.s --idx-out /sd/in_1.idx --text-bin /sd/in_1.tx --rodata-bin /sd/in_1.ro --data-bin /sd/in_1.dt --reloc-out /sd/in_1.rl
asm_pass1 /sd/sl.s --idx-out /sd/in_2.idx --text-bin /sd/in_2.tx --rodata-bin /sd/in_2.ro --data-bin /sd/in_2.dt --reloc-out /sd/in_2.rl
asm_pass1 /sd/bf.s --idx-out /sd/in_3.idx --text-bin /sd/in_3.tx --rodata-bin /sd/in_3.ro --data-bin /sd/in_3.dt --reloc-out /sd/in_3.rl
asm_pass1 /src/task_data.s --idx-out /sd/in_4.idx --text-bin /sd/in_4.tx --rodata-bin /sd/in_4.ro --data-bin /sd/in_4.dt --reloc-out /sd/in_4.rl
asm_pass2 --add /sd/prelude.idx --add /sd/in_0.idx --add /sd/in_1.idx --add /sd/in_2.idx --add /sd/in_3.idx --add /sd/in_4.idx --lab-out /sd/bc2asm.lab
asm_pass3 --lab /sd/bc2asm.lab --out /sd/bc2asm.bin
md5sum /sd/bc2asm.bin

echo COMPILE_BC2ASM_DONE
