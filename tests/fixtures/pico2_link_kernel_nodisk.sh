# pico2_link_kernel_nodisk.sh — link the kernel.bin on the device,
# but with an empty mtfs blob in place of the embedded disk image.
# Smoke test for the asm pipeline at full kernel size; result is not
# bootable (no disk) but should match the host nodisk reference
# (md5 f21e5f2e018ee4102040de06f58fd216).
#
# Wrapper files are pre-staged under /src/ by the Makefile so this
# script does no on-device file authoring (which leaks kernel arena
# across many spawn cycles and trips spawn failed by entry ~10).

cat /src/raw.s /src/platform_pico2.s /src/trap_common.s /sd/runtime.s /sd/kc.s /sd/bf.s /sd/bs.s /sd/ff.s /sd/mf.s /sd/tf.s /sd/pf.s /sd/vf.s /sd/ld.s /sd/kp.s /src/crt0_pico2_data.s /src/mtfs_wrap_nodisk.s > /sd/full.s

asm_pass1 < /sd/full.s > /sd/full.lab

cat /sd/full.lab /sd/full.s /sd/full.s /sd/full.s > /sd/p2_in.s
asm_pass2 < /sd/p2_in.s > /sd/kernel_nodisk.bin

md5sum /sd/kernel_nodisk.bin
echo LINK_KERNEL_NODISK_DONE
