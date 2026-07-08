# integration/lib/pico2_hw.sh — pico2 実機スクリプト共通ヘルパ
#
# `source` して使う (実行可能スクリプトではない)。従来 10 本の実機
# スクリプト (kernel/scripts/run_pico2*.sh, kernel/tests/test_pico2*.sh,
# integration/pico2_*.sh) に逐語コピーされていた 4 ブロックを集約:
#   1. OPENOCD / OPENOCD_SCRIPTS / UART_PORT の env デフォルト
#   2. UF2 → raw bin 抽出 (uf2_to_bin)
#   3. openocd フラッシュ + "Verified OK" 検証 (pico2_flash_halt /
#      pico2_reset_run / pico2_flash_run)
#   4. UART の stty 設定 + stale バイト drain (pico2_uart_setup /
#      pico2_uart_drain)
#
# refactor C2 (docs/task/refactor_candidates.md)。

: "${OPENOCD:=$HOME/opt/openocd-rpi/bin/openocd}"
: "${OPENOCD_SCRIPTS:=$HOME/opt/openocd-rpi/share/openocd/scripts}"
: "${UART_PORT:=/dev/ttyACM0}"
: "${PICO2_BAUD:=115200}"
# RP2350 XIP flash のロードアドレス
: "${PICO2_FLASH_BASE:=0x10000000}"

# uf2_to_bin <kernel.uf2> <out.bin>
# UF2 ブロック (magic 0x0A324655 / 0x9E5D5157) から payload を連結して
# raw bin を作る。openocd の `program` は raw bin を要求する。
uf2_to_bin() {
    python3 - "$1" "$2" << 'PY'
import sys, struct
with open(sys.argv[1], "rb") as f: data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    block = data[i:i+512]
    if len(block) < 512: break
    m1, m2 = struct.unpack_from("<II", block, 0)
    if m1 != 0x0A324655 or m2 != 0x9E5D5157: continue
    _, _, ps = struct.unpack_from("<III", block, 8)
    out.extend(block[32:32+ps])
with open(sys.argv[2], "wb") as f: f.write(out)
PY
}

# _pico2_openocd <log> <-c 引数...>
# 共通の interface/target 指定で openocd を 1 回起動する。
_pico2_openocd() {
    local log="$1"; shift
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" "$@" -c "exit" \
        > "$log" 2>&1
}

# pico2_flash_halt <bin> <log>
# reset halt → program+verify で書き込み、halt したまま返る (UART の
# キャプチャ準備を済ませてから pico2_reset_run で起動する 2 段方式)。
# 失敗時は log 末尾を stderr に出して非 0 を返す。
pico2_flash_halt() {
    local bin="$1" log="$2"
    _pico2_openocd "$log" -c "reset halt" \
        -c "program $bin $PICO2_FLASH_BASE verify" || {
        echo "pico2_flash_halt: openocd failed:" >&2
        tail -20 "$log" >&2
        return 1
    }
    if ! grep -q "Verified OK" "$log"; then
        echo "pico2_flash_halt: verify failed:" >&2
        tail -20 "$log" >&2
        return 1
    fi
    return 0
}

# pico2_reset_run [log]
pico2_reset_run() {
    local log="${1:-/dev/null}"
    _pico2_openocd "$log" -c "reset run"
}

# pico2_flash_run <bin> <log>
# フラッシュ + verify + reset run を 1 回の openocd で行う一発方式。
pico2_flash_run() {
    local bin="$1" log="$2"
    _pico2_openocd "$log" -c "reset halt" \
        -c "program $bin $PICO2_FLASH_BASE verify" -c "reset run" || {
        echo "pico2_flash_run: openocd failed:" >&2
        tail -20 "$log" >&2
        return 1
    }
    if ! grep -q "Verified OK" "$log"; then
        echo "pico2_flash_run: verify failed:" >&2
        tail -20 "$log" >&2
        return 1
    fi
    return 0
}

# pico2_uart_setup — UART_PORT を 115200 8N1 raw に設定
pico2_uart_setup() {
    stty -F "$UART_PORT" "$PICO2_BAUD" cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null || true
}

# pico2_uart_drain [seconds=0.3] — stale バイトを読み捨てる
pico2_uart_drain() {
    timeout "${1:-0.3}" cat "$UART_PORT" > /dev/null 2>&1 || true
}
