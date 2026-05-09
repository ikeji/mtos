# pico2_link_kernel.sh — link the full pico2 kernel.bin on the device.
#
# Concatenates the host-staged platform/trap/crt0_data .s files plus
# the .s files we already produced under /sd from the per-tool
# compile benches, plus an .incbin wrapper that pulls /sd/disk.img
# straight into .rodata as the embedded mtfs blob. Then asm_pass2 +
# asm_pass3 link it into /sd/kernel.bin and md5 the result.
#
# Prereqs:
#   /sd/runtime.s, /sd/libtc.s,
#   /sd/{kc,bf,bs,ff,mf,tf,pf,vf,ld,kp}.s — produced by the per-stage
#   compile benches (pico2_compile_runtime/libtc/kern/kern2.sh).
#   /sd/disk.img — host build/kernel/disk.img. Copy by mounting the
#   SD card on the host before flashing (see Makefile rule). The
#   .incbin in /src/mtfs_wrap.s reads from this path at link time.
# Pico 2's 4 MB flash can't fit a kernel.uf2 carrying both
# disk-extra.img (4 MB+) and the build/kernel/disk.img copy, so the
# build/kernel/disk.img cannot be staged inside the disk image.
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
cat /sd/pp.s >> /sd/full.s
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

# Walked-source link: asm_pass2 walks /sd/full.s and bakes a
# `src /sd/full.s` line into /sd/full.lab so pass 3 reopens the
# source per emit section (no cat-3x intermediate). LINK_MODE
# would need an asm_pass1 pre-encode pass over the whole image
# (~3.8 MB) which exceeds the 288 KB asm_pass1 task arena.
asm_pass2 --lab-out /sd/full.lab /sd/full.s
asm_pass3 --lab /sd/full.lab --out /sd/kernel.bin

md5sum /sd/kernel.bin
echo LINK_KERNEL_DONE
