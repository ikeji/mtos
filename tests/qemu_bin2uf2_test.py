#!/usr/bin/env python3
"""qemu_bin2uf2_test.py — verify the on-device bin2uf2 task
produces UF2 bytes identical to tools/bin2uf2.py.

Boots qemu virt with disk-extra.img, uploads a small kernel.bin
fixture into /tmp via mr (no Ctrl-A trap since we use plain
-serial stdio), runs bin2uf2 on it, then dumps the result back
through cat into a host file via the qemu serial output. md5
both sides and compare."""
import hashlib, os, struct, subprocess, sys, time, fcntl

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
KERNEL = os.path.join(ROOT, "build/kernel/virt_kernel.bin")
DISK = os.path.join(ROOT, "build/kernel/disk-extra.img")
FAT = os.path.join(ROOT, "build/kernel/fat.img")

# Use a fixture small enough to upload + readback fast (~6 KB so
# ~24 UF2 blocks of 512 bytes each).
FIXTURE_BYTES = 6144

def write_all(p, data):
    p.stdin.write(data); p.stdin.flush()

def drain(p, deadline):
    buf = bytearray()
    fd = p.stdout.fileno()
    flags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
    try:
        while time.time() < deadline:
            try:
                chunk = os.read(fd, 4096)
                if chunk: buf.extend(chunk)
                else: time.sleep(0.02)
            except BlockingIOError: time.sleep(0.02)
    finally:
        fcntl.fcntl(fd, fcntl.F_SETFL, flags & ~os.O_NONBLOCK)
    return bytes(buf)

def drain_until(p, marker_start, marker_end, timeout):
    """Drain until both markers seen, return everything between them."""
    buf = bytearray()
    deadline = time.time() + timeout
    fd = p.stdout.fileno()
    flags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
    try:
        while time.time() < deadline:
            try:
                chunk = os.read(fd, 4096)
                if chunk: buf.extend(chunk)
            except BlockingIOError: pass
            if marker_start in buf and marker_end in buf:
                break
            time.sleep(0.02)
    finally:
        fcntl.fcntl(fd, fcntl.F_SETFL, flags & ~os.O_NONBLOCK)
    return bytes(buf)

args = [
    "qemu-system-riscv32", "-smp", "1", "-nographic",
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

    # Stage the fixture via mr (the framing decoder).
    fixture = bytes((i * 7 + 13) & 0xFF for i in range(FIXTURE_BYTES))
    host_md5_in = hashlib.md5(fixture).hexdigest()
    write_all(p, b"mr > /tmp/in.bin\n")
    time.sleep(1.0)
    framed = struct.pack("<H", 256)
    for off in range(0, len(fixture), 256):
        chunk = fixture[off:off + 256]
        write_all(p, struct.pack("<H", len(chunk)) + chunk)
    write_all(p, b"\x00\x00")
    time.sleep(2.0)
    drain(p, time.time() + 1.0)
    print(f"\nuploaded fixture: {len(fixture)} bytes md5={host_md5_in}",
          file=sys.stderr)

    # Run bin2uf2 on device.
    write_all(p, b"\nbin2uf2 /tmp/in.bin /tmp/out.uf2\n")
    time.sleep(2.0)
    drain(p, time.time() + 1.0)

    # md5 it on device and capture.
    write_all(p, b"\necho ===HEAD===\nmd5sum /tmp/out.uf2\necho ===TAIL===\n")
    out = drain_until(p, b"===HEAD===", b"===TAIL===", 4.0)
    sys.stderr.buffer.write(b"\n--- md5 line ---\n")
    sys.stderr.buffer.write(out[-200:])
    sys.stderr.flush()
    # Extract md5.
    import re
    m = re.search(rb"^([0-9a-f]{32})  /tmp/out\.uf2", out, re.MULTILINE)
    dev_md5 = m.group(1).decode() if m else None

    # Host reference: run tools/bin2uf2.py on the same fixture.
    import tempfile
    with tempfile.NamedTemporaryFile(delete=False) as tf:
        tf.write(fixture)
        tf_path = tf.name
    host_uf2 = tf_path + ".uf2"
    subprocess.check_call([sys.executable,
                           os.path.join(ROOT, "tools/bin2uf2.py"),
                           tf_path, host_uf2])
    with open(host_uf2, "rb") as f:
        host_md5_uf2 = hashlib.md5(f.read()).hexdigest()
    os.unlink(tf_path); os.unlink(host_uf2)

    print(f"\nhost   uf2 md5: {host_md5_uf2}", file=sys.stderr)
    print(f"device uf2 md5: {dev_md5}", file=sys.stderr)
    if dev_md5 == host_md5_uf2:
        print("MATCH — bin2uf2 byte-exact under qemu virt.", file=sys.stderr)
        sys.exit(0)
    else:
        print("DIFFER", file=sys.stderr)
        sys.exit(1)
finally:
    p.kill(); p.wait(timeout=2)
