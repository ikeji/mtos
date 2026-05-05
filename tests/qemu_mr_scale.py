#!/usr/bin/env python3
"""qemu_mr_scale.py — sanity-check the mr framing decoder under
qemu virt by uploading payloads of increasing size and verifying
sh remains responsive afterwards.

Relevant gotcha: qemu's `-serial mon:stdio` intercepts Ctrl-A
(0x01) as the escape character, which silently eats any 0x01 byte
in a binary payload. Use `-serial stdio` (no monitor multiplex)
when piping framed input through stdio — it's the cause of the
bogus "K11 mr hang" we initially attributed to mr/UART."""
import hashlib, os, struct, subprocess, sys, time

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
KERNEL = os.path.join(ROOT, "build/kernel/virt_kernel.bin")
DISK = os.path.join(ROOT, "build/kernel/disk-extra.img")
FAT = os.path.join(ROOT, "build/kernel/fat.img")

CHUNK = 256

def write_all(p, data):
    p.stdin.write(data)
    p.stdin.flush()

def drain(p, deadline):
    buf = bytearray()
    fd = p.stdout.fileno()
    import fcntl
    flags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
    try:
        while time.time() < deadline:
            try:
                chunk = os.read(fd, 4096)
                if chunk:
                    buf.extend(chunk)
                else:
                    time.sleep(0.02)
            except BlockingIOError:
                time.sleep(0.02)
    finally:
        fcntl.fcntl(fd, fcntl.F_SETFL, flags & ~os.O_NONBLOCK)
    return bytes(buf)

args = [
    "qemu-system-riscv32", "-smp", "1", "-nographic",
    # Plain -serial stdio (no mon:) so Ctrl-A doesn't get
    # intercepted as the qemu escape — that ate the 0x01 byte (= Ctrl-A)
    # in the framed mr payload, dropping the high byte of the size field
    # and the first payload byte, which manifested as mr reading
    # bogus header bytes (0x42 = 'B' instead of 0x01) and then sitting
    # forever waiting for the wrongly-sized payload.
    "-serial", "stdio", "-monitor", "null", "--no-reboot", "-m", "128",
    "-machine", "virt,aclint=on", "-bios", "none",
    "-drive", f"file={FAT},format=raw,if=none,id=blk1",
    "-device", "virtio-blk-device,drive=blk1",
    "-drive", f"file={DISK},format=raw,if=none,id=blk0",
    "-device", "virtio-blk-device,drive=blk0",
    "-device", f"loader,file={KERNEL},addr=0x80000000",
    "-device", "loader,addr=0x80000000,cpu-num=0",
]
p = subprocess.Popen(args, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                     stderr=subprocess.STDOUT, bufsize=0)
try:
    boot = drain(p, time.time() + 4.0)
    sys.stderr.buffer.write(boot)
    sys.stderr.flush()

    sizes = [256, 1024, 4096, 65536]
    for size in sizes:
        # Use ASCII letters only — rules out NUL / control byte sensitivity.
        payload = bytes(((i % 26) + ord('A')) for i in range(size))
        expect_md5 = hashlib.md5(payload).hexdigest()
        path = f"/tmp/p{size}.bin"
        sys.stderr.write(f"\n=== upload {size} bytes -> {path} ===\n")
        sys.stderr.flush()
        write_all(p, f"mr > {path}\n".encode())
        time.sleep(1.0)
        t0 = time.time()
        framed = struct.pack("<H", size) + payload + b"\x00\x00"
        # Send one byte at a time with a small delay so qemu has time
        # to deliver each into the 16550 FIFO before the next arrives.
        for b in framed:
            write_all(p, bytes([b]))
            time.sleep(0.001)
        # Wait for mr to exit and sh to return.
        time.sleep(2.0)
        elapsed = time.time() - t0
        # Probe sh + readback file.
        write_all(p, f"\necho ===R{size}===\ncat {path} > /tmp/r{size}\nls /tmp\necho ===E{size}===\n".encode())
        out = drain(p, time.time() + 5.0)
        rate = size/elapsed/1024 if elapsed > 0 else 0
        ok = (b"===E%d===" % size) in out
        if not ok:
            sys.stderr.write(f"  HANG at size {size} ({rate:.1f} KiB/s upload)\n")
            sys.stderr.write(f"  last 200 bytes: {out[-200:]!r}\n")
            sys.stderr.flush()
            break
        sys.stderr.write(f"  ok ({rate:.1f} KiB/s)\n")
        sys.stderr.flush()
finally:
    p.kill()
    p.wait(timeout=2)
