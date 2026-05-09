# Compile kernel/platform_pico2.tc → /sd/pp.s on pico2.
#
# platform_pico2.tc (no imports) holds the do_uart_write /
# do_uart_read / do_uart_try_read / do_write / do_read symbols the
# kernel modules call into. The hand-written /src/platform_pico2.s
# only carries the boot path (_start, _park, _set_kern_gp,
# do_exit__i32, IMAGE_DEF) — the .tc-side symbols disappeared from
# the link when the runtime split moved them out of asm.
#
# Required by self_replicate / link_kernel; without this the on-
# device link fails with `undefined label do_write__i32__u32__i32`.
parse < /src/platform_pico2.tc > /sd/pp.ast
sigscan < /sd/pp.ast > /sd/pp.th
tcheck --tgth /sd/pp.th --tgt /sd/pp.ast --out /sd/pp.tast
codegen < /sd/pp.tast > /sd/pp.bc
bc2asm < /sd/pp.bc > /sd/pp.s
md5sum /sd/pp.s
echo COMPILE_PLATFORM_DONE
