// top_socdbg.v — SoC with its UART TX disconnected; a hardware monitor
// prints "pc st instr addr txcnt busy\n" (hex) every ~200 ms instead.
module top_socdbg (
    input  wire       clk, input wire [1:0] key, output wire [5:0] led,
    input  wire       uart_rx, output wire uart_tx);
    reg [8:0] por = 0; wire rst = ~por[8];
    always @(posedge clk) if (!por[8]) por <= por + 1'b1;
    wire [31:0] exit_code, pc, instr, addr; wire exit_valid; wire [2:0] st; wire soc_tx; wire [7:0] txcnt; wire txbusy;
    soc #(.RAM_WORDS(8192), .CLK_HZ(27_000_000), .BAUD(115_200), .RAM_INIT("build/prog.hex")) u_soc (
        .clk(clk), .rst(rst), .uart_rx(uart_rx), .uart_tx(soc_tx),
        .sdram_clk(), .sdram_cke(), .sdram_cs_n(), .sdram_ras_n(), .sdram_cas_n(), .sdram_we_n(), .sdram_addr(), .sdram_ba(), .sdram_dqm(), .sdram_dq(),
        .exit_code(exit_code), .exit_valid(exit_valid), .dbg_pc(pc), .dbg_instr(instr), .dbg_state(st), .dbg_addr(addr),
        .dbg_txcnt(txcnt), .dbg_txbusy(txbusy));
    reg seen_exit = 0; always @(posedge clk) if (exit_valid) seen_exit <= 1;
    assign led = ~{soc_tx, 3'b0, seen_exit, st[0]};

    reg [7:0] tx_data; reg tx_valid = 0; wire tx_busy;
    uart_tx #(.CLK_HZ(27_000_000), .BAUD(115_200)) utx (.clk(clk), .rst(rst), .data(tx_data), .valid(tx_valid), .busy(tx_busy), .tx(uart_tx));
    function [7:0] hexc(input [3:0] v); hexc = (v < 10) ? (8'h30 + v) : (8'h57 + v); endfunction
    // 32 nibbles: pc(8) st(1) instr(8) addr(8) txcnt(2) busy(1) exit(1) pad(3)
    reg [127:0] snap; reg [5:0] nib; reg [1:0] ph = 0; reg [22:0] gap = 0;
    // insert spaces after nibble index 7, 8, 16, 24, 26, 27
    wire space_here = (nib == 8) || (nib == 10) || (nib == 19) || (nib == 28) || (nib == 31) || (nib == 33);
    always @(posedge clk) begin
        tx_valid <= 1'b0;
        if (rst) begin ph <= 0; gap <= 0; end
        else case (ph)
            0: begin gap <= gap + 1'b1; if (&gap) ph <= 1; end
            1: begin snap <= {pc, 1'b0, st, instr, addr, txcnt, 3'b0, txbusy, 3'b0, seen_exit, 12'h0}; nib <= 0; ph <= 2; end
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
endmodule
