# pico2 phase 7 bench using pre-encoded prelude (docs/task/asm_pre_encode.md):
# the prelude is staged at kernel-build time as prelude.{text,rodata,data}.bin
# + prelude.rl, so asm_pass2 emits a v2 .lab with `src raw` lines and
# asm_pass3 memcpies the bins + applies relocs instead of re-tokenising
# the ~12000-line prelude (target: 56 s → ~15 s).
parse < /hw.tc > /sd/1.ast
sigscan < /sd/1.ast > /sd/1.th
tcheck --tgth /sd/1.th --tgt /sd/1.ast --out /sd/2.tast
codegen < /sd/2.tast > /sd/3.bc
bc2asm < /sd/3.bc > /sd/4.s
cat /sd/4.s /prelude_tail.s > /sd/u.s
asm_pass1 /sd/u.s --idx-out /sd/u.idx --text-bin /sd/u.tx --rodata-bin /sd/u.ro --data-bin /sd/u.dt --reloc-out /sd/u.rl
asm_pass2 --add /prelude.idx --add /sd/u.idx --lab-out /sd/full.lab
asm_pass3 --lab /sd/full.lab --out /sd/HW
/sd/HW
