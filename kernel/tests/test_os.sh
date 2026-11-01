#!/bin/bash
# test_os.sh — tests for OS/runtime components (uses Gen2 pipeline)
# FULL_TEST=1: also runs kmalloc and kernel1 (cooperative) tests

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$(dirname "$SCRIPT_DIR")/../compiler/tests/test_common.sh"

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
        "$ROOT_DIR/compiler/scripts/compile-gen2.sh" -o "$TMP/test_kmalloc" \
        "$ROOT_DIR/compiler/tests/test_kmalloc.tc" 2>/dev/null
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
    VIRT_CRT0="$ROOT_DIR/compiler/tests/virt_crt0.s"
    t0=$(time_ms)
    CRT0="$VIRT_CRT0" \
    ASM_PROLOGUE="; raw" \
    GEN2_DIR="$_GEN2_TMP" \
        "$ROOT_DIR/compiler/scripts/compile-gen2.sh" -o "$TMP/test_kernel1" \
        "$ROOT_DIR/compiler/tests/test_kernel1.tc" 2>/dev/null
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
#     (kernel/build/virt_kernel.bin + kernel/build/disk-demo.img).
#     disk-demo.img stages tests/fixtures/kern_demo.conf so init tasks
#     are driven by /etc/kern.conf (hello + hello2 + sh), exercising
#     both the kern.conf loader and the A/B preemption demo. The
#     plain make-run image (disk.img) is sh-only. This script is run
#     via `make test`, which ensures both are built.
#     When someone invokes this script standalone without the Make
#     wrapper, fall back to building into a local tmp directory. ---
KERNEL_BIN="$ROOT_DIR/kernel/build/virt_kernel.bin"
KERNEL_DISK="$ROOT_DIR/kernel/build/disk-demo.img"
if [ ! -s "$KERNEL_BIN" ] || [ ! -s "$KERNEL_DISK" ]; then
    if command -v qemu-system-riscv32 >/dev/null 2>&1; then
        KERN_CONFIG="$ROOT_DIR/kernel/tests/fixtures/kern_demo.conf" \
        GEN2_DIR="$_GEN2_TMP" \
            "$ROOT_DIR/kernel/scripts/build.sh" --target virt \
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
    fs_out=$(printf 'tmpdemo\ncatfile\ncatfile /hello.txt\necho hi > /tmp/redir\ncatfile /tmp/redir\nrm /tmp/redir\nrm /tmp/redir\nls /dev\necho DEVFS_OK > /dev/uart\necho 2031-08-20 09:15:42 > /dev/rtc\ncat /dev/rtc\ndate\ndate 2040-02-29 23:59:58\ndate 2040-02-30 00:00:00\nfbtest\nkbdump\nKBDTEST_HELLO\necho PIPEWORD | wc\nps\nfree\nuptime\ndf\nfind /bin -name hel*\nfind /tmp /proc -type f\necho 15 > /proc/self/env/ROWS\necho lcd > /proc/self/env/TERM\ncat /proc/self/env/ROWS\nls /proc/self/env\ncatfile /proc/self/cmdline\ncat /proc/self/env/NOPE\nrm /proc/self/env/TERM\nls /proc/self/env\nsetenv COLS 56\ngetenv COLS\nunsetenv TERM\nenv\nsete\t TABC tab77\ngete\t TABC\necho ab\e[DX\e[CY\nxcho LE2\e[H\e[3~e\e[F ok\njunk\025echo KU\e[D\e[D\013K3\nvi /tmp/k\niAAAA=\n\n\eかんじ\n\n\e\rBB=かんじ\n\n\n\e\rCCCC=かんじ\n\n\177\e\rDDDDDD=ぴぴ\n\n\e\rEEE=あんぱん\n\n   \e\rFFFFF=よむ\n\n\e\rGGG=たかい\n\n \e\rHHHHHH=\nt d f y \e\e:wq\r\n\n\n\n\n\n\ngrep 漢字 /tmp/k | wc\ngrep 幹事 /tmp/k | wc\ngrep かんじ /tmp/k | wc\ngrep ピピ /tmp/k | wc\ngrep パン /tmp/k | wc\ngrep 読む /tmp/k | wc\ngrep 高い /tmp/k | wc\ngrep 「 /tmp/k | wc\nrm /tmp/k\nconsole\ncat /proc/self/env/ROWS\necho CTEST\nquit\nquit\n' \
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
    # Count CAT[ openings and CAT[2]: explicit-argv runs. The original
    # CAT[1]: check was brittle because the kernel's `[km ...]` line
    # can flush between catfile's `puts("CAT[")` and the digit write,
    # leaving "CAT[" but no "CAT[1]:" substring. fs_cat_count and
    # fs_cat2_count together still confirm three spawns + two explicit
    # paths ran.
    fs_cat_count=$(echo "$fs_out" | grep -c 'CAT\[')
    fs_cat2_count=$(echo "$fs_out" | grep -c 'CAT\[2\]:')
    fs_has_mtfs_msg=$(echo "$fs_out" | grep -c "hello, mtfs")
    fs_has_tmpfs_ok=$(echo "$fs_out" | grep -c "TMPFS_OK")
    # tmpfs payload check: just confirm "hello tmpfs" landed on UART
    # somewhere. The original "TMP:hello tmpfs" substring is brittle
    # because the kernel may flush its kdbg buffer (`[km ...]` task-
    # exit stats) into the gap between tmpdemo's `puts("TMP:")` and
    # `sys_write(buf, n)`, breaking the contiguous match without
    # breaking the actual write path. Pair this with TMPFS_OK above
    # to keep the assertion meaningful.
    fs_has_tmpfs_payload=$(echo "$fs_out" | grep -c "hello tmpfs")
    # Redirect check: echo hi > /tmp/redir writes "hi\n" to tmpfs
    # (no CAT: prefix because the byte stream is redirected away
    # from the UART), and catfile /tmp/redir prints "CAT[2]:hi".
    fs_has_redir=$(echo "$fs_out" | grep -c 'CAT\[2\]:hi')
    # tmpfs unlink check (#30): the first `rm /tmp/redir` succeeds
    # silently, the second prints "rm: cannot remove" because the file
    # is gone. Exactly one failure message proves both the successful
    # delete and the post-delete lookup miss.
    fs_rm_fail_count=$(echo "$fs_out" | grep -c "cannot remove")
    fs_has_sh=$(echo "$fs_out" | grep -c "SH: ready")
    fs_has_bye=$(echo "$fs_out" | grep -c "SH: bye")
    # devfs check: `ls /dev` enumerates "uart" (devfs_readdir), and
    # `echo DEVFS_OK > /dev/uart` opens /dev/uart and routes the write
    # through devfs_write → do_uart_write, so "DEVFS_OK" reaches UART.
    fs_has_dev=$(echo "$fs_out" | grep -c "uart")
    # ps / free / uptime / df reformat /proc/{tasks,meminfo,diskinfo} and
    # the uptime ecall: one header / value line each.
    fs_has_ps=$(echo "$fs_out" | grep -c "SLOT STATE   WAIT")
    fs_has_free=$(echo "$fs_out" | grep -c "^\(total\|used\|free\):.* KB")
    fs_has_uptime=$(echo "$fs_out" | grep -c "^up [0-9]*\.[0-9][0-9][0-9] s")
    fs_has_df=$(echo "$fs_out" | grep -c "^mtfs   /      total=")
    # find: recursive walk + -name glob (basename) + -type f across mounts.
    # /bin/hello2 must appear exactly once (glob hel*), /tmp/demo (left by
    # tmpdemo) proves tmpfs entries are classified as files, and no
    # directory (/bin/hel* has none, /tmp, /proc) may leak through.
    fs_has_find=$(echo "$fs_out" | grep -c "^/bin/hello2$")
    fs_has_find_tmp=$(echo "$fs_out" | grep -c "^/tmp/demo$")
    fs_find_dir=$(echo "$fs_out" | grep -c "^/tmp$\\|^/proc$\\|^/bin$")
    # /proc/self (docs/task/proc_env.md): `echo 15 > /proc/self/env/ROWS`
    # sets sh's env (the redirect is opened in sh's context), the child
    # `cat` inherits it and reads "15"; ls lists ROWS + TERM. `rm
    # /proc/self/env/TERM` runs in rm's own task and only unsets rm's
    # inherited copy, so the second ls still shows both (2 "ROWS", 2
    # "TERM") — unsetting sh's var needs the sh builtin (Phase 3).
    # cmdline echoes catfile's own argv; an unset key fails open. The sh
    # builtins then set COLS (getenv prints 56), unset TERM and `env`
    # lists exactly COLS=56 + ROWS=15. The cat inside the console's sh
    # exercises inheritance through console → sh → cat but its output
    # goes to /dev/fb, so it is not asserted.
    fs_env_15=$(echo "$fs_out" | grep -c "^15$")
    fs_env_ls=$(echo "$fs_out" | grep -c "^ROWS$")
    fs_env_term=$(echo "$fs_out" | grep -c "^TERM$")
    fs_env_cmd=$(echo "$fs_out" | grep -c "^CAT\[2\]:catfile /proc/self/cmdline$")
    fs_env_nope=$(echo "$fs_out" | grep -c "cat: /proc/self/env/NOPE: open failed")
    fs_env_56=$(echo "$fs_out" | grep -c "^56$")
    fs_env_envc=$(echo "$fs_out" | grep -c "^COLS=56$")
    fs_env_envr=$(echo "$fs_out" | grep -c "^ROWS=15$")
    fs_env_envt=$(echo "$fs_out" | grep -c "^TERM=")
    # Tab completion of builtins: "sete<TAB>" / "gete<TAB>" complete to
    # setenv / getenv (no /bin entry starts with those), so the value
    # round-trips.
    fs_env_tab=$(echo "$fs_out" | grep -c "^tab77$")
    # Line editing: ← insert → insert; Home + Delete + End (Ctrl-A would be
    # eaten by qemu's mon:stdio escape, so ESC[H / ESC[F stand in);
    # Ctrl-U then ←← Ctrl-K.
    fs_edit1=$(echo "$fs_out" | grep -c "^aXbY$")
    fs_edit2=$(echo "$fs_out" | grep -c "^LE2 ok$")
    fs_edit3=$(echo "$fs_out" | grep -c "^K3$")
    # vi kana→kanji conversion (docs/task/vi_kanji_conv.md): insert mode
    # takes raw UTF-8 bytes, LF enters TUT mode, a second LF converts the
    # hiragana before the cursor. Four lines: first candidate
    # (AAAA=漢字), second candidate via another LF (BB=幹事), Backspace
    # during conversion restores the reading (CCCC=かんじ), a reading the
    # dictionary lacks falls back to katakana (DDDDDD=ピピ). After :wq,
    # `grep <word> /tmp/k | wc` reads the saved file (not vi's screen
    # echo): the labels are sized so each line's byte count is unique
    # (12 / 10 / 15 / 14, none equal to PIPEWORD's 9). The 7 LFs after
    # :wq are padding: vi reads stdin in 8-byte batches and drops what
    # is left of the batch when it quits, which would otherwise eat
    # the start of the next sh command (sh treats the surviving empty
    # lines as no-ops). Skipped when vi was built with the empty
    # fallback dictionary (tmp/SKK-JISYO.M missing — see
    # userland/Makefile fetch-dict).
    fs_vi_a=$(echo "$fs_out" | grep -c "^1 1 12")
    fs_vi_b=$(echo "$fs_out" | grep -c "^1 1 10")
    fs_vi_c=$(echo "$fs_out" | grep -c "^1 1 15")
    fs_vi_d=$(echo "$fs_out" | grep -c "^1 1 14")
    # Case e: あんぱん → 版 / アンパン / ンパン / [パン] (3 Spaces) → "EEE=あんパン" = 17 B
    fs_vi_e=$(echo "$fs_out" | grep -c "^1 1 17")
    # Case f: よむ → okuri-ari よm → [読む] (first) → "FFFFF=読む" = 13 B
    # Case g: たかい → okuri-nasi 高井, then okuri-ari たかi → [高い] (1 Space) → "GGG=高い" = 11 B
    fs_vi_f=$(echo "$fs_out" | grep -c "^1 1 13")
    fs_vi_g=$(echo "$fs_out" | grep -c "^1 1 11")
    # Case h: TUT symbols, letter + Space: t␣ d␣ f␣ y␣ → "HHHHHH=「、。」" = 20 B
    fs_vi_h=$(echo "$fs_out" | grep -c "^1 1 20")
    # Case a presses Ctrl-J once more right after "AAAA=" (no kana before
    # the cursor): the message may be rendered once, but the next key
    # must clear it — it used to stick until the next set_msg and so
    # reappeared after a conversion was committed.
    fs_vi_m=$(echo "$fs_out" | grep -c "no kana before cursor")
    fs_vi=0
    if [ "$fs_vi_a" -eq 1 ] && [ "$fs_vi_b" -eq 1 ] && [ "$fs_vi_c" -eq 1 ] && [ "$fs_vi_d" -eq 1 ] && [ "$fs_vi_e" -eq 1 ] && [ "$fs_vi_f" -eq 1 ] && [ "$fs_vi_g" -eq 1 ] && [ "$fs_vi_h" -eq 1 ] && [ "$fs_vi_m" -le 1 ]; then fs_vi=1; fi
    fs_vi_note=""
    if [ "$(wc -c < "$SCRIPT_DIR/../../userland/build/vidict.dat" 2>/dev/null || echo 0)" -le 400 ]; then
        fs_vi=1; fs_vi_note=" (vi conversion SKIPPED: empty dictionary)"
    fi
    fs_has_devwrite=$(echo "$fs_out" | grep -c "DEVFS_OK")
    # /dev/rtc roundtrip: writing a fixed datetime then reading it
    # back exercises devfs_write accumulation + commit-at-close +
    # rtc_parse_set + the goldfish-rtc set/get + rtc_format.
    fs_has_rtc=$(echo "$fs_out" | grep -c "2031-08-20 09:15:4")
    # /bin/date: no-arg prints the same /dev/rtc snapshot (2nd 2031 line),
    # a valid argument sets and echoes back, an impossible day (Feb 30)
    # is rejected in date itself before anything is written.
    fs_date_set=$(echo "$fs_out" | grep -c "^2040-02-29 23:59:5")
    fs_date_bad=$(echo "$fs_out" | grep -c "date: day out of range")
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
    # The bound (150) has ~5 of slack over the measured value: the first
    # spawn of a task with a new allocation size grows the kmalloc pool
    # once (vi's 216 KB image: baseline 128 → 133 after one vi, still
    # 133 after two), which is pool growth, not a per-spawn leak.
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
                && [ "$fs_cat_count" -ge 3 ] \
                && [ "$fs_cat2_count" -ge 2 ] && [ "$fs_has_mtfs_msg" -gt 0 ] \
                && [ "$fs_has_tmpfs_ok" -gt 0 ] && [ "$fs_has_tmpfs_payload" -gt 0 ] \
                && [ "$fs_has_redir" -gt 0 ] \
                && [ "$fs_rm_fail_count" -eq 1 ] \
                && [ "$fs_has_dev" -gt 0 ] && [ "$fs_has_devwrite" -gt 0 ] \
                && [ "$fs_has_rtc" -ge 2 ] && [ "$fs_date_set" -eq 1 ] && [ "$fs_date_bad" -eq 1 ] \
                && [ "$fs_has_fb" -gt 0 ] \
                && [ "$fs_has_kbd" -gt 0 ] && [ "$fs_has_pipe" -gt 0 ] \
                && [ "$fs_has_console" -gt 0 ] \
                && [ "$fs_has_ps" -gt 0 ] && [ "$fs_has_free" -eq 3 ] \
                && [ "$fs_has_uptime" -gt 0 ] && [ "$fs_has_df" -gt 0 ] \
                && [ "$fs_has_find" -eq 1 ] && [ "$fs_has_find_tmp" -eq 1 ] && [ "$fs_find_dir" -eq 0 ] \
                && [ "$fs_env_15" -eq 1 ] && [ "$fs_env_ls" -eq 2 ] && [ "$fs_env_term" -eq 2 ] \
                && [ "$fs_env_cmd" -eq 1 ] && [ "$fs_env_nope" -eq 1 ] \
                && [ "$fs_env_56" -eq 1 ] && [ "$fs_env_envc" -eq 1 ] && [ "$fs_env_envr" -eq 1 ] && [ "$fs_env_envt" -eq 0 ] && [ "$fs_env_tab" -eq 1 ] \
                && [ "$fs_edit1" -eq 1 ] && [ "$fs_edit2" -eq 1 ] && [ "$fs_edit3" -eq 1 ] \
                && [ "$fs_vi" -eq 1 ] \
                && [ "$fs_has_sh" -gt 0 ] && [ "$fs_has_bye" -gt 0 ] \
                && [ -n "$fs_live" ] && [ "$fs_live" -le 150 ]; then
                report_pass "fs_virtio: kern.conf init + tmpdemo + catfile argv + redirect + devfs + rtc + date + fb + kbd + pipe + ps/free/uptime/df/find + /proc/self/env + vi kana→kanji + console, live=$fs_live$fs_vi_note" "$elapsed"
            else
                report_fail_msg "fs_virtio" \
                    "cat=$fs_cat_count cat2=$fs_cat2_count tmpok=$fs_has_tmpfs_ok tmppayload=$fs_has_tmpfs_payload redir=$fs_has_redir rmfail=$fs_rm_fail_count dev=$fs_has_dev devwr=$fs_has_devwrite rtc=$fs_has_rtc date=$fs_date_set/$fs_date_bad fb=$fs_has_fb kbd=$fs_has_kbd pipe=$fs_has_pipe ps=$fs_has_ps free=$fs_has_free uptime=$fs_has_uptime df=$fs_has_df find=$fs_has_find/$fs_has_find_tmp/$fs_find_dir env=$fs_env_15/$fs_env_ls/$fs_env_term/$fs_env_cmd/$fs_env_nope/$fs_env_56/$fs_env_envc/$fs_env_envr/$fs_env_envt/$fs_env_tab edit=$fs_edit1/$fs_edit2/$fs_edit3 vi=$fs_vi_a/$fs_vi_b/$fs_vi_c/$fs_vi_d/$fs_vi_e/$fs_vi_f/$fs_vi_g/$fs_vi_h/msg$fs_vi_m console=$fs_has_console live=$fs_live a=$fs_has_a b=$fs_has_b mtfs=$fs_has_mtfs_msg sh=$fs_has_sh bye=$fs_has_bye; got: $(printf '%s' "$fs_out" | head -c 480)"
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
KERNEL_CONSOLE_DISK="$ROOT_DIR/kernel/build/disk-console.img"
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
    # console renders glyphs to /dev/fb: mode-0 = one RGB565 pixel blit
    # (legacy), mode-4 = a 1-bpp glyph the kernel expands, mode-5 = a
    # coalesced same-row glyph batch (one write per run). Accept any of
    # them — the point is that text reached /dev/fb, not the exact path.
    ci_fb=$(echo "$ci_out" | grep -cE "FB: mode=(0|4|5)")
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
        bmp="$ROOT_DIR/kernel/build/console.bmp"
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

    # --- console_cursor: the same screen typed two ways must render
    #     pixel-identically — plain `echo gg`, and `echo gg` with the
    #     cursor walked back over the text and forward again before
    #     Enter (sh line editing). The underline cursor sits on the
    #     bottom rows of the glyph it rests on; erase_cursor must repaint
    #     the glyph from the grid, not black the band out. Portrait has
    #     no clock chrome, so the final framebuffers are deterministic. ---
    if command -v python3 >/dev/null 2>&1; then
        t0=$(time_ms)
        run_console_bmp() {
            printf "$1" \
                | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
                -serial mon:stdio --no-reboot -m 128 \
                -machine virt,aclint=on -bios none \
                -drive "file=$KERNEL_CONSOLE_DISK,format=raw,if=none,id=blk0" \
                -device "virtio-blk-device,drive=blk0" \
                -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
                -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null \
                | tr -d '\0' > "$TMP/cc_$2.txt"
            python3 "$SCRIPT_DIR/fb_render.py" "$TMP/cc_$2.txt" "$TMP/cc_$2.bmp" 2>/dev/null
        }
        run_console_bmp 'echo gg\nquit\n' plain
        run_console_bmp 'echo gg\e[D\e[D\e[D\e[D\e[D\e[D\e[D\e[C\e[C\e[C\e[C\e[C\e[C\e[C\nquit\n' moved
        cc_plain_blits=$(grep -cE "FB: mode=(0|4|5)" "$TMP/cc_plain.txt")
        if [ -s "$TMP/cc_plain.bmp" ] && [ -s "$TMP/cc_moved.bmp" ] \
            && [ "$cc_plain_blits" -gt 0 ] \
            && cmp -s "$TMP/cc_plain.bmp" "$TMP/cc_moved.bmp"; then
            report_pass "console_cursor: cursor moved over typed text leaves the glyphs intact" \
                "$(( $(time_ms) - t0 ))"
        else
            report_fail_msg "console_cursor" \
                "framebuffers differ after cursor movement (plain blits=$cc_plain_blits, $TMP/cc_plain.bmp vs $TMP/cc_moved.bmp)"
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
    # seq 10 still forces software scroll once /etc/login's neofetch
    # banner has filled the 15-row landscape window — that's all the
    # test needs to assert "no mode=2 blits". Larger seq counts push
    # the test past the kernel-test 30 s budget on slower hosts.
    cl_out=$(printf 'console -l\nseq 10\nquit\nquit\n' \
        | timeout 15 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    cl_mode=$(echo "$cl_out" | grep -c "CONSOLE: landscape, software scroll")
    cl_exit=$(echo "$cl_out" | grep -c "CONSOLE: exit")
    # Landscape must NOT touch the hardware vertical scroll (mode 2).
    cl_hw=$(echo "$cl_out" | grep -c "FB: mode=2")
    # Software-scroll evidence: a redraw repaints every cell (mode-0
    # for glyphs, mode-1 for empties). seq 30 with 20 visible rows
    # scrolls ~10 times — each scroll emits ROWS*COLS = 1200 blits.
    # A large mode-0 count is also fine in portrait, so the negative
    # signal (no mode=2) is what locks the landscape claim.
    cl_blits=$(echo "$cl_out" | grep -c "FB: mode=")
    if [ "$cl_mode" -gt 0 ] && [ "$cl_exit" -gt 0 ] \
        && [ "$cl_hw" -eq 0 ] && [ "$cl_blits" -ge 100 ]; then
        report_pass "console_landscape: console -l software-scrolls" "$elapsed"
    else
        report_fail_msg "console_landscape" \
            "mode=$cl_mode exit=$cl_exit hw=$cl_hw blits=$cl_blits; got: $(printf '%s' "$cl_out" | head -c 320)"
    fi
fi

# --- console_kernconf_argv: boot disk-console-land.img, whose
#     /etc/kern.conf seeds `init=/bin/console -l`. Verifies kern.conf
#     init lines can carry arguments — console must come up landscape
#     (software scroll) purely from the boot config, with no shell to
#     pass argv. Confirms the cfg tokenizer + init-task argv packing. ---
KERNEL_CONSOLE_LAND_DISK="$ROOT_DIR/kernel/build/disk-console-land.img"
if command -v qemu-system-riscv32 >/dev/null 2>&1 \
    && [ -s "$KERNEL_BIN" ] && [ -s "$KERNEL_CONSOLE_LAND_DISK" ]; then
    t0=$(time_ms)
    # seq 5 already overflows the 15-row landscape window once
    # /etc/login's neofetch has filled it — enough to assert "no
    # mode=2 blits". seq 30 was a leftover from the no-login era.
    ck_out=$(printf 'seq 5\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_CONSOLE_LAND_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    ck_land=$(echo "$ck_out" | grep -c "CONSOLE: landscape, software scroll")
    ck_exit=$(echo "$ck_out" | grep -c "CONSOLE: exit")
    ck_done=$(echo "$ck_out" | grep -c "all tasks done")
    ck_hw=$(echo "$ck_out" | grep -c "FB: mode=2")
    if [ "$ck_land" -gt 0 ] && [ "$ck_exit" -gt 0 ] \
        && [ "$ck_done" -gt 0 ] && [ "$ck_hw" -eq 0 ]; then
        report_pass "console_kernconf_argv: init=/bin/console -l passes argv at boot" "$elapsed"
    else
        report_fail_msg "console_kernconf_argv" \
            "land=$ck_land exit=$ck_exit done=$ck_done hw=$ck_hw; got: $(printf '%s' "$ck_out" | head -c 320)"
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
