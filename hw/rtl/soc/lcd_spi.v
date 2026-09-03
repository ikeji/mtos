// lcd_spi.v — write-only SPI shifter for the ILI9488 with pixel-level
// hardware support, so the slow multi-cycle CPU pokes per PIXEL (or per
// FILL / GLYPH) instead of per byte:
//   +0x0  DATA   write: shift one raw byte (commands / parameters)
//   +0x4  STATUS bit0 = cannot accept (shifting), bit1 = fully idle
//   +0x8  CTRL   bits 15:8 = clock divider (SCK = clk/(2*(div+1)))
//   +0xC  PIX    write: RGB565 pixel → three bytes on the wire
//                (R<<3 | G<<2 | B<<3 per the ILI9488's 18-bit format)
//   +0x10 FILL   write: send this many MORE copies of the last PIX value
//   +0x14 GAP    idle clocks inserted between fill/glyph pixels (panel +
//                long-wire recovery; streaming with no gap drops pixels)
//   +0x18 GFG    write: RGB565 → latch expanded foreground pixel bytes
//   +0x1C GBG    write: RGB565 → latch expanded background pixel bytes
//   +0x20 GLYPH  write: byte[7:0] → emit 8 pixels MSB-first, each bit
//                selects GFG (1) or GBG (0). Moves the console's per-pixel
//                glyph expansion off the un-optimized TC CPU loop: the
//                kernel streams bpr*16 font bytes and the hardware paints
//                8 pixels each at wire speed (via the same PIX 3-byte path,
//                with the GAP recovery that PIX-per-pixel already relies on).
// The busy bit covers everything including an active fill / glyph.
module lcd_spi (
    input  wire        clk,
    input  wire        rst,
    input  wire        sel,
    input  wire        we,
    input  wire [5:0]  addr,
    input  wire [31:0] wdata,
    output reg  [31:0] rdata,
    output reg         sck,
    output reg         mosi
);
    reg [7:0]  div, dcnt;
    reg [15:0] gap, gcnt;   // inter-pixel idle for FILL / GLYPH
    reg        busy;         // shifter running
    reg [7:0]  shift;
    reg [3:0]  bit_cnt;
    reg        phase;
    reg [1:0]  pend;         // pixel bytes still queued (g, b)
    reg [7:0]  pr, pg, pb;   // expanded pixel bytes (r held for fills)
    reg [31:0] fill_cnt;
    reg [7:0]  ffr, ffg, ffb; // expanded foreground pixel (GLYPH)
    reg [7:0]  bbr, bbg, bbb; // expanded background pixel (GLYPH)
    reg [7:0]  gbyte;         // current glyph byte, shifted MSB-first
    reg [3:0]  gbits;         // glyph bits still to emit (0..8)
    wire       idle = !busy && pend == 2'd0 && fill_cnt == 32'd0 && gbits == 4'd0;

    always @(*) begin
        case (addr[5:2])
            4'h1: rdata = {30'b0, ~idle, busy | (pend != 2'd0) | (fill_cnt != 32'd0) | (gbits != 4'd0)};
            4'h2: rdata = {16'b0, div, 8'b0};
            4'h5: rdata = {16'b0, gap};
            default: rdata = 32'd0;
        endcase
    end

    task start_byte(input [7:0] b);
        begin busy <= 1; shift <= b; bit_cnt <= 8; phase <= 0; mosi <= b[7]; sck <= 0; dcnt <= 0; end
    endtask

    always @(posedge clk) begin
        if (rst) begin
            div <= 0; dcnt <= 0; gap <= 0; gcnt <= 0; busy <= 0; shift <= 0; bit_cnt <= 0; phase <= 0;
            pend <= 0; pr <= 0; pg <= 0; pb <= 0; fill_cnt <= 0; sck <= 0; mosi <= 0; rdata <= 0;
            ffr <= 0; ffg <= 0; ffb <= 0; bbr <= 0; bbg <= 0; bbb <= 0; gbyte <= 0; gbits <= 0;
        end else begin
            if (sel && we) begin
                case (addr[5:2])
                    4'h0: if (!busy) start_byte(wdata[7:0]);
                    4'h2: div <= wdata[15:8];
                    4'h3: if (!busy) begin
                        pr <= {wdata[15:11], 3'b0};
                        pg <= {wdata[10:5],  2'b0};
                        pb <= {wdata[4:0],   3'b0};
                        pend <= 2'd2;
                        start_byte({wdata[15:11], 3'b0});
                    end
                    4'h4: fill_cnt <= wdata;
                    4'h5: gap <= wdata[15:0];
                    4'h6: begin ffr <= {wdata[15:11], 3'b0}; ffg <= {wdata[10:5], 2'b0}; ffb <= {wdata[4:0], 3'b0}; end
                    4'h7: begin bbr <= {wdata[15:11], 3'b0}; bbg <= {wdata[10:5], 2'b0}; bbb <= {wdata[4:0], 3'b0}; end
                    4'h8: if (!busy && pend == 2'd0 && gbits == 4'd0 && fill_cnt == 32'd0) begin
                        gbyte <= wdata[7:0]; gbits <= 4'd8;
                    end
                    default: ;
                endcase
            end
            if (busy) begin
                if (dcnt != div) dcnt <= dcnt + 1'b1;
                else if (!phase) begin dcnt <= 0; sck <= 1; phase <= 1; end
                else begin
                    dcnt <= 0; sck <= 0; phase <= 0;
                    shift <= {shift[6:0], 1'b0}; mosi <= shift[6];
                    bit_cnt <= bit_cnt - 1'b1;
                    if (bit_cnt == 1) busy <= 0;
                end
            end else if (pend == 2'd2) begin pend <= 2'd1; start_byte(pg); end
            else if (pend == 2'd1) begin pend <= 2'd0; start_byte(pb); gcnt <= gap; end
            else if (fill_cnt != 32'd0) begin
                if (gcnt != 16'd0) gcnt <= gcnt - 1'b1;       // inter-pixel recovery gap
                else begin fill_cnt <= fill_cnt - 1'b1; pend <= 2'd2; start_byte(pr); end
            end else if (gbits != 4'd0) begin
                if (gcnt != 16'd0) gcnt <= gcnt - 1'b1;       // same recovery gap as PIX/FILL
                else begin
                    gbits <= gbits - 1'b1;
                    gbyte <= {gbyte[6:0], 1'b0};
                    if (gbyte[7]) begin pr <= ffr; pg <= ffg; pb <= ffb; pend <= 2'd2; start_byte(ffr); end
                    else          begin pr <= bbr; pg <= bbg; pb <= bbb; pend <= 2'd2; start_byte(bbr); end
                end
            end
        end
    end
endmodule
