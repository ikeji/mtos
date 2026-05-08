# Self-replicate step 2: walk /sd/full.s, emit /sd/full.lab.
#
# Walked-source mode (asm_pass2 --lab-out src) instead of LINK_MODE
# because the kernel-image .s (~3.8 MB) is too big for the 288 KB
# asm_pass1 task arena — pass-1 ref bookkeeping + pass-2 label state
# both peak past the arena limit. Walked-source's per-pass state
# reset gives asm_pass2 a clean slate before it builds the .lab.
#
# step 3's asm_pass3 reads /sd/full.lab + reopens the `src /sd/full.s`
# path inside it three times (once per emit section).
#
# Needs fresh reset after step 1 to clear kernel-arena fragmentation
# from cat's many fatfs reads.
asm_pass2 --lab-out /sd/full.lab /sd/full.s
md5sum /sd/full.lab
echo SELF_STEP2_DONE
