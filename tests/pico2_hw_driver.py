#!/usr/bin/env python3
"""pico2_hw_driver.py — UART-mediated Hello World compile on pico2.

Drives pico2 (post-flash) through the OS-side compile pipeline:
    parse → sigscan → tcheck → codegen → bc2asm  (on pico2, tmpfs)
    cat /tmp/4.s                                   (dump .s to host)
    host: full.s = prelude + 4.s + prelude_tail
    asm_pass1 > /tmp/lab     (host streams full.s + EOT)
    cat /tmp/lab             (dump lab to host)
    asm_pass2 > /tmp/hw      (host streams lab + full.s × 3 + EOT)
    /tmp/hw                  (run compiled binary on pico2)

Host input to pico2: raw bytes written to the tty — sh consumes them
on fd 0. source_reader.tc on pico2 treats 0x04 as EOF so asm_pass1 /
asm_pass2 know when their UART-fed input ends.

Output parsing: the pico2 kernel sprays scheduler markers (`[sw X>Y]`,
`[x N=R]`, `[kmem …]`) mid-stream. They are always whole-byte tokens
starting with `[` and ending with `]` + newline, so we strip them
line-regex style when collecting binary dumps.

Usage:
    python3 pico2_hw_driver.py --port /dev/ttyACM0 \
        --prelude <prelude.s> --prelude-tail <prelude_tail.s>
"""

import argparse
import os
import re
import select
import subprocess
import sys
import termios
import time

PROMPT = b"sh$ "
EOT = b"\x04"

def log(msg):
    print(f"[driver] {msg}", flush=True)

def open_tty(port):
    fd = os.open(port, os.O_RDWR | os.O_NOCTTY)
    attr = termios.tcgetattr(fd)
    attr[0] &= ~(termios.BRKINT | termios.ICRNL | termios.INPCK |
                 termios.ISTRIP | termios.IXON)
    attr[2] &= ~(termios.CSIZE | termios.PARENB)
    attr[2] |= termios.CS8
    attr[3] &= ~(termios.ECHO | termios.ICANON | termios.IEXTEN | termios.ISIG)
    termios.tcsetattr(fd, termios.TCSANOW, attr)
    return fd

def read_until(fd, needle: bytes, deadline: float, buf: bytearray):
    while time.time() < deadline:
        r, _, _ = select.select([fd], [], [], 0.2)
        if r:
            chunk = os.read(fd, 4096)
            if chunk:
                buf.extend(chunk)
                if needle in buf:
                    return True
    return False

def drain_after(buf: bytearray, needle: bytes):
    idx = buf.rfind(needle)
    if idx < 0: return
    del buf[:idx + len(needle)]

def strip_scheduler_markers(data: bytes) -> bytes:
    """Remove [sw X>Y], [x N=R], [kmem ...], [w N:M], [TRAP ...] markers.
    Markers are inserted atomically by kdbg_chr; they always span
    `[` … `]\n` without splitting. A single regex sweep handles them."""
    pattern = re.compile(rb"\[(?:sw [0-9]+>[0-9]+"
                         rb"|x [0-9]+=[-0-9]+"
                         rb"|kmem peak=[0-9]+ live=[0-9]+"
                         rb"|w [0-9]+:[0-9]+"
                         rb"|TRAP [^]]*"
                         rb")\]\n?")
    return pattern.sub(b"", data)

