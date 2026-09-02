// top_soc_sdram.v — the SoC with SDRAM main memory, the UART boot ROM
// (build/bootrom.hex) and the GPIO header pins for the LCD + keyboard.
// Reset with S1. LED0 = SDRAM init done, LED1 = exit device wrote 0x5555.
//
// GPIO numbering follows the pico2 board so the kernel drivers keep their
// pin constants (docs/pico2_hardware.md → docs/task/tang_nano_20k.md §4.4):
//   keyboard rows/cols GP1..GP10, GP12  → header pins 73 74 75 77 27 28 25 26 29 30 31
//   ILI9488 DC/CS/SCK/MOSI/MISO/RST/BL = GP38..GP44 → header pins 76 42 41 48 49 86 72
//   on-board microSD (SPI mode) = SoC SPI master 1 (0x1003_0000) → SDIO_D0/D3/CLK/CMD = pins 84 81 83 82
module top_soc_sdram (
    input  wire       clk27, input wire [1:0] key, output wire [5:0] led,
    input  wire       uart_rx, output wire uart_tx,
    inout  wire [10:0] kbd,      // GP1..GP10, GP12 (index 10 = GP12)
    inout  wire [6:0]  lcd,      // GP38..GP44
    input  wire        sd_miso,   // on-board microSD slot (SPI mode) ← SoC SPI master 1
    output wire        sd_cs, sd_sck, sd_mosi,
    output wire        flash_clk, flash_cs, flash_mosi,   // config SPI flash (MSPI pins 59/60/61) ← SoC SPI master
    input  wire        flash_miso,                        // MSPI MI pin 62
    output wire        O_sdram_clk, O_sdram_cke, O_sdram_cs_n, O_sdram_cas_n, O_sdram_ras_n, O_sdram_wen_n,
    output wire [10:0] O_sdram_addr, output wire [1:0] O_sdram_ba, output wire [3:0] O_sdram_dqm,
    inout  wire [31:0] IO_sdram_dq);
`ifndef UART_BAUD
`define UART_BAUD 115200
`endif
`ifndef USE_CACHE
`define USE_CACHE 1
`endif
`ifndef SYS_CLK_HZ
`define SYS_CLK_HZ 27000000
`endif
    // System clock: the 27 MHz crystal directly, or the rPLL at 40.5 MHz
    // (make SYS_CLK_HZ=40500000). Everything downstream is clocked by `clk`.
    wire clk, pll_lock;
    generate if (`SYS_CLK_HZ == 40500000) begin : g_pll
        pll_40m5 pll (.clkin(clk27), .clkout(clk), .lock(pll_lock));
    end else begin : g_nopll
        assign clk = clk27; assign pll_lock = 1'b1;
    end endgenerate
    reg [8:0] por = 0; wire rst = ~por[8] | key[0] | ~pll_lock;
    always @(posedge clk) if (!por[8]) por <= por + 1'b1;
    wire [31:0] exit_code; wire exit_valid;
    wire [47:0] go, goe; wire [47:0] gi;
    wire lcd_sck_w, lcd_mosi_w;
    soc #(.USE_SDRAM(1), .USE_CACHE(`USE_CACHE), .CLK_HZ(`SYS_CLK_HZ), .BAUD(`UART_BAUD), .RESET_PC(32'h0), .ROM_WORDS(2048), .ROM_INIT("build/bootrom.hex")) u_soc (
        .clk(clk), .rst(rst), .uart_rx(uart_rx), .uart_tx(uart_tx),
        .sdram_clk(O_sdram_clk), .sdram_cke(O_sdram_cke), .sdram_cs_n(O_sdram_cs_n), .sdram_ras_n(O_sdram_ras_n), .sdram_cas_n(O_sdram_cas_n), .sdram_we_n(O_sdram_wen_n),
        .sdram_addr(O_sdram_addr), .sdram_ba(O_sdram_ba), .sdram_dqm(O_sdram_dqm), .sdram_dq(IO_sdram_dq),
        .gpio_out(go), .gpio_oe(goe), .gpio_in(gi),
        .spi_sck(flash_clk), .spi_cs_n(flash_cs), .spi_mosi(flash_mosi), .spi_miso(flash_miso),
        .sd_sck(sd_sck), .sd_cs_n(sd_cs), .sd_mosi(sd_mosi), .sd_miso(sd_miso),
        .lcd_sck(lcd_sck_w), .lcd_mosi(lcd_mosi_w),
        .exit_code(exit_code), .exit_valid(exit_valid), .dbg_pc(), .dbg_instr(), .dbg_state(), .dbg_addr(), .dbg_txcnt(), .dbg_txbusy());
    // tristate pads
    genvar i;
    generate
        for (i = 0; i < 10; i = i + 1) begin : g_kbd
            assign kbd[i] = goe[i + 1] ? go[i + 1] : 1'bz;
        end
        for (i = 0; i < 7; i = i + 1) begin : g_lcd
            if (i == 2 || i == 3) begin : g_spi_pin
                // SCK (GP40) / MOSI (GP41) come from SPI master 2, not the GPIO block
            end else begin : g_gpio_pin
                assign lcd[i] = goe[38 + i] ? go[38 + i] : 1'bz;
            end
        end
    endgenerate
    assign kbd[10] = goe[12] ? go[12] : 1'bz;
    assign lcd[2] = lcd_sck_w;
    assign lcd[3] = lcd_mosi_w;
    assign gi = {3'b0, lcd, 25'b0, kbd[10], 1'b0, kbd[9:0], 1'b0};   // GP44..38, GP12, GP10..1
    reg ok = 0; always @(posedge clk) if (rst) ok <= 0; else if (exit_valid && exit_code == 32'h5555) ok <= 1;
    assign led = ~{4'b0, ok, u_soc.sd_init_done};
endmodule
