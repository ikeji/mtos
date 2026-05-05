# Try asm_pass2 immediately after boot.
echo TRY_ASM_PASS2
asm_pass2 < /sd/p2_in.s > /sd/kn.bin
md5sum /sd/kn.bin
echo DONE
