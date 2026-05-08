# Step 2: LINK_MODE pre-encode + link. asm_pass1 walks /sd/full.s
# once and emits the per-section .bin + .reloc artefacts asm_pass2
# --link consumes; --prelude-* is optional so the entire kernel is
# the user-side input.  /sd/full.lab gets the merged label table
# and `src raw` lines pointing at the .bins; step 3's asm_pass3 just
# memcpies those + applies relocs.
#
# Needs fresh reset after step 1 to clear kernel-arena fragmentation
# from cat's many fatfs reads.
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
echo STEP2_DONE
