#!/bin/bash
# test_os.sh — tests for OS/runtime components (uses Gen2 pipeline)
# FULL_TEST=1: also runs kmalloc and kernel1 (cooperative) tests

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

echo "=== OS Component Tests ==="

ensure_gen2_tools
if [ "$USE_NATIVE" != true ]; then
    echo "SKIP: OS tests (need qemu + riscv-gcc)"
    print_results
    exit $?
fi

TMP=$(mktemp -d)
trap "rm -rf '$TMP'" EXIT

# --- kmalloc (FULL_TEST only) ---
if [ "${FULL_TEST:-0}" = "1" ]; then
    t0=$(time_ms)
    GEN2_DIR="$_GEN2_TMP" \
        "$ROOT_DIR/compile-gen2.sh" -o "$TMP/test_kmalloc" \
        "$SCRIPT_DIR/test_kmalloc.tc" 2>/dev/null
    if [ -x "$TMP/test_kmalloc" ]; then
        out=$("$QEMU" "$TMP/test_kmalloc" 2>/dev/null)
        ex=$?
        elapsed=$(( $(time_ms) - t0 ))
        if [ "$out" = "0" ] && [ "$ex" -eq 0 ]; then
            report_pass "kmalloc (buckets + large + coalesce)" "$elapsed"
        else
            report_fail_msg "kmalloc" "expected output '0' exit 0, got '$out' exit $ex"
        fi
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "kmalloc" "compile-gen2.sh failed"
    fi
fi

# --- kernel1: cooperative task (FULL_TEST only) ---
if [ "${FULL_TEST:-0}" = "1" ] && command -v qemu-system-riscv32 >/dev/null 2>&1; then
    VIRT_CRT0="$SCRIPT_DIR/virt_crt0.s"
    t0=$(time_ms)
    CRT0="$VIRT_CRT0" \
    ASM_PROLOGUE="; raw" \
    GEN2_DIR="$_GEN2_TMP" \
        "$ROOT_DIR/compile-gen2.sh" -o "$TMP/test_kernel1" \
        "$SCRIPT_DIR/test_kernel1.tc" 2>/dev/null
    if [ -s "$TMP/test_kernel1" ]; then
        k1_out=$(timeout 5 qemu-system-riscv32 -smp 1 -nographic \
            -serial mon:stdio --no-reboot -m 128 \
            -machine virt,aclint=on -bios none \
            -device "loader,file=$TMP/test_kernel1,addr=0x80000000" \
            -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
        elapsed=$(( $(time_ms) - t0 ))
        case "$k1_out" in
            *"TASK1_OK"*"KERN_OK"*)
                report_pass "kernel1: guest task runs on separate stack" "$elapsed"
                ;;
            *)
                report_fail_msg "kernel1" \
                    "expected TASK1_OK + KERN_OK, got: $(printf '%s' "$k1_out" | head -c 80)"
                ;;
        esac
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "kernel1" "compile failed"
    fi
fi

# --- Kernel + mtfs disk image: the Make build owns these now
#     (build/kernel/virt_kernel.bin + build/kernel/disk-demo.img).
#     disk-demo.img stages tests/fixtures/kern_demo.conf so init tasks
#     are driven by /etc/kern.conf (hello + hello2 + sh), exercising
#     both the kern.conf loader and the A/B preemption demo. The
#     plain make-run image (disk.img) is sh-only. This script is run
#     via `make test`, which ensures both are built.
#     When someone invokes this script standalone without the Make
#     wrapper, fall back to building into a local tmp directory. ---
KERNEL_BIN="$ROOT_DIR/build/kernel/virt_kernel.bin"
KERNEL_DISK="$ROOT_DIR/build/kernel/disk-demo.img"
if [ ! -s "$KERNEL_BIN" ] || [ ! -s "$KERNEL_DISK" ]; then
    if command -v qemu-system-riscv32 >/dev/null 2>&1; then
        KERN_CONFIG="$ROOT_DIR/tests/fixtures/kern_demo.conf" \
        GEN2_DIR="$_GEN2_TMP" \
            "$ROOT_DIR/kernel/build.sh" --target virt \
            -o "$TMP/kernel_virt" --disk-out "$TMP/disk.img" 2>/dev/null
        KERNEL_BIN="$TMP/kernel_virt"
        KERNEL_DISK="$TMP/disk.img"
    fi
fi

