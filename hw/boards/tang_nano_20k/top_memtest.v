// top_memtest.v — SDRAM bring-up: fill all 2M words with f(addr, pass),
// read back, report "<pass> <errors> <first_bad_addr>\n" over the UART, repeat
// with a different pattern each pass. LED0 toggles per pass, LED1 = error seen.
module top_memtest (
    input  wire       clk, input wire [1:0] key, output wire [5:0] led,
    input  wire       uart_rx, output wire uart_tx,
    output wire        O_sdram_clk, O_sdram_cke, O_sdram_cs_n, O_sdram_cas_n, O_sdram_ras_n, O_sdram_wen_n,
    output wire [10:0] O_sdram_addr, output wire [1:0] O_sdram_ba, output wire [3:0] O_sdram_dqm,
    inout  wire [31:0] IO_sdram_dq);
    reg [8:0] por = 0; wire rst = ~por[8];
    always @(posedge clk) if (!por[8]) por <= por + 1'b1;

    reg valid = 0; wire ready; reg [20:0] addr = 0; reg [31:0] wdata; reg [3:0] wstrb; wire [31:0] rdata; wire init_done;
    sdram_ctrl #(.CLK_HZ(27_000_000)) ctrl (.clk(clk), .rst(rst), .valid(valid), .ready(ready), .addr(addr), .wdata(wdata), .wstrb(wstrb), .rdata(rdata), .init_done(init_done),
        .sdram_clk(O_sdram_clk), .sdram_cke(O_sdram_cke), .sdram_cs_n(O_sdram_cs_n), .sdram_ras_n(O_sdram_ras_n), .sdram_cas_n(O_sdram_cas_n), .sdram_we_n(O_sdram_wen_n),
        .sdram_addr(O_sdram_addr), .sdram_ba(O_sdram_ba), .sdram_dqm(O_sdram_dqm), .sdram_dq(IO_sdram_dq));

    reg [7:0] pass = 0; reg [31:0] errors = 0; reg [31:0] first_bad = 32'hFFFFFFFF; reg err_seen = 0;
    function [31:0] pat(input [20:0] a, input [7:0] p);
        pat = ({a, ~a[10:0]} ^ {p, p, p, p} ^ (a << 7)) ^ (p[0] ? 32'hFFFFFFFF : 32'h0);
    endfunction
    wire hbusy; reg hgo = 0; reg [31:0] hval; reg [7:0] htail;
    uart_hexout hx (.clk(clk), .rst(rst), .go(hgo), .value(hval), .tail(htail), .busy(hbusy), .tx(uart_tx));
    reg [3:0] st = 0;
    always @(posedge clk) begin
        hgo <= 0;
        if (rst) begin st <= 0; valid <= 0; addr <= 0; pass <= 0; errors <= 0; err_seen <= 0; end
        else case (st)
            0: if (init_done) begin st <= 1; addr <= 0; end
            1: begin wdata <= pat(addr, pass); wstrb <= 4'hF; valid <= 1; st <= 2; end       // write
            2: if (ready) begin valid <= 0; if (addr == 21'h1FFFFF) begin addr <= 0; st <= 3; end else begin addr <= addr + 1'b1; st <= 1; end end
            3: begin wstrb <= 4'h0; valid <= 1; st <= 4; end                                 // read
            4: if (ready) begin
                   valid <= 0;
                   if (rdata != pat(addr, pass)) begin
                       errors <= errors + 1'b1; err_seen <= 1;
                       if (first_bad == 32'hFFFFFFFF) first_bad <= {11'b0, addr};
                   end
                   if (addr == 21'h1FFFFF) begin addr <= 0; st <= 5; end else begin addr <= addr + 1'b1; st <= 3; end
               end
            5: if (!hbusy) begin hval <= {24'b0, pass}; htail <= " "; hgo <= 1; st <= 6; end
            6: if (!hbusy && !hgo) begin hval <= errors; htail <= " "; hgo <= 1; st <= 7; end
            7: if (!hbusy && !hgo) begin hval <= first_bad; htail <= "\n"; hgo <= 1; st <= 8; end
            8: if (!hbusy && !hgo) begin pass <= pass + 1'b1; errors <= 0; first_bad <= 32'hFFFFFFFF; st <= 1; end
        endcase
    end
    assign led = ~{4'b0, err_seen, pass[0]};
endmodule
