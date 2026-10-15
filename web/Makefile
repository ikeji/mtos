# web/Makefile — browser emulator sub-project. See docs/task/web_emulator.md.
#
#   make -C web test                 # riscv-tests (rv32ui + rv32um) + tn20k kernel boot, via Node
#   make -C web test-boot            # just the kernel boot (needs kernel/build/tn20k_kernel.bin)
#   node web/src/node_run.js x.bin   # run a raw bin headless (UART → stdout)
#
# No build step: plain ES modules, Node >= 18 for the headless runner.
# Not part of the root `make test` (needs node + riscv64-unknown-elf-gcc).

.PHONY: all test test-riscv test-boot clean

all:
	@echo "nothing to build (plain ES modules); try: make -C web test"

test: test-riscv test-boot

test-riscv:
	@tests/run_riscv_tests.sh

test-boot:
	@tests/test_boot.sh

clean:
	rm -rf build
