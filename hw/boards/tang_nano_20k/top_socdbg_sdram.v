// top_socdbg_sdram.v — top_soc_sdram plus a hang monitor: whenever the
// SoC's UART TX has been idle for ~2 s, the monitor takes over the TX
// pin and prints "pc st instr addr\n" (hex) every ~250 ms until the
// SoC transmits again. Load programs exactly as with top_soc_sdram.
module top_socdbg_sdram (
    input  wire       clk, input wire [1:0] key, output wire [5:0] led,
    input  wire       uart_rx, output wire uart_tx,
    output wire        O_sdram_clk, O_sdram_cke, O_sdram_cs_n, O_sdram_cas_n, O_sdram_ras_n, O_sdram_wen_n,
    output wire [10:0] O_sdram_addr, output wire [1:0] O_sdram_ba, output wire [3:0] O_sdram_dqm,
    inout  wire [31:0] IO_sdram_dq);
    reg [8:0] por = 0; wire rst = ~por[8] | key[0];
    always @(posedge clk) if (!por[8]) por <= por + 1'b1;
    wire [31:0] exit_code, pc, instr, addr; wire exit_valid; wire [2:0] st; wire soc_tx; wire [7:0] txcnt; wire txbusy;
    soc #(.USE_SDRAM(1), .CLK_HZ(27_000_000), .BAUD(921_600), .RESET_PC(32'h0), .ROM_WORDS(2048), .ROM_INIT("build/bootrom.hex")) u_soc (
        .clk(clk), .rst(rst), .uart_rx(uart_rx), .uart_tx(soc_tx),
        .sdram_clk(O_sdram_clk), .sdram_cke(O_sdram_cke), .sdram_cs_n(O_sdram_cs_n), .sdram_ras_n(O_sdram_ras_n), .sdram_cas_n(O_sdram_cas_n), .sdram_we_n(O_sdram_wen_n),
        .sdram_addr(O_sdram_addr), .sdram_ba(O_sdram_ba), .sdram_dqm(O_sdram_dqm), .sdram_dq(IO_sdram_dq), .gpio_out(), .gpio_oe(), .gpio_in(48'b0), .spi_sck(), .spi_cs_n(), .spi_mosi(), .spi_miso(1'b1),
        .exit_code(exit_code), .exit_valid(exit_valid), .dbg_pc(pc), .dbg_instr(instr), .dbg_state(st), .dbg_addr(addr), .dbg_txcnt(txcnt), .dbg_txbusy(txbusy));
    // idle detector: ~2 s (2^26 clocks) without SoC UART activity
    reg [25:0] idle = 0; wire hung = idle[25];
    always @(posedge clk) if (rst || txbusy) idle <= 0; else if (!hung) idle <= idle + 1'b1;
    reg [7:0] tx_data; reg tx_valid = 0; wire tx_busy; wire mon_tx;
    uart_tx #(.CLK_HZ(27_000_000), .BAUD(921_600)) utx (.clk(clk), .rst(rst), .data(tx_data), .valid(tx_valid), .busy(tx_busy), .tx(mon_tx));
    assign uart_tx = hung ? mon_tx : soc_tx;
    function [7:0] hexc(input [3:0] v); hexc = (v < 10) ? (8'h30 + v) : (8'h57 + v); endfunction
    reg [127:0] snap; reg [5:0] nib; reg [1:0] ph = 0; reg [22:0] gap = 0;
    wire space_here = (nib == 8) || (nib == 10) || (nib == 19) || (nib == 28) || (nib == 31) || (nib == 33);
    always @(posedge clk) begin
        tx_valid <= 1'b0;
        if (rst || !hung) begin ph <= 0; gap <= 0; end
        else case (ph)
            0: begin gap <= gap + 1'b1; if (&gap) ph <= 1; end
            1: begin snap <= {pc, 1'b0, st, instr, addr, txcnt, 3'b0, txbusy, 3'b0, exit_valid, 12'h0}; nib <= 0; ph <= 2; end
            2: if (!tx_busy && !tx_valid) begin
                   if (nib == 36) begin tx_data <= 8'h0a; tx_valid <= 1; ph <= 0; end
                   else begin
                       if (space_here) tx_data <= 8'h20;
                       else begin tx_data <= hexc(snap[127:124]); snap <= snap << 4; end
                       tx_valid <= 1; nib <= nib + 1'b1;
                   end
               end
        endcase
    end
    assign led = ~{4'b0, hung, u_soc.sd_init_done};
endmodule
