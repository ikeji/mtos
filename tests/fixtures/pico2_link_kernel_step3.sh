# Step 3: asm_pass3 link → /sd/knod.bin. Needs fresh reset
# after step 2. md5 should match the host reference for the empty-
# disk variant: f21e5f2e018ee4102040de06f58fd216.
asm_pass3 < /sd/p2_in.s > /sd/knod.bin
md5sum /sd/knod.bin
echo STEP3_DONE
