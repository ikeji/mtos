# Step 1 of pico2 self-build of full kernel.bin (disk variant):
# build /sd/full.s with .incbin pointing to /sd/disk.img.
# Prereq: /sd/disk.img == build/kernel/disk.img (host-side cp).
#
# /src/mtfs_wrap.s already has the .incbin baked at make time.
cat /src/raw.s /src/platform_pico2.s /src/trap_common.s /sd/runtime.s /sd/kc.s /sd/pp.s /sd/bf.s /sd/bs.s /sd/ff.s /sd/mf.s /sd/tf.s /sd/pf.s /sd/vf.s /sd/ld.s /sd/kp.s /src/crt0_pico2_data.s /src/mtfs_wrap.s > /sd/full.s
md5sum /sd/full.s
echo DISK_STEP1_DONE
