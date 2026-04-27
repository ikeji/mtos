// sd_probe.c — pico-sdk reference implementation of the same SD card
// connectivity smoke test that kernel/tasks/sdprobe/sdprobe.tc does.
//
// Wiring (matches docs/pico2_hardware.md):
//   GP4 (Pin 6)  → MISO
//   GP5 (Pin 7)  → CS    (SIO output, manual control)
//   GP6 (Pin 9)  → SCK
//   GP7 (Pin 10) → MOSI
//   3V3  (Pin 36) → module 3V3
//   GND           → GND
//
// UART output: GP0 TX / GP1 RX @ 115200 (Debug Probe CDC-ACM as usual).
//
// If this returns CMD0 R1 = 0x01 with the same hardware that the
// kernel-side sdprobe sees as 0xFF, our TC kernel's SPI code path
// has a bug. If both report 0xFF, the module/card/wiring is the
// problem.

#include <stdio.h>
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

// Send one byte, return one byte.
static uint8_t spi_xfer(uint8_t b) {
    uint8_t r;
    spi_write_read_blocking(spi0, &b, &r, 1);
    return r;
}

static uint8_t send_cmd(uint8_t cmd, uint32_t arg, uint8_t crc) {
    cs_low();
    spi_xfer(0xFF);  // dummy clock byte after CS=L
    spi_xfer(0x40 | cmd);
    spi_xfer((arg >> 24) & 0xFF);
    spi_xfer((arg >> 16) & 0xFF);
    spi_xfer((arg >>  8) & 0xFF);
    spi_xfer( arg        & 0xFF);
    spi_xfer(crc);
    // Poll for response (NCR up to 8 bytes)
    uint8_t r1 = 0xFF;
    for (int i = 0; i < 16; i++) {
        r1 = spi_xfer(0xFF);
        if ((r1 & 0x80) == 0) break;
    }
    return r1;
}

int main() {
    stdio_init_all();
    sleep_ms(2000);  // give the host time to attach to the UART

    printf("\n=== sd_probe (pico-sdk reference) ===\n");
    printf("clk_sys = %u Hz\n", clock_get_hz(clk_sys));
    printf("clk_peri = %u Hz\n", clock_get_hz(clk_peri));

    // Configure CS as GPIO output, idle high.
    gpio_init(PIN_CS);
    gpio_set_dir(PIN_CS, GPIO_OUT);
    gpio_put(PIN_CS, 1);

    // SPI0 at 400 kHz, mode 0, 8-bit. spi_init() takes care of the
    // RESETS sequence, clk_peri sourcing, and SSPCRn setup.
    uint actual = spi_init(spi0, 400 * 1000);
    spi_set_format(spi0, 8, SPI_CPOL_0, SPI_CPHA_0, SPI_MSB_FIRST);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK,  GPIO_FUNC_SPI);
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);
    printf("SPI0 actual = %u Hz\n", actual);

    // 80 init clocks with CS=H, MOSI=H. spi_write_blocking will keep
    // MOSI driven by whatever bytes we send (0xFF here = MOSI high).
    uint8_t hi[10];
    for (int i = 0; i < 10; i++) hi[i] = 0xFF;
    cs_high();
    spi_write_blocking(spi0, hi, sizeof(hi));

    // CMD0 (GO_IDLE_STATE) up to 5 attempts.
    uint8_t r1 = 0xFF;
    for (int attempt = 0; attempt < 5; attempt++) {
        r1 = send_cmd(0, 0, 0x95);
        cs_high();
        spi_xfer(0xFF);
        printf("CMD0[%d] R1 = 0x%02X\n", attempt, r1);
        if (r1 == 0x01) break;
        sleep_ms(2);
    }

    if (r1 != 0x01) {
        printf("WARN: CMD0 never returned 0x01 (got 0x%02X). Continuing to CMD8 anyway.\n", r1);
    }

    // CMD8 (SEND_IF_COND): 2.7-3.6 V, check pattern 0xAA.
    cs_low();
    spi_xfer(0xFF);
    spi_xfer(0x48);
    spi_xfer(0x00);
    spi_xfer(0x00);
    spi_xfer(0x01);
    spi_xfer(0xAA);
    spi_xfer(0x87);
    uint8_t r1b = 0xFF;
    uint8_t echo[4] = {0};
    for (int i = 0; i < 16; i++) {
        uint8_t b = spi_xfer(0xFF);
        if ((b & 0x80) == 0) { r1b = b; break; }
    }
    if (r1b != 0xFF) {
        for (int i = 0; i < 4; i++) echo[i] = spi_xfer(0xFF);
    }
    cs_high();
    spi_xfer(0xFF);
    printf("CMD8 R1 = 0x%02X echo = %02X %02X %02X %02X\n",
           r1b, echo[0], echo[1], echo[2], echo[3]);

    if (r1b == 0x01 && echo[2] == 0x01 && echo[3] == 0xAA) {
        printf("OK: v2 SDHC card, ready for ACMD41\n");
    } else if (r1b == 0x05) {
        printf("OK: v1 / MMC card (CMD8 illegal)\n");
    } else {
        printf("WARN: unexpected CMD8 response\n");
    }

    // ACMD41 init loop: CMD55 (APP_CMD) + ACMD41 (SD_SEND_OP_COND).
    // For v2 cards we set HCS=1 (0x40000000). Repeat until R1 == 0x00.
    printf("ACMD41 init loop:\n");
    for (int i = 0; i < 100; i++) {
        // CMD55: tells card the next command is app-specific.
        cs_low(); spi_xfer(0xFF);
        spi_xfer(0x77); spi_xfer(0); spi_xfer(0); spi_xfer(0); spi_xfer(0);
        spi_xfer(0x65);
        uint8_t a = 0xFF;
        for (int k = 0; k < 8; k++) { a = spi_xfer(0xFF); if (!(a&0x80)) break; }
        cs_high(); spi_xfer(0xFF);
        // ACMD41 with HCS bit
        cs_low(); spi_xfer(0xFF);
        spi_xfer(0x69);
        spi_xfer(0x40); spi_xfer(0); spi_xfer(0); spi_xfer(0);
        spi_xfer(0x77);
        uint8_t b = 0xFF;
        for (int k = 0; k < 8; k++) { b = spi_xfer(0xFF); if (!(b&0x80)) break; }
        cs_high(); spi_xfer(0xFF);
        if (i < 5 || (i % 20) == 0) {
            printf("  iter %d: CMD55 R1=0x%02X  ACMD41 R1=0x%02X\n", i, a, b);
        }
        if (b == 0x00) {
            printf("OK: card initialized after %d iterations\n", i+1);
            break;
        }
        sleep_ms(10);
    }

    while (1) tight_loop_contents();
}
