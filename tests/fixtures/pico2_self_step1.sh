# Self-replicate step 1: build /sd/full.s referencing /sd/dx.img
# (the kernel-dumped disk-extra.img). The .incbin in mtfs_wrap_x.s
# points at /sd/dx.img with the host's exact disk-extra.img size.
cat /src/raw.s /src/platform_pico2.s /src/trap_common.s /sd/runtime.s /sd/kc.s /sd/bf.s /sd/bs.s /sd/ff.s /sd/mf.s /sd/tf.s /sd/pf.s /sd/vf.s /sd/ld.s /sd/kp.s /src/crt0_pico2_data.s /sd/wrap.s > /sd/full.s
md5sum /sd/full.s
echo SELF_STEP1_DONE
