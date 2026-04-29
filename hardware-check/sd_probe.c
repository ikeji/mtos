// sd_probe.c — pico-sdk reference implementation of SD SPI bring-up.
//
// Wiring (matches docs/pico2_hardware.md):
//   GP4 (Pin 6)  → MISO
//   GP5 (Pin 7)  → CS    (manual SIO output)
//   GP6 (Pin 9)  → SCK
//   GP7 (Pin 10) → MOSI
//   3V3 (Pin 36) → module 3V3
//   GND          → GND
//
// Goal: complete CMD0 → CMD8 → ACMD41 → CMD58 → CMD17 chain and read
// the first 512-byte block (the MBR / FAT boot sector).

#include <stdio.h>
#include <string.h>
#include "pico/stdlib.h"
#include "hardware/spi.h"
#include "hardware/gpio.h"
#include "hardware/clocks.h"

#define PIN_MISO 4
#define PIN_CS   5
#define PIN_SCK  6
#define PIN_MOSI 7

static inline void cs_low(void)  { gpio_put(PIN_CS, 0); }
static inline void cs_high(void) { gpio_put(PIN_CS, 1); }

static uint8_t spi_xfer(uint8_t b) {
    uint8_t r;
    spi_write_read_blocking(spi0, &b, &r, 1);
    return r;
}

// Send a 6-byte SD command frame and return R1.
static uint8_t send_cmd(uint8_t cmd, uint32_t arg, uint8_t crc) {
    cs_low();
    spi_xfer(0xFF);
    spi_xfer(0x40 | cmd);
    spi_xfer((arg >> 24) & 0xFF);
    spi_xfer((arg >> 16) & 0xFF);
    spi_xfer((arg >>  8) & 0xFF);
    spi_xfer( arg        & 0xFF);
    spi_xfer(crc);
    uint8_t r1 = 0xFF;
    for (int i = 0; i < 16; i++) {
        r1 = spi_xfer(0xFF);
        if ((r1 & 0x80) == 0) break;
    }
    return r1;
}

static void cs_high_with_clock(void) {
    cs_high();
    spi_xfer(0xFF);
}

