# Self-build the compiler binaries (Gen3) on pico2 and md5sum each
# /sd/<name>.bin so the orchestrator can compare against the host
# build (userland/build/tasks/<name>.bin). End goal: prove Pico 2 can
# **byte-exact rebuild its own compiler binaries**, completing the
# Gen2 → Gen3 self-host loop.
#
# Pipeline per task (matches host compile-gen2.sh + kernel/build.sh):
#   1. parse / sigscan each .tc → .ast + .th
#   2. tcheck per file using accumulated .th (imports chain)
#   3. codegen → .bc, bc2asm → .s
#   4. asm_pass1 prelude (custom per-task arena/stack header) → prelude.*
#   5. asm_pass1 each user .s → in_N.* (tags match host: imports in
#      source order, then main, then prelude_tail)
#   6. asm_pass2 link with --add in correct order → /sd/<name>.lab
#   7. asm_pass3 /sd/<name>.lab → /sd/<name>.bin
#   8. md5sum /sd/<name>.bin
#
# All intermediates land in /sd. Shared per-import .s files (sb / sr /
# sl / an / ac / asm_pass2_lib / asm_pass3_lib) are computed once at
# the top. runtime.s / libtc.s came from REFRESH Step 0a/0b earlier.

# ===== Phase 1: per-import .ast + .th + .s for the libraries
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

parse < /src/ast_node.tc > /sd/an.ast
sigscan < /sd/an.ast > /sd/an.th
tcheck --tgth /sd/an.th --tgt /sd/an.ast --out /sd/an.tast
codegen < /sd/an.tast > /sd/an.bc
bc2asm < /sd/an.bc > /sd/an.s

# asm_common imports sb + sr + sl + an
parse < /src/asm_common.tc > /sd/ac.ast
sigscan < /sd/ac.ast > /sd/ac.th
tcheck --exth /sd/sb.th --exth /sd/sr.th --exth /sd/sl.th --exth /sd/an.th --tgth /sd/ac.th --tgt /sd/ac.ast --out /sd/ac.tast
codegen < /sd/ac.tast > /sd/ac.bc
bc2asm < /sd/ac.bc > /sd/ac.s

# Per-host parse intermediate layout the .lab embeds (basename only):
#   prelude.{tx,ro,dt,rl}  ← `; raw` + hdr + task_crt0.s + runtime.s
#   in_0  ← string_buffer.s
#   in_1  ← source_reader.s
#   in_2  ← strlib.s
#   in_3  ← parse.s
#   in_4  ← task_data.s

# ===== parse.bin (imports: sb, sr, sl) =====
parse < /src/parse.tc > /sd/p.ast
sigscan < /sd/p.ast > /sd/p.th
tcheck --exth /sd/sb.th --exth /sd/sr.th --exth /sd/sl.th --tgth /sd/p.th --tgt /sd/p.ast --out /sd/p.tast
codegen < /sd/p.tast > /sd/p.bc
bc2asm < /sd/p.bc > /sd/p.s

asm_pass1 /src/hdr_parse.s --idx-out /sd/hdr.idx --text-bin /sd/hdr.tx --rodata-bin /sd/hdr.ro --data-bin /sd/hdr.dt --reloc-out /sd/hdr.rl
asm_pass1 /src/task_crt0.s --idx-out /sd/crt0.idx --text-bin /sd/crt0.tx --rodata-bin /sd/crt0.ro --data-bin /sd/crt0.dt --reloc-out /sd/crt0.rl
asm_pass1 /sd/runtime.s --idx-out /sd/runtime.idx --text-bin /sd/runtime.tx --rodata-bin /sd/runtime.ro --data-bin /sd/runtime.dt --reloc-out /sd/runtime.rl
asm_pass1 /sd/sb.s --idx-out /sd/in_0.idx --text-bin /sd/in_0.tx --rodata-bin /sd/in_0.ro --data-bin /sd/in_0.dt --reloc-out /sd/in_0.rl
asm_pass1 /sd/sr.s --idx-out /sd/in_1.idx --text-bin /sd/in_1.tx --rodata-bin /sd/in_1.ro --data-bin /sd/in_1.dt --reloc-out /sd/in_1.rl
asm_pass1 /sd/sl.s --idx-out /sd/in_2.idx --text-bin /sd/in_2.tx --rodata-bin /sd/in_2.ro --data-bin /sd/in_2.dt --reloc-out /sd/in_2.rl
asm_pass1 /sd/p.s --idx-out /sd/in_3.idx --text-bin /sd/in_3.tx --rodata-bin /sd/in_3.ro --data-bin /sd/in_3.dt --reloc-out /sd/in_3.rl
asm_pass1 /src/task_data.s --idx-out /sd/in_4.idx --text-bin /sd/in_4.tx --rodata-bin /sd/in_4.ro --data-bin /sd/in_4.dt --reloc-out /sd/in_4.rl
asm_pass2 --add /sd/hdr.idx --add /sd/crt0.idx --add /sd/runtime.idx --add /sd/in_0.idx --add /sd/in_1.idx --add /sd/in_2.idx --add /sd/in_3.idx --add /sd/in_4.idx --lab-out /sd/parse.lab
asm_pass3 --lab /sd/parse.lab --out /sd/parse.bin
md5sum /sd/parse.bin

echo COMPILE_PARSE_DONE
