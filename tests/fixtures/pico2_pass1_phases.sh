# asm_pass1 phase breakdown — runs the same /sd/full.s through three
# invocation modes so the msh trace lets us subtract them and see how
# much time is in the original 1-pass scan, the new 2nd ref pass, and
# the Phase 5 strip walk.
#
# Pre-req: /sd/full.s already exists (build it first via the regular
# pipeline). Set up by sourcing pico2_bench.sh up to bc2asm + cat-link.
parse < /hw.tc > /sd/1.ast
sigscan < /sd/1.ast > /sd/1.th
cat /empty_imports.txt /self_open.txt /sd/1.th /wrap_close.txt /sd/1.ast > /sd/1.wr
tcheck < /sd/1.wr > /sd/2.tast
codegen < /sd/2.tast > /sd/3.bc
bc2asm < /sd/3.bc > /sd/4.s
cat /prelude.s /sd/4.s /prelude_tail.s > /sd/full.s
asm_pass1 < /sd/full.s > /sd/lab.s.A
asm_pass1 /sd/full.s > /sd/lab.s.B
asm_pass1 /sd/full.s /sd/strip.s > /sd/lab.s.C
