# Self-replicate step 3: asm_pass3 link → /sd/k.bin via --lab/--out.
# Reads /sd/full.lab + memcpies the per-section .bin files referenced
# by its `src raw` lines (LINK_MODE — step 2 pre-encoded the kernel
# image into /sd/full.{tx,ro,dt} via asm_pass1).
asm_pass3 --lab /sd/full.lab --out /sd/k.bin
md5sum /sd/k.bin
echo SELF_STEP3_DONE
