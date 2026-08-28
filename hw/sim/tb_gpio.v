// tb_gpio.v — SIO-style GPIO block: set/clear/xor/oe + input readback.
`timescale 1ns/1ps
module tb_gpio;
    reg clk = 0; always #18.5 clk = ~clk;
    reg rst = 1; reg sel = 0, we = 0; reg [7:0] addr; reg [31:0] wdata; wire [31:0] rdata;
    wire [47:0] gout, goe; reg [47:0] gin = 0;
    gpio_sio dut (.clk(clk), .rst(rst), .sel(sel), .we(we), .addr(addr), .wdata(wdata), .rdata(rdata), .gpio_out(gout), .gpio_oe(goe), .gpio_in(gin));
    integer errors = 0;
    task wr(input [7:0] a, input [31:0] d); begin @(posedge clk); addr <= a; wdata <= d; sel <= 1; we <= 1; @(posedge clk); sel <= 0; we <= 0; end endtask
    task chk(input [47:0] want_out, input [47:0] want_oe); begin @(posedge clk); if (gout !== want_out || goe !== want_oe) begin errors = errors + 1; $display("MISMATCH out=%h oe=%h", gout, goe); end end endtask
    initial begin
        repeat (3) @(posedge clk); rst = 0;
        wr(8'h18, 32'h0000_0006);  chk(48'h0000_0000_0006, 0);                 // OUT_SET GP1,GP2
        wr(8'h1C, 32'h0000_0040);  chk(48'h0040_0000_0006, 0);                 // HI_OUT_SET GP38
        wr(8'h38, 32'hFFFF_FFFF);  chk(48'h0040_0000_0006, 48'h0000_FFFF_FFFF); // OE_SET low
        wr(8'h20, 32'h0000_0002);  chk(48'h0040_0000_0004, 48'h0000_FFFF_FFFF); // OUT_CLR GP1
        wr(8'h28, 32'h0000_0001);  chk(48'h0040_0000_0005, 48'h0000_FFFF_FFFF); // OUT_XOR GP0
        wr(8'h3C, 32'h0000_1FC0);  chk(48'h0040_0000_0005, 48'h1FC0_FFFF_FFFF); // HI_OE_SET GP38..44
        wr(8'h40, 32'h0000_0FFE);  chk(48'h0040_0000_0005, 48'h1FC0_FFFF_F001); // OE_CLR GP1..11
        gin = 48'h0080_0000_0A50; @(posedge clk); @(posedge clk); @(posedge clk);
        addr = 8'h04; sel = 1; we = 0; #1; if (rdata !== 32'h0000_0A50) begin errors = errors + 1; $display("IN mismatch %h", rdata); end
        addr = 8'h08; #1; if (rdata !== 32'h0000_0080) begin errors = errors + 1; $display("HI_IN mismatch %h", rdata); end
        sel = 0;
        if (errors == 0) $display("PASS gpio"); else $display("FAIL errors=%0d", errors);
        $finish;
    end
endmodule
