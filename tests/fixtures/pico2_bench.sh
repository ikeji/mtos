# pico2 phase 7 pipeline benchmark — runs each stage of the
# self-hosted compile pipeline against /hw.tc, with intermediates on
# /sd/. msh's set -ex tracing prints [T.TTT] before/after each
# command so we can extract per-stage timings. The same pipeline
# `tests/test_pico2_phase7_sd.sh` drives via a Python prompt-sync
# driver, but here we run it inside the OS so PL011 RX FIFO overflow
# is not a concern (msh reads from a file fd, not UART).
parse < /hw.tc > /sd/1.ast
sigscan < /sd/1.ast > /sd/1.th
cat /empty_imports.txt /self_open.txt /sd/1.th /wrap_close.txt /sd/1.ast > /sd/1.wr
tcheck < /sd/1.wr > /sd/2.tast
codegen < /sd/2.tast > /sd/3.bc
bc2asm < /sd/3.bc > /sd/4.s
cat /prelude.s /sd/4.s /prelude_tail.s > /sd/full.s
asm_pass2 /sd/full.s /sd/strip.s > /sd/lab.s
cat /sd/lab.s /sd/strip.s /sd/strip.s /sd/strip.s > /sd/p2.in
asm_pass3 < /sd/p2.in > /sd/HW
/sd/HW
