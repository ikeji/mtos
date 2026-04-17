#!/usr/bin/env python3
"""pico2_tty.py — bidirectional UART console for Pico 2.

Wires the host terminal to /dev/ttyACM0 so the pico2 kernel behaves
interactively, much like `make run` does for qemu:

  stdin  → UART TX (pico2 sh stdin)
  UART RX → stdout (pico2 UART output)

The host stdin is put into raw mode so single keystrokes (including
TAB for sh's completion and ESC for vi) reach pico2 immediately.
Ctrl-a x exits, mirroring the qemu stdio escape.

Usage:  python3 tests/pico2_tty.py [PORT] [BAUD]
        defaults: /dev/ttyACM0, 115200
"""

import os
import select
import sys
import termios
import tty


def open_uart(port: str, baud: int) -> int:
    fd = os.open(port, os.O_RDWR | os.O_NOCTTY)
    attr = termios.tcgetattr(fd)
    # iflag: don't translate CR/NL, drop parity, XON/XOFF.
    attr[0] &= ~(termios.BRKINT | termios.ICRNL | termios.INPCK |
                 termios.ISTRIP | termios.IXON)
    # cflag: 8N1, no parity.
    attr[2] &= ~(termios.CSIZE | termios.PARENB)
    attr[2] |= termios.CS8
    # lflag: fully raw — no line discipline.
    attr[3] &= ~(termios.ECHO | termios.ICANON | termios.IEXTEN | termios.ISIG)
    # Baud.
    speed = getattr(termios, f"B{baud}")
    attr[4] = speed
    attr[5] = speed
    termios.tcsetattr(fd, termios.TCSANOW, attr)
    return fd


def main() -> int:
    port = sys.argv[1] if len(sys.argv) > 1 else "/dev/ttyACM0"
    baud = int(sys.argv[2]) if len(sys.argv) > 2 else 115200

    if not os.path.exists(port):
        print(f"pico2_tty: {port} not found (Debug Probe unplugged?)",
              file=sys.stderr)
        return 1

    uart_fd = open_uart(port, baud)

    stdin_fd = sys.stdin.fileno()
    saved_attr = None
    if os.isatty(stdin_fd):
        saved_attr = termios.tcgetattr(stdin_fd)
        tty.setraw(stdin_fd)

    print(f"[pico2-tty] {port} @ {baud}. Ctrl-a x to quit.",
          file=sys.stderr, flush=True)

    # Ctrl-a (0x01) + x exits — matches qemu's `-serial mon:stdio`
    # convention so muscle memory carries over. Lone Ctrl-a bytes
    # still pass through after a short timeout in practice because
    # typing speed can't double-tap faster than the select tick.
    escape_pending = False
    try:
        while True:
            r, _, _ = select.select([stdin_fd, uart_fd], [], [], None)
            if stdin_fd in r:
                data = os.read(stdin_fd, 1024)
                if not data:
                    break  # stdin EOF
                out = bytearray()
                for b in data:
                    if escape_pending:
                        escape_pending = False
                        if b == ord("x"):
                            return 0
                        # Pass the held Ctrl-a through alongside the
                        # second byte so non-escape sequences aren't
                        # silently eaten.
                        out.append(0x01)
                        out.append(b)
                    elif b == 0x01:
                        escape_pending = True
                    else:
                        out.append(b)
                if out:
                    os.write(uart_fd, bytes(out))
            if uart_fd in r:
                data = os.read(uart_fd, 1024)
                if data:
                    os.write(1, data)
    except KeyboardInterrupt:
        pass
    finally:
        if saved_attr is not None:
            termios.tcsetattr(stdin_fd, termios.TCSANOW, saved_attr)
        os.close(uart_fd)
    return 0


if __name__ == "__main__":
    sys.exit(main())
