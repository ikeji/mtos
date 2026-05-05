# Step 3: asm_pass2 link → /sd/kernel_nodisk.bin. Needs fresh reset
# after step 2. md5 should match the host reference for the empty-
# disk variant: f21e5f2e018ee4102040de06f58fd216.
asm_pass2 < /sd/p2_in.s > /sd/kernel_nodisk.bin
md5sum /sd/kernel_nodisk.bin
echo STEP3_DONE
