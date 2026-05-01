# pico2 phase 7 bench using --load-idx + multi-source asm_pass2 +
# tcheck/asm_pass1/asm_pass2 file-args. The pipeline is now end-to-
# end file-driven — no stdin/stdout pipe between asm_pass1 and
# asm_pass2 (both take explicit --lab / --out paths).
parse < /hw.tc > /sd/1.ast
sigscan < /sd/1.ast > /sd/1.th
tcheck --tgth /sd/1.th --tgt /sd/1.ast --out /sd/2.tast
codegen < /sd/2.tast > /sd/3.bc
bc2asm < /sd/3.bc > /sd/4.s
cat /sd/4.s /prelude_tail.s > /sd/u.s
asm_pass1 --load-idx /prelude.idx --idx-source /prelude.s --lab-out /sd/lab.s /sd/u.s /sd/u.strip
asm_pass2 --lab /sd/lab.s --out /sd/HW
/sd/HW
