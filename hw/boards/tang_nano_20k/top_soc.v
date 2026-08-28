// top_soc.v — the SoC on the Tang Nano 20K with BSRAM as main memory
// (Phase 1/2 bring-up; SDRAM arrives in Phase 3). RAM is initialised
// from build/prog.hex at synthesis time. exit device value → LEDs.
module top_soc (
    input  wire       clk,      // 27 MHz
    input  wire [1:0] key,
    output wire [5:0] led,      // active low
    input  wire       uart_rx,
    output wire       uart_tx
);
    reg [8:0] por = 0; wire rst = ~por[8] | key[0];   // S1 (active high) = manual reset
    always @(posedge clk) if (!por[8]) por <= por + 1'b1;

    wire [31:0] exit_code; wire exit_valid; wire [31:0] pc;
    reg  [5:0]  led_r = 6'b111110;
    soc #(.RAM_WORDS(8192), .CLK_HZ(27_000_000), .BAUD(115_200), .RAM_INIT("build/prog.hex")) u_soc (
        .clk(clk), .rst(rst), .uart_rx(uart_rx), .uart_tx(uart_tx),
        .sdram_clk(), .sdram_cke(), .sdram_cs_n(), .sdram_ras_n(), .sdram_cas_n(), .sdram_we_n(), .sdram_addr(), .sdram_ba(), .sdram_dqm(), .sdram_dq(), .gpio_out(), .gpio_oe(), .gpio_in(48'b0),
        .exit_code(exit_code), .exit_valid(exit_valid), .dbg_pc(pc), .dbg_instr(), .dbg_state(), .dbg_addr(), .dbg_txcnt(), .dbg_txbusy());
    always @(posedge clk) if (exit_valid) led_r <= (exit_code == 32'h5555) ? 6'b000000 : ~exit_code[21:16];
    assign led = led_r;
endmodule
