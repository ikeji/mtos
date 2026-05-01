# pico2 phase 7 bench using --load-idx (prelude pre-linked at kernel
# build, .idx loaded at runtime). Pipeline differs from /pico2_bench.sh
# in that prelude.s is NOT cat'd to user.s for asm_pass1; instead we
# concat user + tail (no prelude) and pass it with --load-idx.
# asm_pass2 still walks the full prelude+user source for encoding.
parse < /hw.tc > /sd/1.ast
sigscan < /sd/1.ast > /sd/1.th
cat /empty_imports.txt /self_open.txt /sd/1.th /wrap_close.txt /sd/1.ast > /sd/1.wr
tcheck < /sd/1.wr > /sd/2.tast
codegen < /sd/2.tast > /sd/3.bc
bc2asm < /sd/3.bc > /sd/4.s
cat /sd/4.s /prelude_tail.s > /sd/u.s
asm_pass1 --load-idx /prelude.idx /sd/u.s /sd/u.strip > /sd/lab.s
cat /sd/lab.s /prelude.s /sd/u.strip /prelude.s /sd/u.strip /prelude.s /sd/u.strip > /sd/p2.in
asm_pass2 < /sd/p2.in > /sd/HW
/sd/HW
