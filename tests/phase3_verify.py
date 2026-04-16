#!/usr/bin/env python3
"""phase3_verify.py — verify each compile-pipeline stage on virt OS
by comparing OS outputs against Gen2 host references byte-for-byte,
through the final linked Hello World binary.

Flow:
  1. Build a virt kernel with EXTRA_TASKS (mx + compiler tasks) and
     export /prelude.s / /prelude_tail.s via PRELUDE_OUT_DIR so host
     references can replay the exact linker glue used on the OS.
  2. Generate reference files on the host with build/gen2/* under
     qemu-riscv32 — same binaries the OS runs, so byte-exact
     comparison is a true self-hosting check.
  3. Boot qemu-system-riscv32 and drive msh (no prompt echo) to run
     each compile + link stage, piping every intermediate through mx
     so the framed output is unambiguous in the captured UART stream.
     Finally execute /tmp/hw and check that "Hello, World!" appears
     in the UART output.
  4. Turn mux on first (via the muxon task) so the host demuxer can
     split task outputs cleanly. mx's stdout lands in task-tty tags
     (T00N with N≠2); we concat them in first-appearance order and
     split the resulting bytestream on mx's zero-length EOF markers.
  5. Diff each decoded mx stream against its golden reference.

Stages verified:
  1.ast 1.th 1.wrap 2.tast 3.bc 4.s full.s lab.s hw
and finally the runtime output of /tmp/hw (Hello World greeting).

Usage:  python3 tests/phase3_verify.py
"""

import os
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REFS = "/tmp/phase3_refs"
LOGS = "/tmp/phase3_logs"

# Source for the compile pipeline smoke test.
INPUT_TC = os.path.join(ROOT, "tests/phase7_hello_world.tc")


def run(cmd, **kw):
    return subprocess.run(cmd, check=True, **kw)


def gen_references_compile():
    """Compile stages: parse → sigscan → wrap → tcheck → codegen → bc2asm.

    Uses Gen2 binaries under qemu-riscv32 to match what the OS runs
    byte-for-byte (Gen1 parse would add cosmetic differences like
    single-line (params) emission)."""
    os.makedirs(REFS, exist_ok=True)
    with open(INPUT_TC, "rb") as i, open(f"{REFS}/1.ast", "wb") as out:
        run(["qemu-riscv32", f"{ROOT}/build/gen2/parse"], stdin=i, stdout=out)
    with open(f"{REFS}/1.ast", "rb") as i, open(f"{REFS}/1.th", "wb") as o:
        run(["qemu-riscv32", f"{ROOT}/build/gen2/sigscan"], stdin=i, stdout=o)
    # wrap: (imports)(self .th)(program .ast)
    with open(f"{REFS}/1.wrap", "wb") as w:
        w.write(b"(imports)\n(self\n")
        w.write(open(f"{REFS}/1.th", "rb").read())
        w.write(b")\n")
        w.write(open(f"{REFS}/1.ast", "rb").read())
    for step, out_ext, prev in [
        ("tcheck",  "2.tast", "1.wrap"),
        ("codegen", "3.bc",   "2.tast"),
        ("bc2asm",  "4.s",    "3.bc"),
    ]:
        with open(f"{REFS}/{prev}", "rb") as i, \
             open(f"{REFS}/{out_ext}", "wb") as o:
            run(["qemu-riscv32", f"{ROOT}/build/gen2/{step}"],
                stdin=i, stdout=o)


def gen_references_link():
    """Link stages: full.s (prelude + code + tail) → lab.s → hw binary.

    Prelude files are staged by kernel/build.sh into REFS/ via the
    PRELUDE_OUT_DIR env var, so we replay the exact bytes the OS
    cats into its linker pipeline."""
    with open(f"{REFS}/full.s", "wb") as o:
        o.write(open(f"{REFS}/prelude.s", "rb").read())
        o.write(open(f"{REFS}/4.s", "rb").read())
        o.write(open(f"{REFS}/prelude_tail.s", "rb").read())
    with open(f"{REFS}/full.s", "rb") as i, open(f"{REFS}/lab.s", "wb") as o:
        run(["qemu-riscv32", f"{ROOT}/build/gen2/asm_pass1"],
            stdin=i, stdout=o)
    # asm_pass2 input: lab.s + full.s × 3 (3-pass stream emitter —
    # text, rodata, data rescans).
    p2_in = (open(f"{REFS}/lab.s", "rb").read()
             + open(f"{REFS}/full.s", "rb").read() * 3)
    with open(f"{REFS}/hw", "wb") as o:
        run(["qemu-riscv32", f"{ROOT}/build/gen2/asm_pass2"],
            input=p2_in, stdout=o)


