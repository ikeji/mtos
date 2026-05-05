# Self-replicate step 3: asm_pass2 → /sd/k.bin (the linked kernel
# with the disk image embedded). Needs fresh reset after step 2 to
# clear kernel arena fragmentation.
rm /sd/full.s
rm /sd/full.lab
asm_pass2 < /sd/p2_in.s > /sd/k.bin
md5sum /sd/k.bin
echo SELF_STEP3_DONE
