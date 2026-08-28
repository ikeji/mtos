# hw/Makefile — FPGA sub-project (Tang Nano 20K). See docs/task/tang_nano_20k.md.
#
#   make -C hw test        # simulation tests (iverilog), fast
#   make -C hw bit         # synthesize + place + pack top_blink → build/top_blink.fs
#   make -C hw flash       # program SRAM (volatile) via openFPGALoader
#   make -C hw flash-rom   # program the SPI flash (persistent)
#   make -C hw run BIN=x.bin   # run a raw bin on the SoC in iverilog (UART → stdout)
#   make -C hw TOP=top_soc PROG=x.bin bit   # SoC bitstream with x.bin in BSRAM
#
# Toolchain: oss-cad-suite (~/opt/oss-cad-suite) — override with OSS_CAD.
OSS_CAD ?= $(HOME)/opt/oss-cad-suite
export PATH := $(OSS_CAD)/bin:$(PATH)

BOARD    := tang_nano_20k
DEVICE   := GW2AR-LV18QN88C8/I7
FAMILY   := GW2A-18C
TOP      ?= top_blink
BUILD    := build
RTL_SOC  := $(wildcard rtl/soc/*.v)
RTL_CPU  := $(wildcard rtl/cpu/*.v) $(wildcard rtl/sdram/*.v)
CST      := boards/$(BOARD)/$(BOARD).cst

.DELETE_ON_ERROR:
.PHONY: all test test-soc test-riscv run bit flash flash-rom clean

all: bit

# ---- simulation -------------------------------------------------------
test: $(BUILD)/tb_uart.vvp $(BUILD)/tb_top_blink.vvp $(BUILD)/tb_sdram.vvp test-soc test-riscv
	@vvp -N $(BUILD)/tb_sdram.vvp | tee $(BUILD)/tb_sdram.log | grep -q '^PASS' || { cat $(BUILD)/tb_sdram.log; exit 1; }
	@vvp -N $(BUILD)/tb_uart.vvp | tee $(BUILD)/tb_uart.log | grep -q '^PASS' || { cat $(BUILD)/tb_uart.log; exit 1; }
	@vvp -N $(BUILD)/tb_top_blink.vvp | tee $(BUILD)/tb_top_blink.log | grep -q '^PASS' || { cat $(BUILD)/tb_top_blink.log; exit 1; }
	@echo "hw test: PASS"

SOC_SRCS := rtl/soc/soc.v rtl/soc/ram32.v rtl/soc/uart_tx.v rtl/soc/uart_rx.v rtl/cpu/rv32_core.v

$(BUILD)/tb_soc.vvp: sim/tb_soc.v $(SOC_SRCS) | $(BUILD)
	iverilog -g2012 -o $@ $^

$(BUILD)/smoke.bin: tools/mkasm_smoke.py | $(BUILD)
	python3 $< $@

# ---- TC programs for the SoC (compile-gen2.sh with the tn20k crt0) ----
ROOT     := ..
GEN2_DIR ?= $(ROOT)/compiler/build/gen2
TC_CRT0  := sw/crt0_tn20k.s
# make tc BIN=build/hello2.bin from compiler/tests/hello2.tc etc.
$(BUILD)/%.bin: $(ROOT)/compiler/tests/%.tc $(TC_CRT0) | $(BUILD)
	cd $(ROOT) && CRT0=hw/$(TC_CRT0) ASM_PROLOGUE='; raw' GEN2_DIR=compiler/build/gen2 \
	    ./compiler/scripts/compile-gen2.sh -o hw/$@ compiler/tests/$*.tc 2>/dev/null

# make run BIN=path/to/raw.bin [TIMEOUT=cycles]
BIN ?= $(BUILD)/smoke.bin
TIMEOUT ?= 2000000
run: $(BUILD)/tb_soc.vvp $(BIN)
	python3 tools/bin2hex.py $(BIN) $(BUILD)/run.hex
	vvp -N $(BUILD)/tb_soc.vvp +hex=$(BUILD)/run.hex +timeout=$(TIMEOUT)

# TC programs are only run when the Gen2 toolchain has been built
# (`make -C compiler gen2`); otherwise just the hand-encoded smoke.
TC_TESTS := $(if $(wildcard $(GEN2_DIR)/asm_pass3),hello2 test_timer,)
test-soc: $(BUILD)/tb_soc.vvp $(BUILD)/smoke.bin $(addprefix $(BUILD)/,$(addsuffix .bin,$(TC_TESTS)))
	@python3 tools/bin2hex.py $(BUILD)/smoke.bin $(BUILD)/smoke.hex
	@vvp -N $(BUILD)/tb_soc.vvp +hex=$(BUILD)/smoke.hex 2>&1 | grep -q '^\[tb\] PASS' || { echo "test-soc: smoke FAIL"; exit 1; }
	@for t in $(TC_TESTS); do \
	    python3 tools/bin2hex.py $(BUILD)/$$t.bin $(BUILD)/$$t.hex; \
	    vvp -N $(BUILD)/tb_soc.vvp +hex=$(BUILD)/$$t.hex +timeout=60000000 > $(BUILD)/$$t.log 2>&1; \
	    grep -q '^\[tb\] PASS' $(BUILD)/$$t.log || { echo "test-soc: $$t FAIL"; tail -5 $(BUILD)/$$t.log; exit 1; }; \
	    echo "test-soc: $$t PASS"; \
	done

# riscv-tests rv32ui/rv32um (skipped unless third_party/riscv-tests is cloned)
test-riscv: $(BUILD)/tb_soc.vvp
	@if [ -d third_party/riscv-tests/isa ]; then tests/run_riscv_tests.sh | tail -1; else echo "riscv-tests: SKIP (git clone --depth 1 https://github.com/riscv-software-src/riscv-tests.git hw/third_party/riscv-tests)"; fi

$(BUILD)/tb_sdram.vvp: sim/tb_sdram.v sim/sdram_model.v rtl/sdram/sdram_ctrl.v | $(BUILD)
	iverilog -g2012 -o $@ $^

$(BUILD)/tb_top_blink.vvp: sim/tb_top_blink.v boards/$(BOARD)/top_blink.v rtl/soc/uart_tx.v rtl/soc/uart_rx.v | $(BUILD)
	iverilog -g2012 -o $@ $^

$(BUILD)/tb_uart.vvp: sim/tb_uart.v rtl/soc/uart_tx.v rtl/soc/uart_rx.v | $(BUILD)
	iverilog -g2012 -o $@ $^

# ---- synthesis ---------------------------------------------------------
PROG ?= $(BUILD)/smoke.bin
$(BUILD)/prog.hex: $(PROG) | $(BUILD)
	python3 tools/bin2hex.py $< $@

$(BUILD)/$(TOP).json: boards/$(BOARD)/$(TOP).v $(RTL_SOC) $(RTL_CPU) $(BUILD)/prog.hex | $(BUILD)
	yosys -q -l $(BUILD)/$(TOP).yosys.log -p "read_verilog -sv $(filter %.v,$^); synth_gowin -top $(TOP) -json $@"

$(BUILD)/$(TOP)_pnr.json: $(BUILD)/$(TOP).json $(CST)
	nextpnr-himbaechel -q -l $(BUILD)/$(TOP).pnr.log --json $< --write $@ \
	    --device $(DEVICE) --vopt family=$(FAMILY) --vopt cst=$(CST) --freq 27

$(BUILD)/$(TOP).fs: $(BUILD)/$(TOP)_pnr.json
	gowin_pack -d $(FAMILY) -o $@ $<

bit: $(BUILD)/$(TOP).fs

flash: $(BUILD)/$(TOP).fs
	openFPGALoader -b tangnano20k $<

flash-rom: $(BUILD)/$(TOP).fs
	openFPGALoader -b tangnano20k -f $<

$(BUILD):
	mkdir -p $@

clean:
	rm -rf $(BUILD)
