// lcd_spi.v — write-only SPI shifter for the ILI9488 with pixel-level
// hardware support, so the slow multi-cycle CPU pokes per PIXEL (or per
// FILL) instead of per byte:
//   +0x0 DATA   write: shift one raw byte (commands / parameters)
//   +0x4 STATUS bit0 = cannot accept (shifting), bit1 = fully idle
//   +0x8 CTRL   bits 15:8 = clock divider (SCK = clk/(2*(div+1)))
//   +0xC PIX    write: RGB565 pixel → three bytes on the wire
//               (R<<3 | G<<2 | B<<3 per the ILI9488's 18-bit format)
//   +0x10 FILL  write: send this many MORE copies of the last PIX value
// The busy bit covers everything including an active fill.
module lcd_spi (
    input  wire        clk,
    input  wire        rst,
    input  wire        sel,
    input  wire        we,
    input  wire [4:0]  addr,
    input  wire [31:0] wdata,
    output reg  [31:0] rdata,
    output reg         sck,
    output reg         mosi
);
    reg [7:0]  div, dcnt;
    reg        busy;         // shifter running
    reg [7:0]  shift;
    reg [3:0]  bit_cnt;
    reg        phase;
    reg [1:0]  pend;         // pixel bytes still queued (g, b)
    reg [7:0]  pr, pg, pb;   // expanded pixel bytes (r held for fills)
    reg [31:0] fill_cnt;
    wire       idle = !busy && pend == 2'd0 && fill_cnt == 32'd0;

    always @(*) begin
        case (addr[4:2])
            3'h1: rdata = {30'b0, ~idle, busy | (pend != 2'd0) | (fill_cnt != 32'd0)};
            3'h2: rdata = {16'b0, div, 8'b0};
            default: rdata = 32'd0;
        endcase
    end

    task start_byte(input [7:0] b);
        begin busy <= 1; shift <= b; bit_cnt <= 8; phase <= 0; mosi <= b[7]; sck <= 0; dcnt <= 0; end
    endtask

    always @(posedge clk) begin
        if (rst) begin
            div <= 0; dcnt <= 0; busy <= 0; shift <= 0; bit_cnt <= 0; phase <= 0;
            pend <= 0; pr <= 0; pg <= 0; pb <= 0; fill_cnt <= 0; sck <= 0; mosi <= 0; rdata <= 0;
        end else begin
            if (sel && we) begin
                case (addr[4:2])
                    3'h0: if (!busy) start_byte(wdata[7:0]);
                    3'h2: div <= wdata[15:8];
                    3'h3: if (!busy) begin
                        pr <= {wdata[15:11], 3'b0};
                        pg <= {wdata[10:5],  2'b0};
                        pb <= {wdata[4:0],   3'b0};
                        pend <= 2'd2;
                        start_byte({wdata[15:11], 3'b0});
                    end
                    3'h4: fill_cnt <= wdata;
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
            else if (pend == 2'd1) begin pend <= 2'd0; start_byte(pb); end
            else if (fill_cnt != 32'd0) begin fill_cnt <= fill_cnt - 1'b1; pend <= 2'd2; start_byte(pr); end
        end
    end
endmodule
