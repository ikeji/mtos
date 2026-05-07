# pico2 phase 7 bench using pre-encoded prelude (docs/task/asm_pre_encode.md):
# the prelude is staged at kernel-build time as prelude.{text,rodata,data}.bin
# + prelude.reloc, so asm_pass2 emits a v2 .lab with `src raw` lines and
# asm_pass3 memcpies the bins + applies relocs instead of re-tokenising
# the ~12000-line prelude (target: 56 s → ~15 s).
parse < /hw.tc > /sd/1.ast
sigscan < /sd/1.ast > /sd/1.th
tcheck --tgth /sd/1.th --tgt /sd/1.ast --out /sd/2.tast
codegen < /sd/2.tast > /sd/3.bc
bc2asm < /sd/3.bc > /sd/4.s
cat /sd/4.s /prelude_tail.s > /sd/u.s
asm_pass1 /sd/u.s --idx-out /sd/u.idx --text-bin /sd/utx.bin --rodata-bin /sd/uro.bin --data-bin /sd/udt.bin --reloc-out /sd/url
asm_pass2 --link --prelude-idx /prelude.idx --user-idx /sd/u.idx --idx-source /prelude.s --prelude-text-bin /prelude.text.bin --prelude-rodata-bin /prelude.rodata.bin --prelude-data-bin /prelude.data.bin --prelude-reloc /prelude.reloc --user-text-bin /sd/utx.bin --user-rodata-bin /sd/uro.bin --user-data-bin /sd/udt.bin --user-reloc /sd/url --lab-out /sd/lab.s
asm_pass3 --lab /sd/lab.s --out /sd/HW
/sd/HW
