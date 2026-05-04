# Compile kernel modules with imports. Reuses /sd/kc.th, /sd/bf.th,
# /sd/bs.th, /sd/tf.th from pico2_compile_kern.sh — those need to
# already exist on the SD when this runs (or run kern.sh first).
# Order: leaves' importers, then progressively top.
#
# fatfs, mtfs, procfs each import only kernel_common
parse < /src/fatfs.tc > /sd/ff.ast
sigscan < /sd/ff.ast > /sd/ff.th
tcheck --exth /sd/kc.th --tgth /sd/ff.th --tgt /sd/ff.ast --out /sd/ff.tast
codegen < /sd/ff.tast > /sd/ff.bc
bc2asm < /sd/ff.bc > /sd/ff.s
md5sum /sd/ff.s
parse < /src/mtfs.tc > /sd/mf.ast
sigscan < /sd/mf.ast > /sd/mf.th
tcheck --exth /sd/kc.th --tgth /sd/mf.th --tgt /sd/mf.ast --out /sd/mf.tast
codegen < /sd/mf.tast > /sd/mf.bc
bc2asm < /sd/mf.bc > /sd/mf.s
md5sum /sd/mf.s
parse < /src/procfs.tc > /sd/pf.ast
sigscan < /sd/pf.ast > /sd/pf.th
tcheck --exth /sd/kc.th --tgth /sd/pf.th --tgt /sd/pf.ast --out /sd/pf.tast
codegen < /sd/pf.tast > /sd/pf.bc
bc2asm < /sd/pf.bc > /sd/pf.s
md5sum /sd/pf.s
# vfs: imports mtfs + tmpfs + procfs + fatfs + kernel_common
cat /sd/mf.th /sd/tf.th /sd/pf.th /sd/ff.th /sd/kc.th > /sd/vfs_imp.th
parse < /src/vfs.tc > /sd/vf.ast
sigscan < /sd/vf.ast > /sd/vf.th
tcheck --exth /sd/vfs_imp.th --tgth /sd/vf.th --tgt /sd/vf.ast --out /sd/vf.tast
codegen < /sd/vf.tast > /sd/vf.bc
bc2asm < /sd/vf.bc > /sd/vf.s
md5sum /sd/vf.s
# loader: imports vfs + kernel_common
cat /sd/vf.th /sd/kc.th > /sd/ldr_imp.th
parse < /src/loader.tc > /sd/ld.ast
sigscan < /sd/ld.ast > /sd/ld.th
tcheck --exth /sd/ldr_imp.th --tgth /sd/ld.th --tgt /sd/ld.ast --out /sd/ld.tast
codegen < /sd/ld.tast > /sd/ld.bc
bc2asm < /sd/ld.bc > /sd/ld.s
md5sum /sd/ld.s
# kernel_pico2: imports kernel_common + block_flash + block_sd + fatfs + mtfs + vfs + loader
cat /sd/kc.th /sd/bf.th /sd/bs.th /sd/ff.th /sd/mf.th /sd/vf.th /sd/ld.th > /sd/kp_imp.th
parse < /src/kernel_pico2.tc > /sd/kp.ast
sigscan < /sd/kp.ast > /sd/kp.th
tcheck --exth /sd/kp_imp.th --tgth /sd/kp.th --tgt /sd/kp.ast --out /sd/kp.tast
codegen < /sd/kp.tast > /sd/kp.bc
bc2asm < /sd/kp.bc > /sd/kp.s
md5sum /sd/kp.s
echo COMPILE_KERN2_DONE
