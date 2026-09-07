// tb_vram_lcd.v — verify the VRAM refresh engine's SPI output against a
// known 4x4 framebuffer (2 strips of 2 rows). Checks the per-strip
// CASET/PASET/RAMWR command block and the RGB565->3-byte pixel stream.
`timescale 1ns/1ps
module tb_vram_lcd;
    reg clk = 0; always #5 clk = ~clk;
    reg rst = 1;
    reg sel = 0, we = 0; reg [3:0] addr; reg [31:0] wdata; wire [31:0] rdata;
    wire m_valid; reg m_ready = 0; wire [20:0] m_addr; reg [31:0] m_rdata;
    wire mem_busy, owner, sck, mosi, dc;

    vram_lcd #(.WIDTH(4), .HEIGHT(4), .STRIP(2)) dut (
        .clk(clk), .rst(rst), .sel(sel), .we(we), .addr(addr), .wdata(wdata), .rdata(rdata),
        .m_valid(m_valid), .m_ready(m_ready), .m_addr(m_addr), .m_rdata(m_rdata),
        .mem_busy(mem_busy), .owner(owner), .sck(sck), .mosi(mosi), .dc(dc));

    // fake VRAM: 16 pixels = 8 words. pixel[i] = i (RGB565). word[j] = {px[2j+1],px[2j]}.
    reg [15:0] vram [0:15];
    integer k;
    // single-cycle read model
    always @(posedge clk) begin
        m_ready <= 1'b0;
        if (m_valid && !m_ready) begin
            m_rdata <= {vram[m_addr*2 + 1], vram[m_addr*2]};
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

    task wr(input [3:0] a, input [31:0] d);
        begin @(posedge clk); addr <= a; wdata <= d; sel <= 1; we <= 1; @(posedge clk); sel <= 0; we <= 0; end
    endtask

    integer errors = 0;
    task chk(input integer i, input dcv, input [7:0] want);
        begin
            if (cap[i] !== want || capdc[i] !== dcv) begin
                errors = errors + 1;
                $display("MISMATCH cap[%0d] dc=%b byte=%02x  want dc=%b %02x", i, capdc[i], cap[i], dcv, want);
            end
        end
    endtask

    initial begin
        for (k = 0; k < 16; k = k + 1) vram[k] = k[15:0];
        repeat (3) @(posedge clk); rst = 0;
        wr(4'h8, 32'd0);     // DIV = 0
        wr(4'h4, 32'd0);     // BASE = 0
        wr(4'h0, 32'd1);     // enable
        // let it stream strip 0 (11 cmd bytes + 8 px*3 = 24 = 35 bytes) + start of strip1
        repeat (6000) @(posedge clk);
        // ---- strip 0 command block ----
        chk(0, 1'b0, 8'h2A); chk(1,1'b1,8'h00); chk(2,1'b1,8'h00); chk(3,1'b1,8'h00); chk(4,1'b1,8'h03);
        chk(5, 1'b0, 8'h2B); chk(6,1'b1,8'h00); chk(7,1'b1,8'h00); chk(8,1'b1,8'h00); chk(9,1'b1,8'h01);
        chk(10,1'b0, 8'h2C);
        // ---- strip 0 pixels 0..7 (each R,G,B). pixel i = i -> B = (i&0x1F)<<3 ----
        // pixel 0 = 0x0000
        chk(11,1'b1,8'h00); chk(12,1'b1,8'h00); chk(13,1'b1,8'h00);
        // pixel 1 = 0x0001 -> B=0x08
        chk(14,1'b1,8'h00); chk(15,1'b1,8'h00); chk(16,1'b1,8'h08);
        // pixel 7 = 0x0007 -> B=0x38 (index 11 + 7*3 = 32,33,34)
        chk(32,1'b1,8'h00); chk(33,1'b1,8'h00); chk(34,1'b1,8'h38);
        // ---- strip 1 begins: CASET again ----
        chk(35,1'b0,8'h2A);
        // strip 1 PASET should carry y0=2,y1=3
        chk(40,1'b0,8'h2B); chk(42,1'b1,8'h02); chk(44,1'b1,8'h03);
        if (errors == 0) $display("PASS vram_lcd (ncap=%0d)", ncap);
        else $display("FAIL vram_lcd errors=%0d (ncap=%0d)", errors, ncap);
        $finish;
    end
endmodule