int main() {
    stdio_init_all();
    sleep_ms(1500);
    printf("\n=== sd_probe v3: full SD bring-up ===\n");

    gpio_init(PIN_CS);
    gpio_set_dir(PIN_CS, GPIO_OUT);
    cs_high();
    spi_init(spi0, 400 * 1000);
    spi_set_format(spi0, 8, SPI_CPOL_0, SPI_CPHA_0, SPI_MSB_FIRST);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK,  GPIO_FUNC_SPI);
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);
    gpio_pull_up(PIN_MISO);
    printf("SPI0 @ 400 kHz initialized.\n");

    // 1. Send 80 init clocks with CS=H, MOSI=H.
    cs_high();
    for (int i = 0; i < 10; i++) spi_xfer(0xFF);

    // 2. CMD0: enter idle state.
    uint8_t r1 = 0xFF;
    for (int attempt = 0; attempt < 5; attempt++) {
        r1 = send_cmd(0, 0, 0x95);
        cs_high_with_clock();
        if (r1 == 0x01) break;
        sleep_ms(2);
    }
    printf("CMD0 R1 = 0x%02X %s\n", r1, r1 == 0x01 ? "(idle OK)" : "(unexpected)");
    if (r1 != 0x01) { printf("Aborting.\n"); while (1) tight_loop_contents(); }

    // 3. CMD8: voltage check (mandatory for SDHC/SDXC).
    cs_low();
    spi_xfer(0xFF);
    spi_xfer(0x48);
    spi_xfer(0x00); spi_xfer(0x00); spi_xfer(0x01); spi_xfer(0xAA);
    spi_xfer(0x87);
    uint8_t cmd8_r1 = 0xFF;
    for (int i = 0; i < 16; i++) {
        cmd8_r1 = spi_xfer(0xFF);
        if ((cmd8_r1 & 0x80) == 0) break;
    }
    uint8_t cmd8_echo[4] = {0};
    if (cmd8_r1 != 0xFF) {
        for (int i = 0; i < 4; i++) cmd8_echo[i] = spi_xfer(0xFF);
    }
    cs_high_with_clock();
    printf("CMD8 R1 = 0x%02X echo = %02X %02X %02X %02X\n",
           cmd8_r1, cmd8_echo[0], cmd8_echo[1], cmd8_echo[2], cmd8_echo[3]);
    int v2_card = (cmd8_r1 == 0x01 && cmd8_echo[2] == 0x01 && cmd8_echo[3] == 0xAA);

    // 4. ACMD41 init loop: CMD55 (APP_CMD) + ACMD41 (HCS=1 if v2).
    printf("ACMD41 init loop (HCS=%d)...\n", v2_card);
    int initialized = 0;
    for (int i = 0; i < 1000; i++) {
        // CMD55
        uint8_t r55 = send_cmd(55, 0, 0x65);
        cs_high_with_clock();
        // ACMD41 with HCS bit if v2 card
        uint8_t r41 = send_cmd(41, v2_card ? 0x40000000 : 0, 0x77);
        cs_high_with_clock();
        if (r41 == 0x00) { initialized = 1;
            printf("Card initialized after %d iterations\n", i + 1);
            break;
        }
        sleep_ms(5);
    }
    if (!initialized) {
        printf("ACMD41 timed out (R1 stuck)\n");
        while (1) tight_loop_contents();
    }

    // 5. CMD58: read OCR to find CCS bit (SDHC vs SDSC).
    int sdhc = 0;
    if (v2_card) {
        cs_low();
        spi_xfer(0xFF);
        spi_xfer(0x40 | 58);
        spi_xfer(0); spi_xfer(0); spi_xfer(0); spi_xfer(0);
        spi_xfer(0xFD);
        uint8_t r58_r1 = 0xFF;
        for (int i = 0; i < 16; i++) {
            r58_r1 = spi_xfer(0xFF);
            if ((r58_r1 & 0x80) == 0) break;
        }
        uint8_t ocr[4] = {0};
        for (int i = 0; i < 4; i++) ocr[i] = spi_xfer(0xFF);
        cs_high_with_clock();
        sdhc = (ocr[0] & 0x40) != 0;
        printf("CMD58 R1=0x%02X OCR=%02X %02X %02X %02X (SDHC=%d)\n",
               r58_r1, ocr[0], ocr[1], ocr[2], ocr[3], sdhc);
    }

    // 6. Bump SPI clock now that init is done (SD spec allows up to 25 MHz
    //    for default speed, but RP2350 SPI from XOSC=12MHz / clk_peri=150
    //    MHz here. Use 12 MHz for safety on breadboard.)
    uint actual_hi = spi_set_baudrate(spi0, 12 * 1000 * 1000);
    printf("Bumped SPI to %u Hz\n", actual_hi);

    // 7. CMD17 (READ_SINGLE_BLOCK) at LBA 0.
    uint32_t arg = sdhc ? 0 : 0;  // SDHC = block addr, SDSC = byte addr; both 0
    cs_low();
    spi_xfer(0xFF);
    spi_xfer(0x40 | 17);
    spi_xfer(arg >> 24); spi_xfer(arg >> 16);
    spi_xfer(arg >> 8); spi_xfer(arg);
    spi_xfer(0xFF);
    uint8_t r17 = 0xFF;
    for (int i = 0; i < 16; i++) {
        r17 = spi_xfer(0xFF);
        if ((r17 & 0x80) == 0) break;
    }
    printf("CMD17 R1=0x%02X\n", r17);
    if (r17 == 0) {
        // Wait for data token (0xFE)
        uint8_t tok = 0xFF;
        for (int i = 0; i < 5000; i++) {
            tok = spi_xfer(0xFF);
            if (tok != 0xFF) break;
        }
        printf("data token = 0x%02X\n", tok);
        if (tok == 0xFE) {
            uint8_t buf[512];
            for (int i = 0; i < 512; i++) buf[i] = spi_xfer(0xFF);
            uint8_t crc_hi = spi_xfer(0xFF);
            uint8_t crc_lo = spi_xfer(0xFF);
            (void)crc_hi; (void)crc_lo;
            printf("first 32 bytes of LBA 0:\n  ");
            for (int i = 0; i < 32; i++) printf("%02X ", buf[i]);
            printf("\n");
            // Boot sector signature at offset 510-511 should be 0x55 0xAA
            printf("boot signature [510]=0x%02X [511]=0x%02X %s\n",
                   buf[510], buf[511],
                   (buf[510] == 0x55 && buf[511] == 0xAA) ? "✓" : "(no MBR/FAT signature)");
        }
    }
    cs_high_with_clock();

    printf("\n=== bring-up complete ===\n");
    while (1) tight_loop_contents();
}