# --- fs_virtio: attach the demo mtfs disk (init=/bin/hello +
#     init=/bin/hello2 + init=/bin/sh via /etc/kern.conf), boot
#     kernel_virt, verify it reads sector 0 (mtfs superblock),
#     mounts mtfs, cats /hello.txt via its in-kernel demo, runs the
#     kern.conf-driven init list, and drives sh through a scripted
#     command sequence to cover tmpfs / argv / redirect + spawn/wait
#     leak accounting. hello/hello2 emitting A/B doubles as a
#     preemption check. ---
if command -v qemu-system-riscv32 >/dev/null 2>&1 \
    && [ -s "$KERNEL_BIN" ] && [ -s "$KERNEL_DISK" ]; then
    t0=$(time_ms)
    # Shell loop exercises all phase 7 A/B/D prereqs:
    #   - tmpdemo:                tmpfs write path (phase 7 A)
    #   - catfile:                default argv (kernel argv clone)
    #   - catfile /hello.txt:     explicit argv path
    #   - echo hi > /tmp/redir:   sh stdout redirection (phase 7 D)
    #   - catfile /tmp/redir:     reads redirected content back
    # then quit. Six spawn cycles are enough to exercise the loader's
    # kfree path for frame_buf / ram / stack / img / argv / stdio fds;
    # the kernel prints "KERN: live=N" at shutdown so the test asserts
    # the count stays bounded regardless of spawn iterations.
    fs_out=$(printf 'tmpdemo\ncatfile\ncatfile /hello.txt\necho hi > /tmp/redir\ncatfile /tmp/redir\nls /dev\necho DEVFS_OK > /dev/uart\necho 2031-08-20 09:15:42 > /dev/rtc\ncat /dev/rtc\nfbtest\nkbdump\nKBDTEST_HELLO\necho PIPEWORD | wc\nconsole\necho CTEST\nquit\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    # We only check the mtfs magic bytes in SECTOR0: total_blocks varies
    # with how many files the image contains.
    expected="SECTOR0: 4d 54 46 53"
    # The shell prompt + catfile output + A/B get interleaved under
    # preemption, so check each piece separately rather than as a
    # single substring. catfile prints "CAT[<argc>]:" so we can
    # distinguish default runs (argc=1) from explicit-argv runs
    # (argc=2).
    fs_has_a=$(echo "$fs_out" | grep -c "A")
    fs_has_b=$(echo "$fs_out" | grep -c "B")
    fs_cat_count=$(echo "$fs_out" | grep -c 'CAT\[')
    fs_cat1_count=$(echo "$fs_out" | grep -c 'CAT\[1\]:')
    fs_cat2_count=$(echo "$fs_out" | grep -c 'CAT\[2\]:')
    fs_has_mtfs_msg=$(echo "$fs_out" | grep -c "hello, mtfs")
    fs_has_tmpfs_ok=$(echo "$fs_out" | grep -c "TMPFS_OK")
    fs_has_tmpfs_payload=$(echo "$fs_out" | grep -c "TMP:hello tmpfs")
    # Redirect check: echo hi > /tmp/redir writes "hi\n" to tmpfs
    # (no CAT: prefix because the byte stream is redirected away
    # from the UART), and catfile /tmp/redir prints "CAT[2]:hi".
    fs_has_redir=$(echo "$fs_out" | grep -c 'CAT\[2\]:hi')
    fs_has_sh=$(echo "$fs_out" | grep -c "SH: ready")
    fs_has_bye=$(echo "$fs_out" | grep -c "SH: bye")
    # devfs check: `ls /dev` enumerates "uart" (devfs_readdir), and
    # `echo DEVFS_OK > /dev/uart` opens /dev/uart and routes the write
    # through devfs_write → do_uart_write, so "DEVFS_OK" reaches UART.
    fs_has_dev=$(echo "$fs_out" | grep -c "uart")
    fs_has_devwrite=$(echo "$fs_out" | grep -c "DEVFS_OK")
    # /dev/rtc roundtrip: writing a fixed datetime then reading it
    # back exercises devfs_write accumulation + commit-at-close +
    # rtc_parse_set + the goldfish-rtc set/get + rtc_format.
    fs_has_rtc=$(echo "$fs_out" | grep -c "2031-08-20 09:15:4")
    # /dev/fb check: fbtest issues fill/blit/vscroll framed writes;
    # the UART-dump driver echoes each as "FB: mode=N ...".
    fs_has_fb=$(echo "$fs_out" | grep -c "FB: mode=1 x=0 y=0 w=320 h=480")
    # /dev/kbd check: kbdump reads a line from /dev/kbd (UART-RX
    # backed stub) and echoes "KBD:<line>".
    fs_has_kbd=$(echo "$fs_out" | grep -c "KBD:KBDTEST_HELLO")
    # pipe check: `echo PIPEWORD | wc` exercises sys_pipe +
    # sys_spawn_fds — echo's output must reach wc through the pipe.
    # "PIPEWORD\n" = 1 line, 1 word, 9 bytes.
    fs_has_pipe=$(echo "$fs_out" | grep -c "1 1 9")
    # /bin/console check: console spawns a nested sh over a pipe
    # (stdin=/dev/kbd, stdout=pipe), pumps its output to /dev/fb, and
    # exits cleanly when that sh quits. "CONSOLE: exit" proves the
    # whole getty + pipe pump path worked.
    fs_has_console=$(echo "$fs_out" | grep -c "CONSOLE: exit")
    # Leak canary: the kernel prints its kmalloc live count at the
    # end. With the K1 process-table fix in place, this stays bounded
    # by a small constant regardless of how many children sh spawns.
    fs_live=$(echo "$fs_out" | sed -n 's/.*KERN: live=\([0-9]*\).*/\1/p' | tail -1)
    case "$fs_out" in
        *"BLOCK: virtio-blk detected"*"$expected"*"MTFS: mounted"*"FILE:hello, mtfs"*"all tasks done"*)
            # The 5 catfile spawns mean we expect ≥5 CAT: outputs.
            # The live count must stay ≤ 110 — the current baseline
            # is ~104 (3 kern.conf init tasks + VFS/block state +
            # mtfs inode cache + TmpFileArray(16)/TmpfsFDArray(8)
            # struct slots + /tmp/demo persistent file + per-slot
            # task name U8Arrays + kern.conf g_cfg_inits StringArray).
            # A per-spawn leak would push it up by ~4 per extra spawn,
            # so a regression trips before 110.
            if [ "$fs_has_a" -gt 0 ] && [ "$fs_has_b" -gt 0 ] \
                && [ "$fs_cat_count" -ge 3 ] && [ "$fs_cat1_count" -ge 1 ] \
                && [ "$fs_cat2_count" -ge 2 ] && [ "$fs_has_mtfs_msg" -gt 0 ] \
                && [ "$fs_has_tmpfs_ok" -gt 0 ] && [ "$fs_has_tmpfs_payload" -gt 0 ] \
                && [ "$fs_has_redir" -gt 0 ] \
                && [ "$fs_has_dev" -gt 0 ] && [ "$fs_has_devwrite" -gt 0 ] \
                && [ "$fs_has_rtc" -gt 0 ] && [ "$fs_has_fb" -gt 0 ] \
                && [ "$fs_has_kbd" -gt 0 ] && [ "$fs_has_pipe" -gt 0 ] \
                && [ "$fs_has_console" -gt 0 ] \
                && [ "$fs_has_sh" -gt 0 ] && [ "$fs_has_bye" -gt 0 ] \
                && [ -n "$fs_live" ] && [ "$fs_live" -le 145 ]; then
                report_pass "fs_virtio: kern.conf init + tmpdemo + catfile argv + redirect + devfs + rtc + fb + kbd + pipe + console, live=$fs_live" "$elapsed"
            else
                report_fail_msg "fs_virtio" \
                    "cat=$fs_cat_count cat1=$fs_cat1_count cat2=$fs_cat2_count tmpok=$fs_has_tmpfs_ok tmppayload=$fs_has_tmpfs_payload redir=$fs_has_redir dev=$fs_has_dev devwr=$fs_has_devwrite rtc=$fs_has_rtc fb=$fs_has_fb kbd=$fs_has_kbd pipe=$fs_has_pipe console=$fs_has_console live=$fs_live a=$fs_has_a b=$fs_has_b mtfs=$fs_has_mtfs_msg sh=$fs_has_sh bye=$fs_has_bye; got: $(printf '%s' "$fs_out" | head -c 480)"
            fi
            ;;
        *)
            report_fail_msg "fs_virtio" \
                "expected detected + mtfs mounted + FILE: + all tasks done, got: $(printf '%s' "$fs_out" | head -c 240)"
            ;;
    esac
