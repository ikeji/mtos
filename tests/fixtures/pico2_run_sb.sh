# Smoke test: write file via msh redirect, then list and read back.
echo hello > /sd/Y.TXT
ls /sd
cat /sd/Y.TXT
echo SD_SMOKE_DONE