def send_cmd_wait_prompt(fd, cmd: str, timeout: float = 120.0):
    """Send one shell command, wait for the `sh$ ` prompt after it, return
    the captured bytes in between (cleaned of scheduler markers and
    command echo).

    The pico2 uses the human-friendly `sh` (not `msh`), which echoes
    each typed byte back and translates the terminating LF into CRLF.
    That echoed command line shows up at the very start of our capture
    buffer. For byte-exact diff against Gen2 reference output we need
    to strip it; the echo is always `<cmd>\\r\\n`, uniquely identifiable
    because it's exactly what we just typed.

    We stream the command through send_stream so the PL011 32-byte RX
    FIFO doesn't drop bytes for commands longer than ~32 chars."""
    log(f"cmd: {cmd}")
    buf = bytearray()
    send_stream(fd, (cmd + "\n").encode())
    if not read_until(fd, PROMPT, time.time() + timeout, buf):
        log(f"TIMEOUT buf tail (last 200 bytes): {bytes(buf[-200:])!r}")
        raise TimeoutError(f"no prompt after {timeout}s: {cmd!r}")
    idx = buf.rfind(PROMPT)
    out = bytes(buf[:idx])
    # Strip the command echo at the start. Some environments may omit
    # the \r, so try both CRLF and LF terminators.
    echoed = cmd.encode()
    for terminator in (b"\r\n", b"\n"):
        if out.startswith(echoed + terminator):
            out = out[len(echoed) + len(terminator):]
            break
    return strip_scheduler_markers(out)

def send_cmd_no_wait(fd, cmd: str):
    log(f"cmd (no wait): {cmd}")
    os.write(fd, (cmd + "\n").encode())

def send_stream(fd, data: bytes):
    """Stream bytes to pico2 in small chunks so the PL011 32-byte RX FIFO
    doesn't overflow. Pico2's sh reads one byte at a time via syscall
    (each round trip is ~200 µs with scheduler ticks in the mix), so
    our realistic drain rate is closer to 5 KB/s than the 14 KB/s the
    raw UART can handle. We cap each write at 4 bytes (one-eighth of
    FIFO) and pace 20 ms between writes, for a steady ~200 B/s which
    sh can keep up with even while a timer ISR runs."""
    CHUNK = 4
    total = len(data)
    sent = 0
    while sent < total:
        n = min(CHUNK, total - sent)
        os.write(fd, data[sent:sent+n])
        sent += n
        time.sleep(0.020)

def reset_pico(openocd, scripts):
    subprocess.run([openocd, "-s", scripts,
                    "-f", "interface/cmsis-dap.cfg",
                    "-f", "target/rp2350-riscv.cfg",
                    "-c", "adapter speed 5000",
                    "-c", "init",
                    "-c", "reset run",
                    "-c", "exit"],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=False)

