`timescale 1ns/1ps
module tb_sdram;
    reg clk = 0; always #18.5 clk = ~clk;
    reg rst = 1;
    reg valid = 0; wire ready; reg [20:0] addr; reg [31:0] wdata; reg [3:0] wstrb; wire [31:0] rdata; wire init_done;
    wire sclk, cke, cs_n, ras_n, cas_n, we_n; wire [10:0] sa; wire [1:0] ba; wire [3:0] dqm; wire [31:0] dq;
    sdram_ctrl #(.CLK_HZ(27_000_000)) ctrl (.clk(clk), .rst(rst), .valid(valid), .ready(ready), .addr(addr), .wdata(wdata), .wstrb(wstrb), .rdata(rdata), .init_done(init_done),
        .sdram_clk(sclk), .sdram_cke(cke), .sdram_cs_n(cs_n), .sdram_ras_n(ras_n), .sdram_cas_n(cas_n), .sdram_we_n(we_n), .sdram_addr(sa), .sdram_ba(ba), .sdram_dqm(dqm), .sdram_dq(dq));
    sdram_model mdl (.clk(sclk), .cke(cke), .cs_n(cs_n), .ras_n(ras_n), .cas_n(cas_n), .we_n(we_n), .addr(sa), .ba(ba), .dqm(dqm), .dq(dq));
    integer errors = 0, n;
    task xfer(input [20:0] a, input [31:0] d, input [3:0] s); begin
        @(posedge clk); addr <= a; wdata <= d; wstrb <= s; valid <= 1;
        @(posedge clk); while (!ready) @(posedge clk); valid <= 0;
    end endtask
    task check(input [20:0] a, input [31:0] want); begin
        xfer(a, 0, 0);
        if (rdata !== want) begin errors = errors + 1; if (errors < 10) $display("MISMATCH @%h got %h want %h", a, rdata, want); end
    end endtask
    initial begin
        repeat (4) @(posedge clk); rst = 0;
        wait (init_done); repeat (10) @(posedge clk);
        // word writes across banks/rows/cols, then read back
        for (n = 0; n < 64; n = n + 1) xfer(n * 21'h12345 + n, 32'hA5A50000 + n, 4'hF);
        for (n = 0; n < 64; n = n + 1) check(n * 21'h12345 + n, 32'hA5A50000 + n);
        // byte-masked write
        xfer(21'h100, 32'h11223344, 4'hF);
        xfer(21'h100, 32'hFFEEDDCC, 4'b0010);
        check(21'h100, 32'h1122DD44);
        // long run to cross refresh
        for (n = 0; n < 3000; n = n + 1) xfer(n, n ^ 32'hDEADBEEF, 4'hF);
        for (n = 0; n < 3000; n = n + 1) check(n, n ^ 32'hDEADBEEF);
        if (errors == 0) $display("PASS sdram ctrl"); else $display("FAIL errors=%0d", errors);
        $finish;
    end
endmodule
