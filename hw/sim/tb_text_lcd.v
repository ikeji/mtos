// tb_text_lcd.v — verify the text-mode LCD engine's SPI output.
//
// Loads one known glyph row into the font ROM and one cell, then checks the
// per-strip CASET/PASET/RAMWR command block and that the character generator
// expands the glyph bits to the right fg/bg RGB565->3-byte pixel stream.
`timescale 1ns/1ps
module tb_text_lcd;
    reg clk = 0; always #5 clk = ~clk;
    reg rst = 1;
    reg sel = 0, we = 0; reg [13:0] addr; reg [31:0] wdata; wire [31:0] rdata;
    wire owner, sck, mosi, dc;

    text_lcd dut (
        .clk(clk), .rst(rst), .sel(sel), .we(we), .addr(addr), .wdata(wdata),
        .rdata(rdata), .owner(owner), .sck(sck), .mosi(mosi), .dc(dc));

    // capture SPI bytes with their DC level (sample MOSI on rising sck)
    reg [7:0] cap [0:255]; reg capdc [0:255];
    integer ncap = 0, nb = 0; reg [7:0] sh;
    always @(posedge sck) begin
        sh = {sh[6:0], mosi}; nb = nb + 1;
        if (nb == 8) begin cap[ncap] = sh; capdc[ncap] = dc; ncap = ncap + 1; nb = 0; end
    end

    // MMIO write: word index -> byte address {index, 2'b00}
    task wr(input [11:0] widx, input [31:0] d);
        begin @(posedge clk); addr <= {widx, 2'b00}; wdata <= d; sel <= 1; we <= 1;
              @(posedge clk); sel <= 0; we <= 0; end
    endtask

    integer errors = 0;
    task chk(input integer i, input dcv, input [7:0] want);
        begin
            if (cap[i] !== want || capdc[i] !== dcv) begin
                errors = errors + 1;
                $display("MISMATCH cap[%0d] dc=%b byte=%02x  want dc=%b %02x",
                         i, capdc[i], cap[i], dcv, want);
            end
        end
    endtask

    integer k;
    initial begin
        // zero the cell RAM + font, then plant a known glyph:
        // char 1, glyph row 0 = 0xA0 = 1010_0000 (px: fg,bg,fg,bg,bg,bg,bg,bg)
        for (k = 0; k < 1200; k = k + 1) dut.cram[k] = 16'h0000;
        for (k = 0; k < 256*16; k = k + 1) dut.font[k] = 8'h00;
        dut.font[1*16 + 0] = 8'hA0;

        repeat (3) @(posedge clk); rst = 0;
        wr(12'h801, 32'd0);        // DIV = 0
        wr(12'd0,   32'h0000_0F01);// cell[0] = {bg=0, fg=15(white), char=1}
        wr(12'h800, 32'd1);        // CTRL enable
        repeat (3000) @(posedge clk);

        // ---- strip 0 command block: CASET 0..479, PASET 0..7, RAMWR ----
        chk(0, 1'b0, 8'h2A); chk(1,1'b1,8'h00); chk(2,1'b1,8'h00); chk(3,1'b1,8'h01); chk(4,1'b1,8'hDF);
        chk(5, 1'b0, 8'h2B); chk(6,1'b1,8'h00); chk(7,1'b1,8'h00); chk(8,1'b1,8'h00); chk(9,1'b1,8'h07);
        chk(10,1'b0, 8'h2C);
        // ---- cell(0,0) row 0 pixels: glyph 1010_0000, white on black ----
        // px0 bit7=1 -> white 0xFFFF -> R=F8 G=FC B=F8
        chk(11,1'b1,8'hF8); chk(12,1'b1,8'hFC); chk(13,1'b1,8'hF8);
        // px1 bit6=0 -> black
        chk(14,1'b1,8'h00); chk(15,1'b1,8'h00); chk(16,1'b1,8'h00);
        // px2 bit5=1 -> white
        chk(17,1'b1,8'hF8); chk(18,1'b1,8'hFC); chk(19,1'b1,8'hF8);
        // px3 bit4=0 -> black
        chk(20,1'b1,8'h00); chk(21,1'b1,8'h00); chk(22,1'b1,8'h00);
        // px7 bit0=0 -> black (index 11 + 7*3 = 32,33,34)
        chk(32,1'b1,8'h00); chk(33,1'b1,8'h00); chk(34,1'b1,8'h00);

        if (errors == 0) $display("PASS text_lcd (ncap=%0d)", ncap);
        else $display("FAIL text_lcd errors=%0d (ncap=%0d)", errors, ncap);
        $finish;
    end
endmodule
