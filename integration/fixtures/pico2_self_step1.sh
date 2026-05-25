# Self-replicate step 1: build /sd/full.s referencing /sd/dx.img
# (the kernel-dumped disk-extra.img). The .incbin in mtfs_wrap_x.s
# points at /sd/dx.img with the host's exact disk-extra.img size.
#
# Module order (kc, pp, bf, bs, ff, mf, tf, pf, vf, ld, kp) matches
# the host kernel build's LINK_MODE asm_pass1 input ordering — that
# ordering is what compile-gen2.sh's collect_imports + the dep-graph
# topological walk produced. /sd/pp.s is the TC-compiled
# platform_pico2.tc (do_uart_*, do_write, do_read); produced by
# pico2_compile_platform.sh.
cat /src/raw.s /src/platform_pico2.s /src/trap_common.s /sd/runtime.s /sd/kc.s /sd/pp.s /sd/bf.s /sd/bs.s /sd/ff.s /sd/mf.s /sd/tf.s /sd/pf.s /sd/vf.s /sd/ld.s /sd/kp.s /src/crt0_pico2_data.s /sd/wrap.s > /sd/full.s
md5sum /sd/full.s
echo SELF_STEP1_DONE
