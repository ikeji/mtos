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

# Walked-source link: asm_pass2 walks /sd/full.s and bakes a
# `src /sd/full.s` line into /sd/full.lab so pass 3 reopens the
# source per emit section. LINK_MODE would need an asm_pass1
# pre-encode pass over the whole image (~3.8 MB) which exceeds
# the 288 KB asm_pass1 task arena.
asm_pass2 --lab-out /sd/full.lab /sd/full.s
asm_pass3 --lab /sd/full.lab --out /sd/kernel_nodisk.bin

md5sum /sd/kernel_nodisk.bin
echo LINK_KERNEL_NODISK_DONE
