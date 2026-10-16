# web/Makefile — browser emulator sub-project. See docs/task/web_emulator.md.
#
#   make -C web test                 # riscv-tests + tn20k kernel boot (Node) + Worker core + headless Chromium page
#   make -C web test-boot            # just the kernel boot (needs kernel/build/tn20k_kernel.bin)
#   make -C web test-browser         # page smoke test in headless Chromium (needs playwright; SKIPs otherwise)
#   make -C web test-sd              # SD card + FAT32 image round trip (tools/fatimg.py)
#   make -C web test-pipeline        # 15-stage compiler pipeline on tn20k_kernel_extra.bin (hw.tc → Hello, World!)
#   make -C web test-console         # LCD console kernels: matrix keyboard → /bin/console → LCD (OCR'd back)
#   make -C web serve                # serve the repo root on :8000 → http://localhost:8000/web/
#   node web/src/node_run.js x.bin   # run a raw bin headless (UART → stdout)
#
# No build step: plain ES modules, Node >= 18 for the headless runner.
# Not part of the root `make test` (needs node + riscv64-unknown-elf-gcc).

.PHONY: all test test-riscv test-boot test-sd test-pipeline test-console test-runner test-browser serve clean

all:
	@echo "nothing to build (plain ES modules); try: make -C web test"

test: test-riscv test-boot test-sd test-pipeline test-console test-runner test-browser

test-riscv:
	@tests/run_riscv_tests.sh

test-boot:
	@tests/test_boot.sh

test-sd:
	@tests/test_sd.sh

test-pipeline:
	@tests/test_pipeline.sh

test-console:
	@tests/test_console.sh

test-runner:
	@tests/test_runner.sh

test-browser:
	@tests/test_browser.sh

PORT ?= 8000
serve:
	@echo "open http://localhost:$(PORT)/web/" >&2
	python3 -m http.server $(PORT) --bind 127.0.0.1 -d ..

clean:
	rm -rf build
