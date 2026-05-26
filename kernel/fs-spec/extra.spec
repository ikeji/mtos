# extra.spec — extends default.spec with the compiler pipeline + 全 source
#
# disk-extra.img の追加内容: EXTRA_GUEST_TASKS (parse/sigscan/.../asm_pass3
# + bin2uf2) + pico2 self-replicate fixtures + compiler/kernel source 一式
# (/src/ 配下に staging、device 側 asm_pass1〜3 が再 link するため)。
#
# 注: EXTRA_GUEST_TASKS 8 個の bin はビルド側で copy する (task list は
# 動的なので spec に書けない)。per-task header (.s) と raw.s も build 側。

*include default.spec

# pico2 self-replicate orchestrator step 0a〜0e の fixture
/pico2_compile_sb.sh                integration/fixtures/pico2_compile_sb.sh
/pico2_compile_parse.sh             integration/fixtures/pico2_compile_parse.sh
/pico2_compile_sigscan.sh           integration/fixtures/pico2_compile_sigscan.sh
/pico2_compile_tcheck.sh            integration/fixtures/pico2_compile_tcheck.sh
/pico2_compile_codegen.sh           integration/fixtures/pico2_compile_codegen.sh
/pico2_compile_bc2asm.sh            integration/fixtures/pico2_compile_bc2asm.sh
/pico2_compile_asm_pass1.sh         integration/fixtures/pico2_compile_asm_pass1.sh
/pico2_compile_asm_pass2.sh         integration/fixtures/pico2_compile_asm_pass2.sh
/pico2_compile_asm_pass3.sh         integration/fixtures/pico2_compile_asm_pass3.sh
/pico2_compile_runtime.sh           integration/fixtures/pico2_compile_runtime.sh
/pico2_compile_libtc.sh             integration/fixtures/pico2_compile_libtc.sh
/pico2_compile_kern.sh              integration/fixtures/pico2_compile_kern.sh
/pico2_compile_platform.sh          integration/fixtures/pico2_compile_platform.sh
/pico2_compile_kern2.sh             integration/fixtures/pico2_compile_kern2.sh
/pico2_compile_compilers.sh         integration/fixtures/pico2_compile_compilers.sh

# 単体 run / md5 / cleanup / dir-grow / dumper 等の補助
/pico2_run_parse.sh                 integration/fixtures/pico2_run_parse.sh
/pico2_run_sb.sh                    integration/fixtures/pico2_run_sb.sh
/pico2_md5_test.sh                  integration/fixtures/pico2_md5_test.sh
/pico2_cleanup_sd.sh                integration/fixtures/pico2_cleanup_sd.sh
/pico2_dir_grow_test.sh             integration/fixtures/pico2_dir_grow_test.sh
/pico2_dir_grow_test2.sh            integration/fixtures/pico2_dir_grow_test2.sh
/pico2_dumper_test.sh               integration/fixtures/pico2_dumper_test.sh
/pico2_self_step1.sh                integration/fixtures/pico2_self_step1.sh
/pico2_self_step2.sh                integration/fixtures/pico2_self_step2.sh
/pico2_self_step3.sh                integration/fixtures/pico2_self_step3.sh
/pico2_self_step4.sh                integration/fixtures/pico2_self_step4.sh

# Compiler sources (device 側 self-build 用 staging)
/src/string_buffer.tc               compiler/src/string_buffer.tc
/src/source_reader.tc               compiler/src/source_reader.tc
/src/strlib.tc                      compiler/src/strlib.tc
/src/ast_node.tc                    compiler/src/ast_node.tc
/src/asm_common.tc                  compiler/src/asm_common.tc
/src/asm_dead_strip.tc              compiler/src/asm_dead_strip.tc
/src/parse.tc                       compiler/src/parse.tc
/src/sigscan.tc                     compiler/src/sigscan.tc
/src/tcheck.tc                      compiler/src/tcheck.tc
/src/codegen.tc                     compiler/src/codegen.tc
/src/bc2asm.tc                      compiler/src/bc2asm.tc
/src/asm_pass1.tc                   compiler/src/asm_pass1.tc
/src/asm_pass2.tc                   compiler/src/asm_pass2.tc
/src/asm_pass2_lib.tc               compiler/src/asm_pass2_lib.tc
/src/asm_pass3.tc                   compiler/src/asm_pass3.tc
/src/asm_pass3_lib.tc               compiler/src/asm_pass3_lib.tc
/src/runtime.tc                     compiler/src/runtime.tc

# userland library
/src/libtc.tc                       userland/lib/libtc/libtc.tc

# Kernel sources (kernel.bin 再生成用)
/src/kernel_common.tc               kernel/src/kernel_common.tc
/src/tmpfs.tc                       kernel/src/tmpfs.tc
/src/fatfs.tc                       kernel/src/fatfs.tc
/src/mtfs.tc                        kernel/src/mtfs.tc
/src/procfs.tc                      kernel/src/procfs.tc
/src/vfs.tc                         kernel/src/vfs.tc
/src/loader.tc                      kernel/src/loader.tc
/src/kernel_pico2.tc                kernel/src/kernel_pico2.tc
/src/trap_common.s                  kernel/src/trap_common.s
/src/platform_pico2.tc              kernel/platform/pico2/platform_pico2.tc
/src/block_flash.tc                 kernel/platform/pico2/block_flash.tc
/src/block_sd.tc                    kernel/platform/pico2/block_sd.tc
/src/platform_pico2.s               kernel/platform/pico2/platform_pico2.s
/src/crt0_pico2_data.s              kernel/platform/pico2/crt0_pico2_data.s

# Task crt0 / data (MTOS bin の crt0)
/src/task_crt0.s                    compiler/runtime/mtos/task_crt0.s
/src/task_data.s                    compiler/runtime/mtos/task_data.s

# Literal: ASM_PROLOGUE
/src/raw.s                          kernel/fs-spec/etc/raw.s