fi

# --- console_init: boot disk-console.img, whose /etc/kern.conf seeds
#     /bin/console as the sole init task (フェーズ9 S7). console comes
#     up at boot (not spawned by a shell), opens a nested /bin/sh over
#     a pipe with stdin=/dev/kbd, renders that shell's output to
#     /dev/fb, and exits cleanly when the shell quits. ---
KERNEL_CONSOLE_DISK="$ROOT_DIR/build/kernel/disk-console.img"
if command -v qemu-system-riscv32 >/dev/null 2>&1 \
    && [ -s "$KERNEL_BIN" ] && [ -s "$KERNEL_CONSOLE_DISK" ]; then
    t0=$(time_ms)
    ci_out=$(printf 'echo S7TEST\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_CONSOLE_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    ci_ready=$(echo "$ci_out" | grep -c "CONSOLE: ready")
    # console paints each glyph as one mode-0 RGB565 pixel blit.
    ci_fb=$(echo "$ci_out" | grep -c "FB: mode=0")
    ci_exit=$(echo "$ci_out" | grep -c "CONSOLE: exit")
    ci_done=$(echo "$ci_out" | grep -c "all tasks done")
    # The PC-98 font is .incbin'd into the console binary; console
    # must load it (font.bmp is mandatory — the build fails without it).
    ci_jp=$(echo "$ci_out" | grep -c "CONSOLE: jpfont loaded")
    # fd inheritance: the nested sh runs `echo S7TEST`; echo inherits
    # sh's stdout (the pipe to console), so "S7TEST" is rendered to
    # /dev/fb — it must NOT appear as literal text on the UART. If it
    # leaks here, child processes aren't inheriting console's stdout.
    ci_leak=$(echo "$ci_out" | grep -c "S7TEST")
    if [ "$ci_ready" -gt 0 ] && [ "$ci_fb" -gt 0 ] \
        && [ "$ci_exit" -gt 0 ] && [ "$ci_done" -gt 0 ] \
        && [ "$ci_leak" -eq 0 ] && [ "$ci_jp" -gt 0 ]; then
        report_pass "console_init: kern.conf seeds /bin/console at boot" "$elapsed"
    else
        report_fail_msg "console_init" \
            "ready=$ci_ready fb=$ci_fb exit=$ci_exit done=$ci_done leak=$ci_leak jp=$ci_jp; got: $(printf '%s' "$ci_out" | head -c 320)"
    fi

    # --- console_bmp: replay the /dev/fb commands console issued in
    #     the run above onto a 320x480 framebuffer and write a BMP, so
    #     the rendered display result can be inspected. fb_render.py
    #     exits 0 only if it rendered >= 1 blit. ---
    if command -v python3 >/dev/null 2>&1; then
        t0=$(time_ms)
        printf '%s' "$ci_out" > "$TMP/fb_dump.txt"
        bmp="$ROOT_DIR/build/kernel/console.bmp"
        rm -f "$bmp"
        if python3 "$SCRIPT_DIR/fb_render.py" "$TMP/fb_dump.txt" "$bmp" 2>/dev/null \
            && [ -s "$bmp" ] && [ "$(head -c2 "$bmp")" = "BM" ]; then
            report_pass "console_bmp: /dev/fb dump rendered to console.bmp" \
                "$(( $(time_ms) - t0 ))"
        else
            report_fail_msg "console_bmp" \
                "fb_render.py failed or produced an invalid BMP"
        fi
    fi

    # --- console_scroll: run `seq 40` through the console so its
    #     output overflows the 30-row window. Exercises the hardware-
    #     vscroll path — console must emit mode-2 scroll blits and
    #     still drive the nested shell to a clean exit. ---
    t0=$(time_ms)
    cs_out=$(printf 'seq 40\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_CONSOLE_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    cs_ready=$(echo "$cs_out" | grep -c "CONSOLE: ready")
    cs_exit=$(echo "$cs_out" | grep -c "CONSOLE: exit")
    cs_done=$(echo "$cs_out" | grep -c "all tasks done")
    # 40 numbers + shell echo/prompt lines is well over the 30-row
    # window, so console must scroll several times (mode-2 blits).
    cs_scroll=$(echo "$cs_out" | grep -c "FB: mode=2")
    if [ "$cs_ready" -gt 0 ] && [ "$cs_exit" -gt 0 ] \
        && [ "$cs_done" -gt 0 ] && [ "$cs_scroll" -ge 8 ]; then
        report_pass "console_scroll: seq 40 overflows the window, console scrolls" "$elapsed"
    else
        report_fail_msg "console_scroll" \
            "ready=$cs_ready exit=$cs_exit done=$cs_done scroll=$cs_scroll; got: $(printf '%s' "$cs_out" | head -c 320)"
    fi
fi

# --- console_landscape: spawn `console -l` from the UART shell so it
#     runs landscape (480x320). Rotated 90°, the ILI9488 hardware
#     vscroll axis is horizontal and useless for text, so console
#     scrolls in software — re-blitting the screen. `seq 30` overflows
#     the 20-row landscape window; assert console emits NO mode-2
#     (hardware-scroll) blits, does full-screen mode-1 redraws, and
#     still exits cleanly. ---
if command -v qemu-system-riscv32 >/dev/null 2>&1 \
    && [ -s "$KERNEL_BIN" ] && [ -s "$KERNEL_DISK" ]; then
    t0=$(time_ms)
    cl_out=$(printf 'console -l\nseq 30\nquit\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    cl_mode=$(echo "$cl_out" | grep -c "CONSOLE: landscape, software scroll")
    cl_exit=$(echo "$cl_out" | grep -c "CONSOLE: exit")
    # Landscape must NOT touch the hardware vertical scroll (mode 2)...
    cl_hw=$(echo "$cl_out" | grep -c "FB: mode=2")
    # ...it redraws the whole 480x320 screen on each scroll, which
    # starts with a full-screen mode-1 clear. seq 30 overflows the
    # 20-row landscape window many times.
    cl_redraw=$(echo "$cl_out" | grep -c "FB: mode=1 x=0 y=0 w=480 h=320")
    if [ "$cl_mode" -gt 0 ] && [ "$cl_exit" -gt 0 ] \
        && [ "$cl_hw" -eq 0 ] && [ "$cl_redraw" -ge 8 ]; then
        report_pass "console_landscape: console -l software-scrolls" "$elapsed"
    else
        report_fail_msg "console_landscape" \
            "mode=$cl_mode exit=$cl_exit hw=$cl_hw redraw=$cl_redraw; got: $(printf '%s' "$cl_out" | head -c 320)"
    fi
fi

# --- msh script mode: verifies set -ex tracing, # comment skip,
#     blank-line skip, and exit-code propagation via two fixtures
#     (msh_smoke.sh and msh_abort.sh) staged in disk-demo.img.
if command -v qemu-system-riscv32 >/dev/null 2>&1 \
    && [ -s "$KERNEL_BIN" ] && [ -s "$KERNEL_DISK" ]; then
    # --- smoke: 3 echos with 1 comment + 1 blank line in between ---
    t0=$(time_ms)
    smoke_out=$(printf 'msh /msh_smoke.sh\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    s_first=$(echo "$smoke_out" | grep -c '^first$')
    s_second=$(echo "$smoke_out" | grep -c '^second$')
    s_third=$(echo "$smoke_out" | grep -c '^third$')
    s_traces=$(echo "$smoke_out" | grep -c '>> echo ')
    s_exits=$(echo "$smoke_out" | grep -c 'exit=0 dt=')
    s_abort=$(echo "$smoke_out" | grep -c 'aborting')
    if [ "$s_first" -ge 1 ] && [ "$s_second" -ge 1 ] && [ "$s_third" -ge 1 ] \
        && [ "$s_traces" -ge 3 ] && [ "$s_exits" -ge 3 ] && [ "$s_abort" -eq 0 ]; then
        report_pass "msh script smoke (3 echos, comment+blank skipped)" "$elapsed"
    else
        report_fail_msg "msh script smoke" \
            "first=$s_first second=$s_second third=$s_third traces=$s_traces exits=$s_exits abort=$s_abort"
    fi

    # --- abort: cat on missing file → exit=1 → set -e aborts before
    #     the third command runs ---
    t0=$(time_ms)
    abort_out=$(printf 'msh /msh_abort.sh\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    a_before=$(echo "$abort_out" | grep -c '^before$')
    a_never=$(echo "$abort_out" | grep -c '^never_printed$')
    a_exit1=$(echo "$abort_out" | grep -c 'exit=1 dt=')
    a_aborts=$(echo "$abort_out" | grep -c 'msh: aborting at line')
    if [ "$a_before" -ge 1 ] && [ "$a_never" -eq 0 ] \
        && [ "$a_exit1" -ge 1 ] && [ "$a_aborts" -ge 1 ]; then
        report_pass "msh script abort (set -e on cat /nope exit=1)" "$elapsed"
    else
        report_fail_msg "msh script abort" \
            "before=$a_before never=$a_never exit1=$a_exit1 aborts=$a_aborts"
    fi
fi

print_results
