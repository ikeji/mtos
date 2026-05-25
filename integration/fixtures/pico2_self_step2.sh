# Self-replicate step 2 — per-file pre-encode + link.
#
# Same pipeline shape compile-gen2.sh uses on the host: pre-encode
# each input with asm_pass1 (small task arena footprint) then merge
# with asm_pass2.
#
# Order MUST match host input order from compile-gen2.sh
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
# Per-file approach keeps each asm_pass1 invocation at ~50-150 KB
# peak on its own small input. The task exits before the next runs,
# so the kernel arena's 504 KB only ever hosts one asm_pass1 task
# at a time.

asm_pass1 /src/raw.s --idx-out /sd/raw.idx --text-bin /sd/raw.tx --rodata-bin /sd/raw.ro --data-bin /sd/raw.dt --reloc-out /sd/raw.rl
asm_pass1 /src/platform_pico2.s --idx-out /sd/platform.idx --text-bin /sd/platform.tx --rodata-bin /sd/platform.ro --data-bin /sd/platform.dt --reloc-out /sd/platform.rl
asm_pass1 /src/trap_common.s --idx-out /sd/trap.idx --text-bin /sd/trap.tx --rodata-bin /sd/trap.ro --data-bin /sd/trap.dt --reloc-out /sd/trap.rl
asm_pass1 /sd/runtime.s --idx-out /sd/runtime.idx --text-bin /sd/runtime.tx --rodata-bin /sd/runtime.ro --data-bin /sd/runtime.dt --reloc-out /sd/runtime.rl
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
asm_pass1 /src/crt0_pico2_data.s --idx-out /sd/cd.idx --text-bin /sd/cd.tx --rodata-bin /sd/cd.ro --data-bin /sd/cd.dt --reloc-out /sd/cd.rl
asm_pass1 /sd/wrap.s --idx-out /sd/wrap.idx --text-bin /sd/wrap.tx --rodata-bin /sd/wrap.ro --data-bin /sd/wrap.dt --reloc-out /sd/wrap.rl
asm_pass2 --add /sd/raw.idx --add /sd/platform.idx --add /sd/trap.idx --add /sd/runtime.idx --add /sd/kc.idx --add /sd/pp.idx --add /sd/bf.idx --add /sd/bs.idx --add /sd/ff.idx --add /sd/mf.idx --add /sd/tf.idx --add /sd/pf.idx --add /sd/vf.idx --add /sd/ld.idx --add /sd/kp.idx --add /sd/cd.idx --add /sd/wrap.idx --lab-out /sd/full.lab
md5sum /sd/full.lab
echo SELF_STEP2_DONE
