# Self-replicate step 2 — per-file LINK_MODE.
#
# Replaces walked-source `asm_pass2 --lab-out /sd/full.lab /sd/full.s`
# with the same pipeline shape compile-gen2.sh uses on the host:
# pre-encode each input with asm_pass1 (small task arena footprint)
# then merge with asm_pass2 --link.
#
# Order MUST match host LINK_MODE input order from compile-gen2.sh
# (build/intermediate/gen2/kernel_pico2/in_*.idx by src_bytes):
#   prelude = ; raw + platform_pico2.s + trap_common.s + runtime.s
#   in_0  = kc.s (kernel_common, the .tc named on the cmd line)
#   in_1  = pp.s (platform_pico2, TC-compiled by pico2_compile_platform.sh)
#   in_2  = bf.s (block_flash)
#   in_3  = bs.s (block_sd)
#   in_4  = ff.s (fatfs)
#   in_5  = mf.s (mtfs)
#   in_6  = tf.s (tmpfs)
#   in_7  = pf.s (procfs)
#   in_8  = vf.s (vfs)
#   in_9  = ld.s (loader)
#   in_10 = kp.s (kernel_pico2)
#   in_11 = pt.s (prelude_tail = crt0_pico2_data.s + wrap.s)
#
# Per-file approach avoids the 288 KB asm_pass1 task arena overflow
# that hit when walking the concatenated /sd/full.s — each asm_pass1
# invocation peaks at ~50-150 KB on its own small input and exits
# before the next, so the kernel arena's 504 KB only ever hosts one
# asm_pass1 task at a time.

cat /src/raw.s /src/platform_pico2.s /src/trap_common.s /sd/runtime.s > /sd/prelude.s
cat /src/crt0_pico2_data.s /sd/wrap.s > /sd/pt.s
asm_pass1 /sd/prelude.s --idx-out /sd/p.idx --text-bin /sd/p.tx --rodata-bin /sd/p.ro --data-bin /sd/p.dt --reloc-out /sd/p.rl
asm_pass1 /sd/kc.s --idx-out /sd/kc.idx --text-bin /sd/kc.tx --rodata-bin /sd/kc.ro --data-bin /sd/kc.dt --reloc-out /sd/kc.rl
asm_pass1 /sd/pp.s --idx-out /sd/pp.idx --text-bin /sd/pp.tx --rodata-bin /sd/pp.ro --data-bin /sd/pp.dt --reloc-out /sd/pp.rl
asm_pass1 /sd/bf.s --idx-out /sd/bf.idx --text-bin /sd/bf.tx --rodata-bin /sd/bf.ro --data-bin /sd/bf.dt --reloc-out /sd/bf.rl
asm_pass1 /sd/bs.s --idx-out /sd/bs.idx --text-bin /sd/bs.tx --rodata-bin /sd/bs.ro --data-bin /sd/bs.dt --reloc-out /sd/bs.rl
asm_pass1 /sd/ff.s --idx-out /sd/ff.idx --text-bin /sd/ff.tx --rodata-bin /sd/ff.ro --data-bin /sd/ff.dt --reloc-out /sd/ff.rl
asm_pass1 /sd/mf.s --idx-out /sd/mf.idx --text-bin /sd/mf.tx --rodata-bin /sd/mf.ro --data-bin /sd/mf.dt --reloc-out /sd/mf.rl
asm_pass1 /sd/tf.s --idx-out /sd/tf.idx --text-bin /sd/tf.tx --rodata-bin /sd/tf.ro --data-bin /sd/tf.dt --reloc-out /sd/tf.rl
asm_pass1 /sd/pf.s --idx-out /sd/pf.idx --text-bin /sd/pf.tx --rodata-bin /sd/pf.ro --data-bin /sd/pf.dt --reloc-out /sd/pf.rl
asm_pass1 /sd/vf.s --idx-out /sd/vf.idx --text-bin /sd/vf.tx --rodata-bin /sd/vf.ro --data-bin /sd/vf.dt --reloc-out /sd/vf.rl
asm_pass1 /sd/ld.s --idx-out /sd/ld.idx --text-bin /sd/ld.tx --rodata-bin /sd/ld.ro --data-bin /sd/ld.dt --reloc-out /sd/ld.rl
asm_pass1 /sd/kp.s --idx-out /sd/kp.idx --text-bin /sd/kp.tx --rodata-bin /sd/kp.ro --data-bin /sd/kp.dt --reloc-out /sd/kp.rl
asm_pass1 /sd/pt.s --idx-out /sd/pt.idx --text-bin /sd/pt.tx --rodata-bin /sd/pt.ro --data-bin /sd/pt.dt --reloc-out /sd/pt.rl
asm_pass2 --link --prelude-idx /sd/p.idx --prelude-text-bin /sd/p.tx --prelude-rodata-bin /sd/p.ro --prelude-data-bin /sd/p.dt --prelude-reloc /sd/p.rl --user-idx /sd/kc.idx --user-text-bin /sd/kc.tx --user-rodata-bin /sd/kc.ro --user-data-bin /sd/kc.dt --user-reloc /sd/kc.rl --add /sd/pp.idx /sd/pp.tx /sd/pp.ro /sd/pp.dt /sd/pp.rl --add /sd/bf.idx /sd/bf.tx /sd/bf.ro /sd/bf.dt /sd/bf.rl --add /sd/bs.idx /sd/bs.tx /sd/bs.ro /sd/bs.dt /sd/bs.rl --add /sd/ff.idx /sd/ff.tx /sd/ff.ro /sd/ff.dt /sd/ff.rl --add /sd/mf.idx /sd/mf.tx /sd/mf.ro /sd/mf.dt /sd/mf.rl --add /sd/tf.idx /sd/tf.tx /sd/tf.ro /sd/tf.dt /sd/tf.rl --add /sd/pf.idx /sd/pf.tx /sd/pf.ro /sd/pf.dt /sd/pf.rl --add /sd/vf.idx /sd/vf.tx /sd/vf.ro /sd/vf.dt /sd/vf.rl --add /sd/ld.idx /sd/ld.tx /sd/ld.ro /sd/ld.dt /sd/ld.rl --add /sd/kp.idx /sd/kp.tx /sd/kp.ro /sd/kp.dt /sd/kp.rl --add /sd/pt.idx /sd/pt.tx /sd/pt.ro /sd/pt.dt /sd/pt.rl --lab-out /sd/full.lab
md5sum /sd/full.lab
echo SELF_STEP2_DONE
