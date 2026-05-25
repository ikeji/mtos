# kernel/

OS カーネル。qemu virt (`-M virt`) と Raspberry Pi Pico 2 (RP2350 RISC-V)
の 2 プラットフォーム共通。プリエンプティブマルチタスク。

## 構成

- `src/` — kernel core (両プラットフォーム共通)
  - kernel.tc / kernel_pico2.tc / kernel_common.tc — main + scheduler
  - vfs.tc, tmpfs.tc, procfs.tc, mtfs.tc, fatfs.tc, devfs.tc, loader.tc,
    rtc.tc, trap_common.s
- `platform/virt/` — qemu virt 固有 (platform_virt.{s,tc}, crt0_data.s,
  block_virtio.tc, block_fat_*.tc, dev_backend_virt.tc)
- `platform/pico2/` — RP2350 固有 (platform_pico2.{s,tc}, crt0_pico2_data.s,
  block_flash.tc, block_sd.tc, display_ili9488.tc, keyboard_matrix.tc,
  rtc_ds3231.tc)
- `scripts/` — build.sh + run_pico2{,_interactive}.sh + bin2s{,_incbin}.sh
  + genjpfont.py
- `tools-src/` — kernel build 時に使う TC ホストツール (mkfs.tc, bin2uf2.tc)
- `tests/` — kernel 単体テスト (test_os, test_pico2*, fb_render.py + fixtures/)

## ビルド

```bash
make -C kernel              # virt + pico2 両方 build (default)
make -C kernel virt         # build/kernel/virt_kernel.bin のみ
make -C kernel pico2        # build/kernel/pico2_kernel.uf2 のみ
make -C kernel pico2-extra  # + EXTRA_GUEST_TASKS (parse/sigscan/...)
make -C kernel pico2-demo   # + disk-demo.img (kern_demo.conf 駆動 init)
make -C kernel pico2-console{,-land}  # LCD console 込み
make -C kernel run          # virt kernel を対話起動 (qemu)
make -C kernel run-pico2    # pico2 kernel を flash + UART
make -C kernel flash        # 既存 UF2 を再 flash (build 無し)
make -C kernel test         # test_os のみ (~10s, 8 tests)
```

## 統一 build script

```bash
GEN2_DIR=/path/to/gen2 ./kernel/scripts/build.sh --target virt  -o kernel.bin
GEN2_DIR=/path/to/gen2 ./kernel/scripts/build.sh --target pico2 -o kernel.uf2
```

詳細は `../docs/kernel.md`、`../docs/filesystem.md`、設計は
`../docs/task/subproject_split.md`。
