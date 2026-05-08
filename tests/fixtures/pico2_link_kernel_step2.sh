# Step 2: asm_pass2 walks /sd/full.s and emits /sd/full.lab. Pass
# `--lab-out` and the source path positionally so asm_pass2 bakes
# a `src /sd/full.s` line into the .lab; step 3's asm_pass3 then
# opens /sd/full.s directly per section pass — no need to
# concatenate three copies into /sd/p2_in.s (matches the
# self_replicate optimisation in commit 0c9a9a4).
#
# Needs fresh reset after step 1 to clear kernel-arena fragmentation
# from cat's many fatfs reads.
asm_pass2 --lab-out /sd/full.lab /sd/full.s
md5sum /sd/full.lab
echo STEP2_DONE
