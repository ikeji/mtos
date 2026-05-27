# Self-replicate step 1: build /sd/full.s referencing /sd/dx.img
# (the kernel-dumped disk-extra.img). The .incbin in mtfs_wrap_x.s
# points at /sd/dx.img with the host's exact disk-extra.img size.
#
# Module order (kc, pp, bf, bs, ff, mf, tf, pf, rt, df, vf, ld, r3,
# di, km, kp) matches the host kernel build's compile-gen2.sh
# emit order:
#   prelude = raw + platform_pico2.s + trap_common.s + runtime.s
#   in_0  = kc  (kernel_common)
#   in_1  = pp  (platform_pico2, TC-compiled by pico2_compile_platform.sh)
#   in_2  = bf  (block_flash)
#   in_3  = bs  (block_sd)
#   in_4  = ff  (fatfs)
#   in_5  = mf  (mtfs)
#   in_6  = tf  (tmpfs)
#   in_7  = pf  (procfs)
#   in_8  = rt  (rtc)
#   in_9  = df  (devfs)
#   in_10 = vf  (vfs)
#   in_11 = ld  (loader)
#   in_12 = r3  (rtc_ds3231)
#   in_13 = di  (display_ili9488)
#   in_14 = km  (keyboard_matrix)
#   in_15 = kp  (kernel_pico2)
#   tail  = crt0_pico2_data.s + wrap.s
cat /src/raw.s /src/platform_pico2.s /src/trap_common.s /sd/runtime.s /sd/kc.s /sd/pp.s /sd/bf.s /sd/bs.s /sd/ff.s /sd/mf.s /sd/tf.s /sd/pf.s /sd/rt.s /sd/df.s /sd/vf.s /sd/ld.s /sd/r3.s /sd/di.s /sd/km.s /sd/kp.s /src/crt0_pico2_data.s /sd/wrap.s > /sd/full.s
md5sum /sd/full.s
echo SELF_STEP1_DONE