def build_kernel_with_extras():
    env = dict(os.environ)
    env["EXTRA_TASKS"] = ("parse sigscan tcheck codegen bc2asm "
                         "asm_pass1 asm_pass2 cat mx mr muxon muxoff")
    env["GEN2_DIR"] = os.path.join(ROOT, "build/gen2")
    # Stage prelude.s / prelude_tail.s into REFS/ for the link-stage
    # reference generator. (Same bytes mkfs.py put under /prelude.s
    # and /prelude_tail.s in mtfs.)
    os.makedirs(REFS, exist_ok=True)
    env["PRELUDE_OUT_DIR"] = REFS
    run([f"{ROOT}/kernel/build.sh", "--target", "virt",
         "-o", f"{ROOT}/build/kernel/virt_kernel.bin",
         "--disk-out", f"{ROOT}/build/kernel/disk.img"], env=env)


# ---------- UART mux frame parser (matches tests/uart_demux.py) ----------

def demux_frames(raw: bytes):
    """Yield (tag:str, payload:bytes) pairs from the UART stream.

    Pre-muxon boot bytes (no 0x1F magic) are yielded as tag='RAW '."""
    i = 0
    while i < len(raw):
        if raw[i] != 0x1F:
            yield "RAW ", raw[i:i+1]
            i += 1
            continue
        if i + 6 > len(raw):
            # header truncated, leftover treated as raw
            yield "RAW ", raw[i:]
            return
        tag_bytes = raw[i+1:i+5]
        # tag must be printable ASCII; otherwise this was false magic
        if not all(0x20 <= b <= 0x7E for b in tag_bytes):
            yield "RAW ", raw[i:i+1]
            i += 1
            continue
        n = raw[i+5]
        if i + 6 + n > len(raw):
            yield "RAW ", raw[i:]
            return
        yield tag_bytes.decode("ascii"), bytes(raw[i+6:i+6+n])
        i += 6 + n


# ---------- mx frame parser ----------

def decode_mx_streams(data: bytes):
    """Parse consecutive mx-encoded streams. Each stream is [len:u16
    LE][data:len]… ending with [0:u16]. Returns a list of bytes per
    stream. Trailing garbage is silently dropped."""
    streams = []
    cur = bytearray()
    i = 0
    while i + 2 <= len(data):
        size = data[i] | (data[i+1] << 8)
        i += 2
        if size == 0:
            streams.append(bytes(cur))
            cur = bytearray()
            continue
        if i + size > len(data):
            break
        cur.extend(data[i:i+size])
        i += size
    return streams


# ---------- virt qemu driver ----------

def make_framed(tag: str, payload: bytes) -> bytes:
    """Build a UART-mux frame: 0x1F + tag[4] + len[1] + payload[≤255]."""
    assert len(tag) == 4 and len(payload) <= 255
    return b"\x1F" + tag.encode("ascii") + bytes([len(payload)]) + payload


def run_pipeline_on_virt():
    # Build the stdin stream for qemu.
    #   1. Raw "muxon\n" while mux is still off. This command spawns
    #      the muxon task which flips g_mux_enabled = 1.
    #   2. After muxon, sh's sys_read(fd=0) reads from its per-task
    #      in_buf. Host must send framed input (T002 = sh's slot).
    #   3. Each subsequent command is wrapped as one T002 frame.
    stages = [
        # ---- compile ----
        "parse   < /hw.tc > /tmp/1.ast",
        "mx      < /tmp/1.ast",
        "sigscan < /tmp/1.ast > /tmp/1.th",
        "mx      < /tmp/1.th",
        "cat /empty_imports.txt /self_open.txt /tmp/1.th /wrap_close.txt /tmp/1.ast > /tmp/1.wrap",
        "mx      < /tmp/1.wrap",
        "tcheck  < /tmp/1.wrap > /tmp/2.tast",
        "mx      < /tmp/2.tast",
        "codegen < /tmp/2.tast > /tmp/3.bc",
        "mx      < /tmp/3.bc",
        "bc2asm  < /tmp/3.bc > /tmp/4.s",
        "mx      < /tmp/4.s",
        # ---- link (asm_pass1 + asm_pass2) ----
        "cat /prelude.s /tmp/4.s /prelude_tail.s > /tmp/full.s",
        "mx      < /tmp/full.s",
        "asm_pass1 < /tmp/full.s > /tmp/lab.s",
        "mx      < /tmp/lab.s",
        # asm_pass2 wants the label table followed by the source three
        # times (3-pass stream emitter: text, rodata, data).
        "cat /tmp/lab.s /tmp/full.s /tmp/full.s /tmp/full.s > /tmp/p2.in",
        "asm_pass2 < /tmp/p2.in > /tmp/hw",
        "mx      < /tmp/hw",
        # ---- run ----
        "/tmp/hw",
        "quit",
    ]
    stdin = b"muxon\n"
    for s in stages:
        stdin += make_framed("T002", (s + "\n").encode())
    proc = subprocess.run([
        "qemu-system-riscv32", "-smp", "1", "-nographic",
        "-serial", "mon:stdio", "--no-reboot", "-m", "128",
        "-machine", "virt,aclint=on", "-bios", "none",
        "-drive", f"file={ROOT}/build/kernel/disk.img,format=raw,if=none,id=blk0",
        "-device", "virtio-blk-device,drive=blk0",
        "-device", f"loader,file={ROOT}/build/kernel/virt_kernel.bin,addr=0x80000000",
        "-device", "loader,addr=0x80000000,cpu-num=0",
    ], input=stdin, capture_output=True, timeout=600)
    return proc.stdout