def cmp_ref(name: str, got: bytes, refs_dir: str, log_dir: str,
            results: list) -> bool:
    """If refs_dir is set, byte-compare `got` against refs_dir/name.
    Always saves got to log_dir/pico2.name for post-mortem. Returns True
    when no reference is configured or got matches. Appends a one-line
    status to results."""
    open(os.path.join(log_dir, f"pico2.{name}"), "wb").write(got)
    if not refs_dir:
        return True
    ref_path = os.path.join(refs_dir, name)
    if not os.path.exists(ref_path):
        results.append(f"  [{name}] SKIP (no reference at {ref_path})")
        return True
    ref = open(ref_path, "rb").read()
    if got == ref:
        results.append(f"  [{name}] OK ({len(got)} bytes)")
        return True
    results.append(f"  [{name}] DIFF: pico2={len(got)} ref={len(ref)}")
    return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", required=True)
    ap.add_argument("--prelude", required=True)
    ap.add_argument("--prelude-tail", required=True)
    ap.add_argument("--openocd", required=True)
    ap.add_argument("--openocd-scripts", required=True)
    ap.add_argument("--log-dir", required=True)
    ap.add_argument("--refs-dir", default=None,
                    help="If set, byte-compare each extracted stage against "
                         "<refs-dir>/<name> and exit non-zero on any DIFF.")
    ap.add_argument("--run-link", action="store_true",
                    help="Also run asm_pass1 + asm_pass2 link stages and "
                         "execute /tmp/hw. Requires reliable UART-stdin "
                         "streaming which may wedge the pico2 kernel.")
    args = ap.parse_args()
    results = []
    all_ok = True

    prelude = open(args.prelude, "rb").read()
    tail = open(args.prelude_tail, "rb").read()
    log(f"prelude.s={len(prelude)} bytes  tail={len(tail)} bytes")

    fd = open_tty(args.port)

    # --- Reset & wait for first sh$ ---
    log("resetting pico2")
    reset_pico(args.openocd, args.openocd_scripts)
    buf = bytearray()
    if not read_until(fd, PROMPT, time.time() + 20, buf):
        log("no initial sh$ prompt")
        return 1
    log("got sh$ prompt — draining boot-time output for 3s")
    # Hello/hello2 seed tasks print "A...A" / "B...B" concurrently
    # with sh. Give them time to finish so their output doesn't
    # interleave with our command stream.
    deadline = time.time() + 3.0
    while time.time() < deadline:
        r, _, _ = select.select([fd], [], [], 0.2)
        if r:
            chunk = os.read(fd, 4096)
            if chunk: buf.extend(chunk)

    # --- Warmup: avoids an occasional first-command hang on pico2
    # when the first spawn is cat + mtfs read + tmpfs redirect. Not
    # yet root-caused; the extra `cat /hello.txt` costs ~1s.
    send_cmd_wait_prompt(fd, "cat /hello.txt", timeout=30)

    # --- Front-end on pico2 (small tmpfs-only intermediates) ---
    send_cmd_wait_prompt(fd, "parse < /hw.tc > /tmp/1.ast", timeout=120)
    send_cmd_wait_prompt(fd, "sigscan < /tmp/1.ast > /tmp/1.th", timeout=120)

    # Capture /tmp/1.ast + /tmp/1.th via UART. Building the wrapped
    # tcheck input on-OS (multi-file `cat > /tmp/1.wrap`) hangs on
    # pico2 for reasons not yet diagnosed, so we reconstruct the
    # wrap on the host and stream it into tcheck's stdin.
    ast = send_cmd_wait_prompt(fd, "cat /tmp/1.ast", timeout=60)
    th = send_cmd_wait_prompt(fd, "cat /tmp/1.th", timeout=60)
    log(f"1.ast={len(ast)} bytes, 1.th={len(th)} bytes")
    all_ok &= cmp_ref("1.ast", ast, args.refs_dir, args.log_dir, results)
    all_ok &= cmp_ref("1.th", th, args.refs_dir, args.log_dir, results)

    # Build /tmp/1.wrap on pico2 via 2-file cat chain. Multi-file (>2)
    # cat has been observed to hang on pico2 (unresolved), and UART-
    # streaming the wrap bytes into `tcheck > /tmp/2.tast` also hangs
    # the kernel (pico2 do_uart_read spin-waits without yielding, and
    # after the first scheduler tick back to sh the system wedges).
    # Staging the wrap in tmpfs lets tcheck read its stdin from a real
    # file, matching the virt flow and keeping byte-exact semantics.
    send_cmd_wait_prompt(fd, "cat /empty_imports.txt /self_open.txt > /tmp/w1", timeout=30)
    send_cmd_wait_prompt(fd, "cat /tmp/w1 /tmp/1.th > /tmp/w2", timeout=30)
    send_cmd_wait_prompt(fd, "cat /tmp/w2 /wrap_close.txt > /tmp/w3", timeout=30)
    send_cmd_wait_prompt(fd, "cat /tmp/w3 /tmp/1.ast > /tmp/1.wrap", timeout=30)

    wrap = send_cmd_wait_prompt(fd, "cat /tmp/1.wrap", timeout=60)
    log(f"1.wrap={len(wrap)} bytes")
    all_ok &= cmp_ref("1.wrap", wrap, args.refs_dir, args.log_dir, results)

    send_cmd_wait_prompt(fd, "tcheck < /tmp/1.wrap > /tmp/2.tast", timeout=240)
    send_cmd_wait_prompt(fd, "codegen < /tmp/2.tast > /tmp/3.bc", timeout=240)
    send_cmd_wait_prompt(fd, "bc2asm < /tmp/3.bc > /tmp/4.s", timeout=240)

    # --- Dump /tmp/2.tast + /tmp/3.bc for byte-exact check ---
    tast = send_cmd_wait_prompt(fd, "cat /tmp/2.tast", timeout=60)
    all_ok &= cmp_ref("2.tast", tast, args.refs_dir, args.log_dir, results)
    bc = send_cmd_wait_prompt(fd, "cat /tmp/3.bc", timeout=60)
    all_ok &= cmp_ref("3.bc", bc, args.refs_dir, args.log_dir, results)

    # --- Dump /tmp/4.s via UART ---
    user_s = send_cmd_wait_prompt(fd, "cat /tmp/4.s", timeout=60)
    log(f"user .s = {len(user_s)} bytes")
    all_ok &= cmp_ref("4.s", user_s, args.refs_dir, args.log_dir, results)

    # --- Build full.s locally ---
    full_s = prelude + user_s + tail
    log(f"full.s = {len(full_s)} bytes (prelude {len(prelude)} + user {len(user_s)} + tail {len(tail)})")
    all_ok &= cmp_ref("full.s", full_s, args.refs_dir, args.log_dir, results)

    # --- Optional link stages (asm_pass1 + asm_pass2) ---
    # These need to stream 200+ KB of input over UART because the
    # assembly+label table is too big for pico2 tmpfs. The streaming
    # path wedges the kernel today (see the tcheck comment above), so
    # they run only when --run-link is passed. In --refs-dir mode the
    # compile-stage byte-exact check is the primary goal anyway: once
    # the source-level stages match Gen2, asm_pass1/pass2 produce the
    # same bytes deterministically (same qemu-riscv32 binaries).
    ran_link = False
    if args.run_link:
        send_cmd_no_wait(fd, "asm_pass1 > /tmp/lab")
        time.sleep(2.0)
        log(f"streaming full.s to asm_pass1 ({len(full_s)} bytes)")
        send_stream(fd, full_s)
        os.write(fd, EOT)
        log("sent EOT, waiting for asm_pass1 sh$ prompt")
        buf = bytearray()
        if not read_until(fd, PROMPT, time.time() + 240, buf):
            log("asm_pass1 timed out")
            open(os.path.join(args.log_dir, "asm_pass1.out"), "wb").write(buf)
            return 2
        log("asm_pass1 done")

        lab = send_cmd_wait_prompt(fd, "cat /tmp/lab", timeout=60)
        log(f"lab = {len(lab)} bytes")
        all_ok &= cmp_ref("lab.s", lab, args.refs_dir, args.log_dir, results)

        send_cmd_no_wait(fd, "asm_pass2 > /tmp/hw")
        time.sleep(2.0)
        payload = lab + full_s + full_s + full_s
        log(f"streaming asm_pass2 input ({len(payload)} bytes)")
        send_stream(fd, payload)
        os.write(fd, EOT)
        log("sent EOT, waiting for asm_pass2 sh$ prompt")
        buf = bytearray()
        if not read_until(fd, PROMPT, time.time() + 600, buf):
            log("asm_pass2 timed out")
            open(os.path.join(args.log_dir, "asm_pass2.out"), "wb").write(buf)
            return 3
        log("asm_pass2 done")

        # Run /tmp/hw.
        out = send_cmd_wait_prompt(fd, "/tmp/hw", timeout=60)
        log(f"/tmp/hw output: {out[:200]!r}")
        ran_link = b"Hello, World!" in out
        if ran_link:
            results.append("  [runtime] OK (/tmp/hw printed 'Hello, World!')")
        else:
            results.append("  [runtime] MISSING: /tmp/hw did not print "
                           "'Hello, World!'")
            open(os.path.join(args.log_dir, "hw.out"), "wb").write(out)
        all_ok &= ran_link

    # --- Summary ---
    if results:
        print("")
        print("=== pico2 byte-for-byte check ===")
        for line in results:
            print(line)
        if not args.run_link:
            print("  [lab.s / hw / runtime] SKIPPED "
                  "(pass --run-link to include link stages)")

    if all_ok:
        log("SUCCESS: all stages checked matched reference"
            + ("" if args.run_link else " (compile stages only)"))
        return 0
    log("FAIL: one or more stages did not match reference")
    return 4

if __name__ == "__main__":
    sys.exit(main())
