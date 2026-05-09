# Self-replicate step 2 — per-file LINK_MODE alternative.
# Currently NOT wired into pico2_self_replicate.sh (which uses the
# walked-source `pico2_self_step2.sh` for stability). Kept here as a
# template for when the missing pieces land:
#
#   1. A pico2_compile_platform.sh that builds /sd/platform_pico2.s
#      from kernel/platform_pico2.tc (do_write / do_read / do_uart_*
#      live there now — pico2_compile_kern.sh + kern2.sh don't cover it).
#   2. Cross-checked /src/-staged platform_pico2.s vs /sd/platform_pico2.s
#      so the link uses the TC-compiled symbols, not just the boot asm.
#
# Once those are in place, swap this file's contents into
# pico2_self_step2.sh.
#
# Per-file approach avoids the 288 KB asm_pass1 task arena overflow
# that hit when walking the concatenated /sd/full.s (~3.8 MB) — each
# asm_pass1 invocation peaks at ~50-120 KB on its own small input
# and exits before the next, so the kernel arena's 504 KB only ever
# hosts one asm_pass1 task at a time.
#
# /src/-staged inputs (host-baked, hand-written asm):
#   raw.s              ; raw directive
#   platform_pico2.s   boot + IMAGE_DEF + handwritten asm
#   trap_common.s      trap entry + ecall dispatch
#   crt0_pico2_data.s  BSS + data markers
#
# /sd/-staged inputs (compiled on-device by pico2_compile_runtime.sh
# + pico2_compile_kern.sh + pico2_compile_kern2.sh):
#   runtime.s          compiler/runtime.tc → .s
#   kc.s bf.s bs.s tf.s ff.s mf.s pf.s vf.s ld.s kp.s
#                      kernel module .tc → .s
#   wrap.s             .incbin /sd/dx.img + _mtfs_image_* labels
#                      (boot-time dumper produces these)
#
# Build prelude.s = raw + platform + trap + runtime, prelude_tail.s
# = crt0_data + wrap. Then asm_pass1 each.
cat /src/raw.s /src/platform_pico2.s /src/trap_common.s /sd/runtime.s > /sd/prelude.s
cat /src/crt0_pico2_data.s /sd/wrap.s > /sd/prelude_tail.s
asm_pass1 /sd/prelude.s --no-refs --idx-out /sd/p.idx --text-bin /sd/p.tx --rodata-bin /sd/p.ro --data-bin /sd/p.dt --reloc-out /sd/p.rl
asm_pass1 /sd/kc.s --no-refs --idx-out /sd/kc.idx --text-bin /sd/kc.tx --rodata-bin /sd/kc.ro --data-bin /sd/kc.dt --reloc-out /sd/kc.rl
asm_pass1 /sd/bf.s --no-refs --idx-out /sd/bf.idx --text-bin /sd/bf.tx --rodata-bin /sd/bf.ro --data-bin /sd/bf.dt --reloc-out /sd/bf.rl
asm_pass1 /sd/bs.s --no-refs --idx-out /sd/bs.idx --text-bin /sd/bs.tx --rodata-bin /sd/bs.ro --data-bin /sd/bs.dt --reloc-out /sd/bs.rl
asm_pass1 /sd/tf.s --no-refs --idx-out /sd/tf.idx --text-bin /sd/tf.tx --rodata-bin /sd/tf.ro --data-bin /sd/tf.dt --reloc-out /sd/tf.rl
asm_pass1 /sd/ff.s --no-refs --idx-out /sd/ff.idx --text-bin /sd/ff.tx --rodata-bin /sd/ff.ro --data-bin /sd/ff.dt --reloc-out /sd/ff.rl
asm_pass1 /sd/mf.s --no-refs --idx-out /sd/mf.idx --text-bin /sd/mf.tx --rodata-bin /sd/mf.ro --data-bin /sd/mf.dt --reloc-out /sd/mf.rl
asm_pass1 /sd/pf.s --no-refs --idx-out /sd/pf.idx --text-bin /sd/pf.tx --rodata-bin /sd/pf.ro --data-bin /sd/pf.dt --reloc-out /sd/pf.rl
asm_pass1 /sd/vf.s --no-refs --idx-out /sd/vf.idx --text-bin /sd/vf.tx --rodata-bin /sd/vf.ro --data-bin /sd/vf.dt --reloc-out /sd/vf.rl
asm_pass1 /sd/ld.s --no-refs --idx-out /sd/ld.idx --text-bin /sd/ld.tx --rodata-bin /sd/ld.ro --data-bin /sd/ld.dt --reloc-out /sd/ld.rl
asm_pass1 /sd/kp.s --no-refs --idx-out /sd/kp.idx --text-bin /sd/kp.tx --rodata-bin /sd/kp.ro --data-bin /sd/kp.dt --reloc-out /sd/kp.rl
asm_pass1 /sd/prelude_tail.s --no-refs --idx-out /sd/pt.idx --text-bin /sd/pt.tx --rodata-bin /sd/pt.ro --data-bin /sd/pt.dt --reloc-out /sd/pt.rl
asm_pass2 --link --prelude-idx /sd/p.idx --prelude-text-bin /sd/p.tx --prelude-rodata-bin /sd/p.ro --prelude-data-bin /sd/p.dt --prelude-reloc /sd/p.rl --user-idx /sd/kc.idx --user-text-bin /sd/kc.tx --user-rodata-bin /sd/kc.ro --user-data-bin /sd/kc.dt --user-reloc /sd/kc.rl --add /sd/bf.idx /sd/bf.tx /sd/bf.ro /sd/bf.dt /sd/bf.rl --add /sd/bs.idx /sd/bs.tx /sd/bs.ro /sd/bs.dt /sd/bs.rl --add /sd/tf.idx /sd/tf.tx /sd/tf.ro /sd/tf.dt /sd/tf.rl --add /sd/ff.idx /sd/ff.tx /sd/ff.ro /sd/ff.dt /sd/ff.rl --add /sd/mf.idx /sd/mf.tx /sd/mf.ro /sd/mf.dt /sd/mf.rl --add /sd/pf.idx /sd/pf.tx /sd/pf.ro /sd/pf.dt /sd/pf.rl --add /sd/vf.idx /sd/vf.tx /sd/vf.ro /sd/vf.dt /sd/vf.rl --add /sd/ld.idx /sd/ld.tx /sd/ld.ro /sd/ld.dt /sd/ld.rl --add /sd/kp.idx /sd/kp.tx /sd/kp.ro /sd/kp.dt /sd/kp.rl --add /sd/pt.idx /sd/pt.tx /sd/pt.ro /sd/pt.dt /sd/pt.rl --lab-out /sd/full.lab
md5sum /sd/full.lab
echo SELF_STEP2_DONE
