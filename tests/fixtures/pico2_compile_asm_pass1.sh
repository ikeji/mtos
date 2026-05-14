# Self-build /sd/asm_pass1.bin on pico2 (Gen2 → Gen3, byte-exact vs
# build/kernel/tasks/asm_pass1.bin). Per-file asm_pass1 pipeline
#
# K12 (2026-05-14) で fatfs に LFN を入れたので、`/sd/asm_pass1.lab` /
# `/sd/asm_pass1.bin` (13 chars) を直接使える。short alias 経由の
# workaround は撤去済。
# matching host kernel/build.sh + compile-gen2.sh.
#
# Imports of asm_pass1.tc (compile-gen2.sh recursive collect order):
#   string_buffer, source_reader, strlib, asm_common  → in_0..in_3
# Then asm_pass1 itself → in_4, task_data.s → in_5.
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

# asm_common.tc imports sb, sr, sl
parse < /src/asm_common.tc > /sd/ac.ast
sigscan < /sd/ac.ast > /sd/ac.th
cat /sd/sb.th /sd/sr.th /sd/sl.th > /sd/ac_imp.th
tcheck --exth /sd/ac_imp.th --tgth /sd/ac.th --tgt /sd/ac.ast --out /sd/ac.tast
codegen < /sd/ac.tast > /sd/ac.bc
bc2asm < /sd/ac.bc > /sd/ac.s

# ===== Phase 2: asm_pass1.tc itself =====
parse < /src/asm_pass1.tc > /sd/asm_pass1.ast
sigscan < /sd/asm_pass1.ast > /sd/asm_pass1.th
cat /sd/sb.th /sd/sr.th /sd/sl.th /sd/ac.th > /sd/asm_pass1_imp.th
tcheck --exth /sd/asm_pass1_imp.th --tgth /sd/asm_pass1.th --tgt /sd/asm_pass1.ast --out /sd/asm_pass1.tast
codegen < /sd/asm_pass1.tast > /sd/asm_pass1.bc
bc2asm < /sd/asm_pass1.bc > /sd/asm_pass1.s

# ===== Phase 3: link =====
cat /src/hdr_asm_pass1.s /src/task_crt0.s /sd/runtime.s > /sd/prelude.s
asm_pass1 /sd/prelude.s --idx-out /sd/prelude.idx --text-bin /sd/prelude.tx --rodata-bin /sd/prelude.ro --data-bin /sd/prelude.dt --reloc-out /sd/prelude.rl
asm_pass1 /sd/sb.s --idx-out /sd/in_0.idx --text-bin /sd/in_0.tx --rodata-bin /sd/in_0.ro --data-bin /sd/in_0.dt --reloc-out /sd/in_0.rl
asm_pass1 /sd/sr.s --idx-out /sd/in_1.idx --text-bin /sd/in_1.tx --rodata-bin /sd/in_1.ro --data-bin /sd/in_1.dt --reloc-out /sd/in_1.rl
asm_pass1 /sd/sl.s --idx-out /sd/in_2.idx --text-bin /sd/in_2.tx --rodata-bin /sd/in_2.ro --data-bin /sd/in_2.dt --reloc-out /sd/in_2.rl
asm_pass1 /sd/ac.s --idx-out /sd/in_3.idx --text-bin /sd/in_3.tx --rodata-bin /sd/in_3.ro --data-bin /sd/in_3.dt --reloc-out /sd/in_3.rl
asm_pass1 /sd/asm_pass1.s --idx-out /sd/in_4.idx --text-bin /sd/in_4.tx --rodata-bin /sd/in_4.ro --data-bin /sd/in_4.dt --reloc-out /sd/in_4.rl
asm_pass1 /src/task_data.s --idx-out /sd/in_5.idx --text-bin /sd/in_5.tx --rodata-bin /sd/in_5.ro --data-bin /sd/in_5.dt --reloc-out /sd/in_5.rl
asm_pass2 --add /sd/prelude.idx --add /sd/in_0.idx --add /sd/in_1.idx --add /sd/in_2.idx --add /sd/in_3.idx --add /sd/in_4.idx --add /sd/in_5.idx --lab-out /sd/asm_pass1.lab
asm_pass3 --lab /sd/asm_pass1.lab --out /sd/asm_pass1.bin
md5sum /sd/asm_pass1.bin

echo COMPILE_ASM_PASS1_DONE
