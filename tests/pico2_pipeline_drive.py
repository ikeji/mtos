#!/usr/bin/env python3
"""pico2_pipeline_drive.py — drive a sequence of sh commands through
the Pico 2 Debug Probe UART, waiting for the sh$ prompt between each
command instead of timing-based pacing.

Why: the kernel's PL011 RX FIFO is only 32 bytes deep, and while sh is
in sys_wait for a child task there is nobody draining it. Sending the
next command at fixed delay drops characters mid-stream. Waiting for
the prompt keeps us strictly in lock-step with sh.
"""
import argparse, os, select, sys, termios, time, fcntl


def open_tty(dev):
    fd = os.open(dev, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
    attrs = termios.tcgetattr(fd)
    attrs[0] = 0
    attrs[1] = 0
    attrs[2] = termios.CS8 | termios.CREAD | termios.CLOCAL
    attrs[3] = 0
    attrs[4] = termios.B115200
    attrs[5] = termios.B115200
    termios.tcsetattr(fd, termios.TCSANOW, attrs)
    return fd


def drain(fd, timeout, prompt=None, log=sys.stdout, slowtype_quiet=False):
    """Read from fd until either prompt is seen or timeout expires.
    Return the bytes received as bytes."""
    deadline = time.time() + timeout
    out = bytearray()
    tail_check = b"sh$ " if prompt is None else prompt.encode()
    while True:
        remaining = deadline - time.time()
        if remaining <= 0:
            return bytes(out)
        r, _, _ = select.select([fd], [], [], min(0.5, remaining))
        if fd in r:
            try:
                buf = os.read(fd, 4096)
            except OSError:
                buf = b""
            if buf:
                out.extend(buf)
                log.buffer.write(buf)
                log.flush()
                if tail_check and out.endswith(tail_check):
                    return bytes(out)


def slow_write(fd, data, per_char=0.005):
    for ch in data:
        os.write(fd, bytes([ch]))
        time.sleep(per_char)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", default="/dev/ttyACM0")
    ap.add_argument("--prompt", default="sh$ ", help="prompt string to wait for")
    ap.add_argument("--cmd-timeout", type=float, default=120.0)
    ap.add_argument("--initial-wait", type=float, default=8.0,
                    help="initial wait for boot before any commands")
    ap.add_argument("--per-char-delay", type=float, default=0.005)
    ap.add_argument("script", help="file with one command per line")
    args = ap.parse_args()

    fd = open_tty(args.port)
    sys.stdout.write(f"# wait for boot ({args.initial_wait}s) and first prompt\n")
    drain(fd, args.initial_wait, prompt=args.prompt)

    with open(args.script) as f:
        cmds = [ln.rstrip("\n") for ln in f if ln.strip() and not ln.startswith("#")]

    for i, cmd in enumerate(cmds):
        sys.stdout.write(f"\n# >>> [{i+1}/{len(cmds)}] {cmd}\n")
        sys.stdout.flush()
        slow_write(fd, (cmd + "\n").encode(), args.per_char_delay)
        out = drain(fd, args.cmd_timeout, prompt=args.prompt)
        if not out.endswith(args.prompt.encode()):
            sys.stdout.write(f"\n# WARNING: prompt not seen within {args.cmd_timeout}s\n")
    os.close(fd)


if __name__ == "__main__":
    main()
