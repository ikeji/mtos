# pico2_dumper_test.sh — verify the kernel-side mtfs dumper put
# /sd/dx.img in place at boot.
ls /sd | grep dx
md5sum /sd/dx.img
echo DUMP_TEST_DONE
