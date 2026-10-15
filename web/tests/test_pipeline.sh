#!/bin/bash
# test_pipeline.sh — the integration/test_phase7.sh stage-1 pipeline
# (parse → sigscan → cat wrap → tcheck → codegen → bc2asm → asm_pass1/2/3
# → run) on kernel/build/tn20k_kernel_extra.bin, headless. Everything
# lives in mtfs + /tmp, so no SD card is needed. SKIPs without the bin.
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
KERNEL_BIN="${KERNEL_BIN:-$ROOT/kernel/build/tn20k_kernel_extra.bin}"
[ -s "$KERNEL_BIN" ] || { echo "test_pipeline: SKIP ($KERNEL_BIN missing; make -C kernel tn20k-extra)"; exit 0; }
OUT="$WEB/build"; mkdir -p "$OUT"
cat > "$OUT/pipeline_cmds.txt" <<'CMDS'
parse < /hw.tc > /tmp/1.ast
sigscan < /tmp/1.ast > /tmp/1.th
cat /empty_imports.txt /self_open.txt /tmp/1.th /wrap_close.txt /tmp/1.ast > /tmp/1.wrap
tcheck < /tmp/1.wrap > /tmp/2.tast
codegen < /tmp/2.tast > /tmp/3.bc
bc2asm < /tmp/3.bc > /tmp/4.s
cat /tmp/4.s /prelude_tail.s > /tmp/u.s
asm_pass1 /tmp/u.s --idx-out /tmp/u.idx --text-bin /tmp/u.tx --rodata-bin /tmp/u.ro --data-bin /tmp/u.dt --reloc-out /tmp/u.rl
cat /prelude.tx > /tmp/prelude.tx
cat /prelude.ro > /tmp/prelude.ro
cat /prelude.dt > /tmp/prelude.dt
cat /prelude.rl > /tmp/prelude.rl
asm_pass2 --add /prelude.idx --add /tmp/u.idx --lab-out /tmp/full.lab
asm_pass3 --lab /tmp/full.lab --out /tmp/hw
/tmp/hw
quit
CMDS
node "$WEB/src/node_run.js" "$KERNEL_BIN" --max 5000000000 --stdin "$OUT/pipeline_cmds.txt" > "$OUT/pipeline_log.txt" 2> "$OUT/pipeline_emu.txt"
rc=$?
if grep -q "Hello, World!" "$OUT/pipeline_log.txt" && [ $rc = 0 ]; then
    echo "[test] hw.tc → parse … asm_pass3 → /tmp/hw prints Hello, World!: PASS"
    grep -h "MIPS" "$OUT/pipeline_emu.txt" | sed 's/^/[test] /'
    echo "test_pipeline: PASS"
else
    echo "[test] pipeline: FAIL (rc=$rc)"; cat "$OUT/pipeline_emu.txt"; tail -30 "$OUT/pipeline_log.txt"; echo "test_pipeline: FAIL"; exit 1
fi
