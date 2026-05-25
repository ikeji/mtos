# Compile each kernel/*.tc on pico2 → .s, md5 each. We're after
# byte-exactness against host build/intermediate/gen2/kernel_pico2/*.s.
# Order: leaves first (no imports), then dependents.
#
# leaves (no imports): kernel_common, block_flash, block_sd, tmpfs
parse < /src/kernel_common.tc > /sd/kc.ast
sigscan < /sd/kc.ast > /sd/kc.th
tcheck --tgth /sd/kc.th --tgt /sd/kc.ast --out /sd/kc.tast
codegen < /sd/kc.tast > /sd/kc.bc
bc2asm < /sd/kc.bc > /sd/kc.s
md5sum /sd/kc.s
parse < /src/block_flash.tc > /sd/bf.ast
sigscan < /sd/bf.ast > /sd/bf.th
tcheck --tgth /sd/bf.th --tgt /sd/bf.ast --out /sd/bf.tast
codegen < /sd/bf.tast > /sd/bf.bc
bc2asm < /sd/bf.bc > /sd/bf.s
md5sum /sd/bf.s
parse < /src/block_sd.tc > /sd/bs.ast
sigscan < /sd/bs.ast > /sd/bs.th
tcheck --tgth /sd/bs.th --tgt /sd/bs.ast --out /sd/bs.tast
codegen < /sd/bs.tast > /sd/bs.bc
bc2asm < /sd/bs.bc > /sd/bs.s
md5sum /sd/bs.s
parse < /src/tmpfs.tc > /sd/tf.ast
sigscan < /sd/tf.ast > /sd/tf.th
tcheck --tgth /sd/tf.th --tgt /sd/tf.ast --out /sd/tf.tast
codegen < /sd/tf.tast > /sd/tf.bc
bc2asm < /sd/tf.bc > /sd/tf.s
md5sum /sd/tf.s
echo COMPILE_KERN_LEAVES_DONE
