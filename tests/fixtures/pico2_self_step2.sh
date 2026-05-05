# Self-replicate step 2: asm_pass1 + cat for asm_pass2 input.
asm_pass1 < /sd/full.s > /sd/full.lab
md5sum /sd/full.lab
cat /sd/full.lab /sd/full.s /sd/full.s /sd/full.s > /sd/p2_in.s
md5sum /sd/p2_in.s
echo SELF_STEP2_DONE
