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
    // SDRAM read master (zenkaku glyph rows)
    wire        m_valid; reg m_ready = 0; wire [20:0] m_addr; reg [31:0] m_rdata;

    text_lcd dut (
        .clk(clk), .rst(rst), .sel(sel), .we(we), .addr(addr), .wdata(wdata),
        .rdata(rdata),
        .m_valid(m_valid), .m_ready(m_ready), .m_addr(m_addr), .m_rdata(m_rdata),
        .owner(owner), .sck(sck), .mosi(mosi), .dc(dc));

    // fake zenkaku font SDRAM: 1-cycle read. Every word returns a known
    // pattern keyed by the low address so the zenkaku check below is
    // deterministic: word = {byte3,byte2,byte1,byte0} = {0xC3,0x81,0x42,0x24}.
    always @(posedge clk) begin
        m_ready <= 1'b0;
        if (m_valid && !m_ready) begin
            m_rdata <= 32'hC381_4224;
            m_ready <= 1'b1;
        end
    end

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
        for (k = 0; k < 1200; k = k + 1) dut.cram[k] = 32'h0000_0000;
        for (k = 0; k < 256*16; k = k + 1) dut.font[k] = 8'h00;
        dut.font[1*16 + 0] = 8'hA0;

        repeat (3) @(posedge clk); rst = 0;
        wr(12'h801, 32'd0);        // DIV = 0
        wr(12'h802, 32'd0);        // ZBASE = 0
        wr(12'd0,   32'h0000_0F01);// cell[0] = {bg=0, fg=15(white), char=1}  hankaku
        // zenkaku cells: fake SDRAM word 0xC381_4224 -> row0 left byte = 0x24,
        // right byte = 0x42. cell[1]=left half, cell[2]=right half (kuten=0).
        wr(12'd1,   32'h0001_0F00);// cell[1] zen=1 zright=0 fg=15 bg=0
        wr(12'd2,   32'h0003_0F00);// cell[2] zen=1 zright=1 fg=15 bg=0
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
        // ---- cell(0,1) zenkaku LEFT half, row 0 = 0x24 = 0010_0100 ----
        // col1 pixels start at cap 11 + 8*3 = 35
        chk(35,1'b1,8'h00); chk(36,1'b1,8'h00); chk(37,1'b1,8'h00);   // x0 bit7=0 black
        chk(41,1'b1,8'hF8); chk(42,1'b1,8'hFC); chk(43,1'b1,8'hF8);   // x2 bit5=1 white
        chk(50,1'b1,8'hF8); chk(51,1'b1,8'hFC); chk(52,1'b1,8'hF8);   // x5 bit2=1 white
        // ---- cell(0,2) zenkaku RIGHT half, row 0 = 0x42 = 0100_0010 ----
        // col2 pixels start at cap 11 + 16*3 = 59
        chk(59,1'b1,8'h00); chk(60,1'b1,8'h00); chk(61,1'b1,8'h00);   // x0 bit7=0 black
        chk(62,1'b1,8'hF8); chk(63,1'b1,8'hFC); chk(64,1'b1,8'hF8);   // x1 bit6=1 white
        chk(77,1'b1,8'hF8); chk(78,1'b1,8'hFC); chk(79,1'b1,8'hF8);   // x6 bit1=1 white

        if (errors == 0) $display("PASS text_lcd (ncap=%0d)", ncap);
        else $display("FAIL text_lcd errors=%0d (ncap=%0d)", errors, ncap);
        $finish;
    end
endmodule
