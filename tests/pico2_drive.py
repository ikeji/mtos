#!/usr/bin/env python3
"""pico2_drive.py — drive pico2 sh via UART, waiting for 'sh$ ' prompt
between commands. Used for interactive / long-running pipelines where
fixed sleeps are fragile.

Usage:  python3 pico2_drive.py <uart_port> <timeout_sec> <cmd1> [cmd2 ...]

Writes captured UART output to stdout. Exits 0 if every command saw a
following 'sh$ ' prompt within the per-command timeout, 1 otherwise.
"""

import sys, os, time, select, termios

def set_raw(fd):
    attr = termios.tcgetattr(fd)
    attr[0] &= ~(termios.BRKINT | termios.ICRNL | termios.INPCK |
                 termios.ISTRIP | termios.IXON)
    attr[2] &= ~(termios.CSIZE | termios.PARENB)
    attr[2] |= termios.CS8
    attr[3] &= ~(termios.ECHO | termios.ICANON | termios.IEXTEN | termios.ISIG)
    termios.tcsetattr(fd, termios.TCSANOW, attr)

def read_until(fd, needle: bytes, deadline: float, out_buf: bytearray) -> bool:
    """Read from fd until needle appears in cumulative output or deadline."""
    while time.time() < deadline:
        r, _, _ = select.select([fd], [], [], 0.2)
        if r:
            chunk = os.read(fd, 4096)
            if chunk:
                out_buf.extend(chunk)
                sys.stdout.buffer.write(chunk)
                sys.stdout.buffer.flush()
                if needle in out_buf:
                    return True
    return False

def main():
    port = sys.argv[1]
    per_cmd_timeout = float(sys.argv[2])
    commands = sys.argv[3:]

    fd = os.open(port, os.O_RDWR | os.O_NOCTTY)
    set_raw(fd)

    buf = bytearray()
    # Wait for first "sh$ " prompt
    if not read_until(fd, b"sh$ ", time.time() + 30, buf):
        print("\nERROR: did not see initial sh$ prompt", file=sys.stderr)
        return 1

    for i, cmd in enumerate(commands):
        print(f"\n>>> [{i+1}/{len(commands)}] {cmd!r}", flush=True)
        # Reset our view of incoming bytes so the next read_until only
        # has to match the new prompt after this command completes.
        buf = bytearray()
        os.write(fd, (cmd + "\n").encode())
        if not read_until(fd, b"sh$ ", time.time() + per_cmd_timeout, buf):
            print(f"\nERROR: command {i+1} timed out ({per_cmd_timeout}s)", file=sys.stderr)
            return 1

    # send quit
    os.write(fd, b"quit\n")
    buf = bytearray()
    read_until(fd, b"SH: bye", time.time() + 10, buf)
    return 0

if __name__ == "__main__":
    sys.exit(main())
