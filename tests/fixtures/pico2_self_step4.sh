# Self-replicate step 4: convert k.bin to UF2 on-device.
bin2uf2 /sd/k.bin /sd/k.uf2
md5sum /sd/k.uf2
echo SELF_STEP4_DONE
