# Self-replicate step 3: asm_pass3 link → /sd/k.bin via --lab/--out.
# Reads /sd/full.lab + opens the `src /sd/full.s` paths recorded
# inside it, three times (once per emit section).
asm_pass3 --lab /sd/full.lab --out /sd/k.bin
md5sum /sd/k.bin
echo SELF_STEP3_DONE
