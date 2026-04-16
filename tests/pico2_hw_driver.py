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
    the captured bytes in between (cleaned of scheduler markers)."""
    log(f"cmd: {cmd}")
    buf = bytearray()
    os.write(fd, (cmd + "\n").encode())
    if not read_until(fd, PROMPT, time.time() + timeout, buf):
        log(f"TIMEOUT buf tail (last 200 bytes): {bytes(buf[-200:])!r}")
        raise TimeoutError(f"no prompt after {timeout}s: {cmd!r}")
    idx = buf.rfind(PROMPT)
    out = bytes(buf[:idx])
    return strip_scheduler_markers(out)

def send_cmd_no_wait(fd, cmd: str):
    log(f"cmd (no wait): {cmd}")
    os.write(fd, (cmd + "\n").encode())

def send_stream(fd, data: bytes):
    """Stream bytes to pico2 in small chunks so the PL011 32-byte RX FIFO
    doesn't overflow. Pico2 reads one byte at a time (blocks on FIFO)."""
    CHUNK = 64
    total = len(data)
    sent = 0
    while sent < total:
        n = min(CHUNK, total - sent)
        os.write(fd, data[sent:sent+n])
        sent += n
        # Tiny pacing delay: the PL011 FIFO plus pico2 kernel's read
        # loop can digest ~11 KB/s at 115200 baud with 8N1 framing.
        # 64 bytes / (11 KB/s) ≈ 5.8 ms. Give a hair more to absorb
        # scheduler jitter.
        time.sleep(0.007)

def reset_pico(openocd, scripts):
    subprocess.run([openocd, "-s", scripts,
                    "-f", "interface/cmsis-dap.cfg",
                    "-f", "target/rp2350-riscv.cfg",
                    "-c", "adapter speed 5000",
                    "-c", "init",
                    "-c", "reset run",
                    "-c", "exit"],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=False)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", required=True)
    ap.add_argument("--prelude", required=True)
    ap.add_argument("--prelude-tail", required=True)
    ap.add_argument("--openocd", required=True)
    ap.add_argument("--openocd-scripts", required=True)
    ap.add_argument("--log-dir", required=True)
    args = ap.parse_args()

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
    ast = send_cmd_wait_prompt(fd, "cat /tmp/1.ast", timeout=60).lstrip(b"\r\n")
    th = send_cmd_wait_prompt(fd, "cat /tmp/1.th", timeout=60).lstrip(b"\r\n")
    log(f"1.ast={len(ast)} bytes, 1.th={len(th)} bytes")
    open(os.path.join(args.log_dir, "1.ast"), "wb").write(ast)
    open(os.path.join(args.log_dir, "1.th"), "wb").write(th)

    wrap_bytes = b"(imports)\n(self\n" + th + b")\n" + ast
    log(f"wrap = {len(wrap_bytes)} bytes")
    open(os.path.join(args.log_dir, "1.wrap"), "wb").write(wrap_bytes)

    # Stream wrap into tcheck via UART stdin + EOT sentinel.
    send_cmd_no_wait(fd, "tcheck > /tmp/2.tast")
    time.sleep(2.0)
    send_stream(fd, wrap_bytes)
    os.write(fd, EOT)
    log("sent EOT, waiting for tcheck sh$")
    buf = bytearray()
    if not read_until(fd, PROMPT, time.time() + 240, buf):
        log("tcheck timed out")
        open(os.path.join(args.log_dir, "tcheck.out"), "wb").write(buf)
        return 5
    log("tcheck done")

    send_cmd_wait_prompt(fd, "codegen < /tmp/2.tast > /tmp/3.bc", timeout=240)
    send_cmd_wait_prompt(fd, "bc2asm < /tmp/3.bc > /tmp/4.s", timeout=240)

    # --- Dump /tmp/4.s via UART ---
    out = send_cmd_wait_prompt(fd, "cat /tmp/4.s", timeout=60)
    # strip leading \n and trailing noise; the output is the full .s content.
    user_s = out.lstrip(b"\r\n")
    log(f"user .s = {len(user_s)} bytes")
    open(os.path.join(args.log_dir, "4.s"), "wb").write(user_s)

    # --- Build full.s locally ---
    full_s = prelude + user_s + tail
    log(f"full.s = {len(full_s)} bytes (prelude {len(prelude)} + user {len(user_s)} + tail {len(tail)})")
    open(os.path.join(args.log_dir, "full.s"), "wb").write(full_s)

    # --- asm_pass1: send full.s + EOT, collect /tmp/lab afterwards ---
    # Kick off asm_pass1 as a background task on pico2. sh spawn waits
    # for the child to exit before re-printing sh$, so we pipe stdin
    # during the spawn.
    send_cmd_no_wait(fd, "asm_pass1 > /tmp/lab")
    # Give sh a moment to spawn asm_pass1 and for the child to settle
    # at its first sys_read (UART stdin).
    time.sleep(2.0)
    log(f"streaming full.s to asm_pass1 ({len(full_s)} bytes)")
    send_stream(fd, full_s)
    os.write(fd, EOT)
    log("sent EOT, waiting for asm_pass1 sh$ prompt")
    # asm_pass1 is CPU-heavy on pico2 even for Hello World; allow 4 min.
    buf = bytearray()
    if not read_until(fd, PROMPT, time.time() + 240, buf):
        log("asm_pass1 timed out")
        open(os.path.join(args.log_dir, "asm_pass1.out"), "wb").write(buf)
        return 2
    log("asm_pass1 done")

    # --- Dump /tmp/lab to host ---
    out = send_cmd_wait_prompt(fd, "cat /tmp/lab", timeout=60)
    lab = out.lstrip(b"\r\n")
    log(f"lab = {len(lab)} bytes")
    open(os.path.join(args.log_dir, "lab.s"), "wb").write(lab)

    # --- asm_pass2: send lab + full.s × 3 + EOT, collect /tmp/hw ---
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

    # --- Run /tmp/hw ---
    out = send_cmd_wait_prompt(fd, "/tmp/hw", timeout=60)
    log(f"/tmp/hw output: {out[:200]!r}")
    if b"Hello, World!" in out:
        log("SUCCESS: Hello, World! printed from pico2-compiled binary")
        return 0
    log("FAIL: no 'Hello, World!' in /tmp/hw output")
    open(os.path.join(args.log_dir, "hw.out"), "wb").write(out)
    return 4

if __name__ == "__main__":
    sys.exit(main())
