# Self-build /sd/sigscan.bin on pico2 (Gen2 → Gen3, byte-exact vs
# build/kernel/tasks/sigscan.bin) using the per-file asm_pass1 pipeline
# that matches host kernel/build.sh + compile-gen2.sh.
#
# Each .s feeds its own asm_pass1 invocation producing text/rodata/data
# .bin + .reloc + .idx (with spliced ref edges); asm_pass2 merges all
# .idx into one .lab via dead-strip; asm_pass3 emits the final .bin.
#
# Imports of sigscan.tc (compile-gen2.sh recursive collect order):
#   string_buffer, source_reader, ast_node, strlib  → in_0..in_3
# Then sigscan itself → in_4, task_data.s → in_5.
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

# ===== Phase 2: sigscan.tc itself =====
parse < /src/sigscan.tc > /sd/sg.ast
sigscan < /sd/sg.ast > /sd/sg.th
tcheck --exth /sd/sb.th --exth /sd/sr.th --exth /sd/an.th --exth /sd/sl.th --tgth /sd/sg.th --tgt /sd/sg.ast --out /sd/sg.tast
codegen < /sd/sg.tast > /sd/sg.bc
bc2asm < /sd/sg.bc > /sd/sg.s

# ===== Phase 3: link =====
asm_pass1 /src/hdr_sigscan.s --idx-out /sd/hdr.idx --text-bin /sd/hdr.tx --rodata-bin /sd/hdr.ro --data-bin /sd/hdr.dt --reloc-out /sd/hdr.rl
asm_pass1 /src/task_crt0.s --idx-out /sd/crt0.idx --text-bin /sd/crt0.tx --rodata-bin /sd/crt0.ro --data-bin /sd/crt0.dt --reloc-out /sd/crt0.rl
asm_pass1 /sd/runtime.s --idx-out /sd/runtime.idx --text-bin /sd/runtime.tx --rodata-bin /sd/runtime.ro --data-bin /sd/runtime.dt --reloc-out /sd/runtime.rl
asm_pass1 /sd/sb.s --idx-out /sd/in_0.idx --text-bin /sd/in_0.tx --rodata-bin /sd/in_0.ro --data-bin /sd/in_0.dt --reloc-out /sd/in_0.rl
asm_pass1 /sd/sr.s --idx-out /sd/in_1.idx --text-bin /sd/in_1.tx --rodata-bin /sd/in_1.ro --data-bin /sd/in_1.dt --reloc-out /sd/in_1.rl
asm_pass1 /sd/an.s --idx-out /sd/in_2.idx --text-bin /sd/in_2.tx --rodata-bin /sd/in_2.ro --data-bin /sd/in_2.dt --reloc-out /sd/in_2.rl
asm_pass1 /sd/sl.s --idx-out /sd/in_3.idx --text-bin /sd/in_3.tx --rodata-bin /sd/in_3.ro --data-bin /sd/in_3.dt --reloc-out /sd/in_3.rl
asm_pass1 /sd/sg.s --idx-out /sd/in_4.idx --text-bin /sd/in_4.tx --rodata-bin /sd/in_4.ro --data-bin /sd/in_4.dt --reloc-out /sd/in_4.rl
asm_pass1 /src/task_data.s --idx-out /sd/in_5.idx --text-bin /sd/in_5.tx --rodata-bin /sd/in_5.ro --data-bin /sd/in_5.dt --reloc-out /sd/in_5.rl
asm_pass2 --add /sd/hdr.idx --add /sd/crt0.idx --add /sd/runtime.idx --add /sd/in_0.idx --add /sd/in_1.idx --add /sd/in_2.idx --add /sd/in_3.idx --add /sd/in_4.idx --add /sd/in_5.idx --lab-out /sd/sigscan.lab
asm_pass3 --lab /sd/sigscan.lab --out /sd/sigscan.bin
md5sum /sd/sigscan.bin

echo COMPILE_SIGSCAN_DONE
