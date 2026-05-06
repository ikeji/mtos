# Self-replicate step 2: asm_pass1 produces /sd/full.lab.
#
# Pass `--lab-out` and the source path positionally so asm_pass1
# bakes a `src /sd/full.s` line into the .lab. asm_pass3 in step 3
# then opens /sd/full.s directly per section pass — no need to
# concatenate three copies into /sd/p2_in.s (saved ~5 min and a
# 13 MB intermediate file).
asm_pass1 --lab-out /sd/full.lab /sd/full.s
md5sum /sd/full.lab
echo SELF_STEP2_DONE
