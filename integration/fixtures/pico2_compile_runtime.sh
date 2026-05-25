# Compile compiler/runtime.tc on pico2 and produce runtime.s. Output
# is the assembly text, not an executable — runtime.tc has no main and
# its .s gets concatenated into every task's prelude. Compare md5
# against host userland/build/shared/runtime.s to verify byte-exactness.
parse < /src/runtime.tc > /sd/r.ast
sigscan < /sd/r.ast > /sd/r.th
tcheck --tgth /sd/r.th --tgt /sd/r.ast --out /sd/r.tast
codegen < /sd/r.tast > /sd/r.bc
bc2asm < /sd/r.bc > /sd/runtime.s
md5sum /sd/runtime.s
echo COMPILE_RUNTIME_DONE
