# Try asm_pass3 immediately after boot, reading the .lab file
# pre-staged at /sd/full.lab (whose `src` line points to /sd/full.s).
echo TRY_ASM_PASS3
asm_pass3 --lab /sd/full.lab --out /sd/kn.bin
md5sum /sd/kn.bin
echo DONE
