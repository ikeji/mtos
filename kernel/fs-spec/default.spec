# default.spec — files included in every standard mtfs disk image
# (disk.img / disk-demo.img / disk-console.img / disk-console-land.img)
#
# Syntax:
#   # comment
#   *include <relative-path>     recursively include another spec
#   <mtfs-path> <host-path>      copy host-path → root/<mtfs-path>
#
# 注: GUEST_TASK_BINS (40 bin), prelude.s / prelude_tail.s (generated),
# /etc/kern.conf (per-variant), per-task header (.s) は build スクリプト
# 側で別途処理する (この spec には含まれない)。

# Static content files
/hello.txt                          kernel/fs-spec/etc/hello.txt

# phase 7 test inputs (referenced by integration/test_phase7.sh)
/phase7.tc                          integration/inputs/phase7_hello.tc
/phase7_min.tc                      integration/inputs/phase7_min.tc
/hw.tc                              integration/inputs/phase7_hello_world.tc

# msh script fixtures (test_os が msh smoke/abort で検証)
/msh_smoke.sh                       kernel/tests/fixtures/msh_smoke.sh
/msh_abort.sh                       kernel/tests/fixtures/msh_abort.sh

# pico2 bench helper (実機 self-replicate で使用)
/pico2_bench_idx.sh                 integration/fixtures/pico2_bench_idx.sh

# tcheck wrap 用 literal text files
/empty_imports.txt                  kernel/fs-spec/etc/empty_imports.txt
/imports_open.txt                   kernel/fs-spec/etc/imports_open.txt
/self_open.txt                      kernel/fs-spec/etc/self_open.txt
/wrap_close.txt                     kernel/fs-spec/etc/wrap_close.txt