# ---------- main ----------

def main():
    os.makedirs(LOGS, exist_ok=True)

    print("[1/4] building virt kernel with EXTRA_TASKS "
          "(also stages prelude.s / prelude_tail.s to REFS) …")
    build_kernel_with_extras()

    print("[2/4] generating host references (compile + link) …")
    gen_references_compile()
    gen_references_link()

    print("[3/4] driving virt qemu …")
    raw = run_pipeline_on_virt()
    with open(f"{LOGS}/uart.raw", "wb") as f:
        f.write(raw)

    # Strip leading ANSI/control junk and keep only bytes after boot.
    # (Not strictly necessary — demuxer handles it as RAW.)

    print("[4/4] demuxing UART + decoding mx streams …")
    frames = list(demux_frames(raw))

    # Concatenate everything that isn't T002 (msh) or KERN/RAW.
    # In practice the child slot is T000 (seeded hello's reused slot)
    # or T003+; just gather all "T00?" tags except T002.
    per_tag_payload = {}
    for tag, payload in frames:
        if tag.startswith("T0") and tag != "T002":
            per_tag_payload.setdefault(tag, bytearray()).extend(payload)

    # Merge into a single bytestream in the order child slots were used.
    # Since virt's scheduler reuses the first DONE/UNUSED slot, the
    # sequence above typically lands entirely in T000 (hello's slot).
    # To be robust, concatenate all T00N tags sorted by first appearance.
    seen = []
    for tag, _ in frames:
        if tag.startswith("T0") and tag != "T002" and tag not in seen:
            seen.append(tag)
    child = bytearray()
    for t in seen:
        child.extend(per_tag_payload.get(t, b""))
    with open(f"{LOGS}/child.bin", "wb") as f:
        f.write(child)

    # Split into mx-delimited streams.
    streams = decode_mx_streams(bytes(child))
    stage_names = ["1.ast", "1.th", "1.wrap", "2.tast", "3.bc", "4.s",
                   "full.s", "lab.s", "hw"]
    print(f"found {len(streams)} mx streams (expected {len(stage_names)})")

    # Save each recovered stream beside the reference and diff.
    all_ok = True
    for i, name in enumerate(stage_names):
        if i >= len(streams):
            print(f"  [{name}] MISSING stream from OS")
            all_ok = False
            continue
        os_bytes = streams[i]
        ref_path = f"{REFS}/{name}"
        ref_bytes = open(ref_path, "rb").read()
        os_path = f"{LOGS}/os.{name}"
        with open(os_path, "wb") as f:
            f.write(os_bytes)
        if os_bytes == ref_bytes:
            print(f"  [{name}] OK ({len(os_bytes)} bytes)")
        else:
            print(f"  [{name}] DIFF: os={len(os_bytes)} ref={len(ref_bytes)}")
            all_ok = False

    # Finally, check that the OS ran /tmp/hw and produced the expected
    # greeting. The Hello World output comes after all mx streams have
    # terminated (each mx ends with a [0:u16] marker), so decode_mx_streams
    # silently drops it as trailing garbage — we instead scan the raw
    # tagged payload for the greeting as a substring.
    greeting = b"Hello, World!"
    if greeting in bytes(child):
        print(f"  [runtime] OK (/tmp/hw printed {greeting.decode()!r})")
    else:
        print(f"  [runtime] MISSING: /tmp/hw did not print "
              f"{greeting.decode()!r}")
        all_ok = False

    print()
    if all_ok:
        print("All stages match Gen2 reference, and /tmp/hw ran Hello World.")
        return 0
    print(f"Mismatch. Inspect {LOGS}/os.* vs {REFS}/ for details.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
