# pico2_link_kernel.sh — link the full pico2 kernel.bin on the device.
#
# Concatenates the host-staged platform/trap/crt0_data .s files plus
# the .s files we already produced under /sd from the per-tool
# compile benches, plus an .incbin wrapper that pulls /sd/disk.img
# straight into .rodata as the embedded mtfs blob. Then asm_pass1 +
# asm_pass2 link it into /sd/kernel.bin and md5 the result.
#
# Prereqs on /sd (produced by earlier benches + a host-side staging):
#   /sd/runtime.s, /sd/libtc.s
#   /sd/kc.s, /sd/bf.s, /sd/bs.s, /sd/ff.s, /sd/mf.s, /sd/tf.s,
#   /sd/pf.s, /sd/vf.s, /sd/ld.s, /sd/kp.s
#   /sd/disk.img  (= host build/kernel/disk.img, copied by user)
#
# Order (matches compile-gen2.sh for kernel_pico2.tc):
#   ; raw
#   platform_pico2.s + trap_common.s              (CRT0)
#   runtime.s                                     (shared)
#   kc.s bf.s bs.s ff.s mf.s tf.s pf.s vf.s ld.s kp.s   (DFS dedup)
#   crt0_pico2_data.s + mtfs_wrapper.s            (CRT0_DATA)
#
# mtfs_wrapper.s embeds /sd/disk.img via .incbin so we don't have to
# upload a 29 MB bin2s expansion of the disk.

# mtfs_wrap.s ships from the Makefile baked with the host disk.img
# size and an .incbin path of /sd/disk.img — user copies disk.img
# to the SD card after `make pico2-kernel-extra`.
echo "; raw" > /sd/full.s
cat /src/platform_pico2.s >> /sd/full.s
cat /src/trap_common.s >> /sd/full.s
cat /sd/runtime.s >> /sd/full.s
cat /sd/kc.s >> /sd/full.s
cat /sd/bf.s >> /sd/full.s
cat /sd/bs.s >> /sd/full.s
cat /sd/ff.s >> /sd/full.s
cat /sd/mf.s >> /sd/full.s
cat /sd/tf.s >> /sd/full.s
cat /sd/pf.s >> /sd/full.s
cat /sd/vf.s >> /sd/full.s
cat /sd/ld.s >> /sd/full.s
cat /sd/kp.s >> /sd/full.s
cat /src/crt0_pico2_data.s >> /sd/full.s
cat /src/mtfs_wrap.s >> /sd/full.s

# Pass 1: build label table.
asm_pass1 < /sd/full.s > /sd/full.lab

# Pass 2: link to raw kernel binary.
cat /sd/full.lab /sd/full.s /sd/full.s /sd/full.s | asm_pass2 > /sd/kernel.bin

md5sum /sd/kernel.bin
echo LINK_KERNEL_DONE
