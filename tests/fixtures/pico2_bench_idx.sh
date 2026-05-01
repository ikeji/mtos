# pico2 phase 7 bench using --load-idx + multi-source asm_pass2.
# asm_pass1 emits `src <path>` lines into the .lab so asm_pass2 opens
# /prelude.s (XIP flash) and /sd/u.strip directly per section pass —
# no cat-p2 concat, no /sd/p2.in round-trip.
parse < /hw.tc > /sd/1.ast
sigscan < /sd/1.ast > /sd/1.th
cat /empty_imports.txt /self_open.txt /sd/1.th /wrap_close.txt /sd/1.ast > /sd/1.wr
tcheck < /sd/1.wr > /sd/2.tast
codegen < /sd/2.tast > /sd/3.bc
bc2asm < /sd/3.bc > /sd/4.s
cat /sd/4.s /prelude_tail.s > /sd/u.s
asm_pass1 --load-idx /prelude.idx --idx-source /prelude.s /sd/u.s /sd/u.strip > /sd/lab.s
asm_pass2 < /sd/lab.s > /sd/HW
/sd/HW
