# Self-replicate step 2: LINK_MODE pre-encode + link.
#
# asm_pass1 walks /sd/full.s once and emits per-section .bin + .reloc
# artefacts. asm_pass2 --link merges them into /sd/full.lab with
# `src raw` lines pointing at the .bins; --prelude-* is optional so
# the entire kernel image is the user-side input. step 3's asm_pass3
# then memcpies the .bins + applies relocs — no on-device source
# re-walk per emit section.
asm_pass1 /sd/full.s --idx-out /sd/full.idx \
    --text-bin /sd/full.tx --rodata-bin /sd/full.ro \
    --data-bin /sd/full.dt --reloc-out /sd/full.rl
asm_pass2 --link \
    --user-idx        /sd/full.idx \
    --user-text-bin   /sd/full.tx \
    --user-rodata-bin /sd/full.ro \
    --user-data-bin   /sd/full.dt \
    --user-reloc      /sd/full.rl \
    --lab-out         /sd/full.lab
md5sum /sd/full.lab
echo SELF_STEP2_DONE
