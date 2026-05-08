# Step 3: asm_pass3 link → /sd/knod.bin via --lab/--out. Reads
# /sd/full.lab + opens the `src /sd/full.s` path recorded inside it
# three times (once per emit section). Needs fresh reset after
# step 2. md5 should match the host reference for the empty-disk
# variant: f21e5f2e018ee4102040de06f58fd216.
asm_pass3 --lab /sd/full.lab --out /sd/knod.bin
md5sum /sd/knod.bin
echo STEP3_DONE
