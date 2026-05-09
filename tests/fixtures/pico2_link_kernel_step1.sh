# Step 1 of pico2 self-build of kernel.bin: produce /sd/full.s
# (concat of 16 source .s files in compile-gen2.sh order). Run from
# fresh reset; the kernel arena ends up fragmented after this so
# subsequent asm passes need a reboot.
cat /src/raw.s /src/platform_pico2.s /src/trap_common.s /sd/runtime.s /sd/kc.s /sd/pp.s /sd/bf.s /sd/bs.s /sd/ff.s /sd/mf.s /sd/tf.s /sd/pf.s /sd/vf.s /sd/ld.s /sd/kp.s /src/crt0_pico2_data.s /src/mtfs_wrap_nodisk.s > /sd/full.s
md5sum /sd/full.s
echo STEP1_DONE
