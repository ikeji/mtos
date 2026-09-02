// tb_lcd_spi.v — lcd_spi: byte / PIX (RGB565→3 bytes) / FILL streaming.
`timescale 1ns/1ps
module tb_lcd_spi;
    reg clk = 0; always #12.3 clk = ~clk;   // ~40.5 MHz
    reg rst = 1; reg sel = 0, we = 0; reg [4:0] addr; reg [31:0] wdata; wire [31:0] rdata;
    wire sck, mosi;
    lcd_spi dut (.clk(clk), .rst(rst), .sel(sel), .we(we), .addr(addr), .wdata(wdata), .rdata(rdata), .sck(sck), .mosi(mosi));
    // capture bytes off the wire (mode 0: sample on rising sck)
    reg [7:0] cap [0:63]; integer ncap = 0; reg [7:0] sh; integer nb = 0;
    always @(posedge sck) begin
        sh = {sh[6:0], mosi}; nb = nb + 1;
        if (nb == 8) begin cap[ncap] = sh; ncap = ncap + 1; nb = 0; end
    end
    task wr(input [4:0] a, input [31:0] d); begin @(posedge clk); addr <= a; wdata <= d; sel <= 1; we <= 1; @(posedge clk); sel <= 0; we <= 0; end endtask
    task wait_idle; begin
        addr = 5'h4; sel = 1; we = 0; #1;
        while (rdata[1]) begin @(posedge clk); #1; end
        sel = 0;
    end endtask
    integer errors = 0;
    task chk(input integer i, input [7:0] want); begin
        if (cap[i] !== want) begin errors = errors + 1; $display("MISMATCH cap[%0d]=%02x want=%02x", i, cap[i], want); end
    end endtask
    initial begin
        repeat (3) @(posedge clk); rst = 0;
        wr(5'h00, 32'h2C);                 // raw byte
        wait_idle;
        wr(5'h0C, {16'b0, 5'b10110, 6'b010101, 5'b00111});  // PIX RGB565
        wait_idle;
        wr(5'h0C, 16'hF800); wait_idle;    // red
        wr(5'h10, 32'd2);                  // fill: 2 more red pixels
        wait_idle;
        // expected: 2C | b0 54 38 | F8 00 00 | F8 00 00 | F8 00 00
        chk(0, 8'h2C);
        chk(1, {5'b10110,3'b0}); chk(2, {6'b010101,2'b0}); chk(3, {5'b00111,3'b0});
        chk(4, 8'hF8); chk(5, 8'h00); chk(6, 8'h00);
        chk(7, 8'hF8); chk(8, 8'h00); chk(9, 8'h00);
        chk(10, 8'hF8); chk(11, 8'h00); chk(12, 8'h00);
        if (ncap != 13) begin errors = errors + 1; $display("ncap=%0d want 13", ncap); end
        if (errors == 0) $display("PASS lcd_spi"); else $display("FAIL errors=%0d", errors);
        $finish;
    end
endmodule
