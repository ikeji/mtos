# Compile kernel/tasks/libtc/libtc.tc on pico2 → libtc.s. No imports.
parse < /src/libtc.tc > /sd/l.ast
sigscan < /sd/l.ast > /sd/l.th
tcheck --tgth /sd/l.th --tgt /sd/l.ast --out /sd/l.tast
codegen < /sd/l.tast > /sd/l.bc
bc2asm < /sd/l.bc > /sd/libtc.s
md5sum /sd/libtc.s
echo COMPILE_LIBTC_DONE
