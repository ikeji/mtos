# Step 2: asm_pass1 + concat for asm_pass3 input. Needs fresh reset
# after step 1 to clear kernel-arena fragmentation from cat's many
# fatfs reads.
asm_pass1 < /sd/full.s > /sd/full.lab
md5sum /sd/full.lab
cat /sd/full.lab /sd/full.s /sd/full.s /sd/full.s > /sd/p2_in.s
md5sum /sd/p2_in.s
echo STEP2_DONE
