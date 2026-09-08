// text_lcd.v — text-mode LCD refresh engine (character generator).
//
// A hardware text console: instead of a pixel framebuffer, the CPU writes a
// small grid of character cells (char code + fg/bg colour). This engine
// continuously rasters that grid to the ILI9488 — for each LCD pixel it
// looks the character's glyph row up in an on-chip font ROM and streams the
// fg or bg colour per bit. The CPU never expands glyphs or touches pixels:
// putting a character is a single 2-byte cell write, and scrolling is a tiny
// cell-array memmove (or, later, a base-row register). Everything lives in
// FPGA BSRAM, so the engine needs no SDRAM at all.
//
// Geometry (defaults): 480x320 panel, 8x16 hankaku cells -> 60x20 = 1200
// cells. The frame is streamed in STRIP-pixel-row strips to respect the
// panel's ~6k-pixel RAMWR burst limit (same as vram_lcd.v).
//
// No multipliers (the gowin_pack DSP handler is broken in this oss-cad-suite
// build): the cell row base advances by +COLS per text row, and the font
// address is {char, glyph_row} since CH is a power of two.
//
// MMIO (word addressed, addr[13:2] = word index):
//   index 0 .. NCELL-1 : cell RAM. write low 16 bits = {bg[15:12], fg[11:8], char[7:0]}
//   index CTRL_IDX      : bit0 = enable (0 releases the LCD bus to the CPU)
//   index DIV_IDX       : SCK = clk / (2*(div+1)); div in bits[7:0]
//
// LCD out: sck/mosi/dc — muxed onto the panel pins by the top level when
// `owner` (= enable) is set. CS/RST/BL stay on the GPIO block.
module text_lcd #(
    parameter integer WIDTH   = 480,
    parameter integer HEIGHT  = 320,
    parameter integer CW      = 8,       // cell width  (px)
    parameter integer CH      = 16,      // cell height (px, power of two)
    parameter integer CHBITS  = 4,       // log2(CH)
    parameter integer COLS    = 60,      // WIDTH / CW
    parameter integer ROWS    = 20,      // HEIGHT / CH
    parameter integer STRIP   = 8,       // pixel rows/strip; STRIP*WIDTH < ~6000, divides HEIGHT
    parameter integer NCELL   = 1200,    // COLS * ROWS
    parameter integer CTRL_IDX = 2048,   // MMIO word index of CTRL
    parameter integer DIV_IDX  = 2049,   // MMIO word index of DIV
    parameter         FONT_INIT = 0,     // 1 = $readmemh(FONT_HEX) at time 0
    parameter         FONT_HEX  = "font_hankaku.hex"
)(
    input  wire        clk,
    input  wire        rst,
    // MMIO
    input  wire        sel,
    input  wire        we,
    input  wire [13:0] addr,
    input  wire [31:0] wdata,
    output reg  [31:0] rdata,
    output wire        owner,     // 1 = engine drives the LCD pins
    // LCD SPI out
    output reg         sck,
    output reg         mosi,
    output reg         dc         // 0 = command, 1 = data
);
    localparam integer NSTRIP = HEIGHT / STRIP;
    localparam integer FONTN  = 256 * CH;   // font ROM bytes

    // ---- storage ----
    reg [15:0] cram [0:NCELL-1];         // {bg[3:0], fg[3:0], char[7:0]}
    reg [7:0]  font [0:FONTN-1];         // 256 chars x CH rows, MSB = leftmost
    initial begin
        if (FONT_INIT) $readmemh(FONT_HEX, font);
    end

    reg        enable;
    reg [7:0]  div;
    assign owner = enable;

    // ---- 16-colour palette (RGB565) ----
    function [15:0] pal(input [3:0] i);
        case (i)
            4'd0:  pal = 16'h0000; // black
            4'd1:  pal = 16'h001F; // blue
            4'd2:  pal = 16'h07E0; // green
            4'd3:  pal = 16'h07FF; // cyan
            4'd4:  pal = 16'hF800; // red
            4'd5:  pal = 16'hF81F; // magenta
            4'd6:  pal = 16'hFD20; // orange
            4'd7:  pal = 16'hC618; // light grey
            4'd8:  pal = 16'h7BEF; // dark grey
            4'd9:  pal = 16'h041F; // light blue
            4'd10: pal = 16'h07EF; // light green
            4'd11: pal = 16'h5FFF; // pale cyan
            4'd12: pal = 16'hFC10; // light red
            4'd13: pal = 16'hFC1F; // pink
            4'd14: pal = 16'hFFE0; // yellow
            default: pal = 16'hFFFF; // white
        endcase
    endfunction

    // ---- byte shifter (SPI mode 0, MSB first) — mirrors vram_lcd.v ----
    reg        busy;
    reg [7:0]  shift;
    reg [3:0]  bit_cnt;
    reg        phase;
    reg [7:0]  dcnt;
    reg        start_req;
    reg [7:0]  start_byte;
    reg        start_dc;

    // ---- raster sequencing ----
    localparam S_IDLE = 3'd0, S_CMD = 3'd1, S_COL0 = 3'd2, S_COL1 = 3'd3,
               S_COLE = 3'd4, S_ADV = 3'd5, S_NEXT = 3'd6;
    reg [2:0]  state;
    reg [15:0] abs_y;        // current absolute LCD row (0..HEIGHT-1)
    reg [15:0] y0_reg;       // first row of the current strip
    reg [8:0]  srow;         // pixel row within the strip (0..STRIP-1)
    reg [CHBITS-1:0] grow;   // glyph row within the cell (abs_y % CH)
    reg [11:0] row_base;     // trow * COLS (advanced incrementally)
    reg [11:0] col;          // 0..COLS-1
    reg [3:0]  cmd_i;
    reg [3:0]  xbit;         // 0..CW-1 within the cell column
    reg [1:0]  pb;           // pixel byte: 0=R 1=G 2=B

    wire [15:0] y1 = y0_reg + (STRIP - 1);

    // continuous BSRAM reads: cell for (row_base+col), then its glyph row
    wire [11:0] cell_addr = row_base + col;
    reg  [15:0] cell_q;
    wire [7:0]  cur_char = cell_q[7:0];
    wire [15:0] fg_col   = pal(cell_q[11:8]);
    wire [15:0] bg_col   = pal(cell_q[15:12]);
    wire [11:0] font_addr = {cur_char, grow};   // char*CH + grow (CH power of 2)
    reg  [7:0]  font_q;
    always @(posedge clk) begin
        cell_q <= cram[cell_addr];
        font_q <= font[font_addr];
    end

    // current pixel colour + its R/G/B bytes
    wire        on_bit = font_q[CW-1-xbit];
    wire [15:0] cur_px = on_bit ? fg_col : bg_col;
    reg  [7:0]  pix_byte;
    always @(*) begin
        case (pb)
            2'd0:    pix_byte = {cur_px[15:11], 3'b0}; // R
            2'd1:    pix_byte = {cur_px[10:5],  2'b0}; // G
            default: pix_byte = {cur_px[4:0],   3'b0}; // B
        endcase
    end

    // per-strip command bytes (CASET, PASET, RAMWR)
    reg [7:0] cmd_byte; reg cmd_dc;
    always @(*) begin
        case (cmd_i)
            4'd0:  begin cmd_byte = 8'h2A;             cmd_dc = 1'b0; end // CASET
            4'd1:  begin cmd_byte = 8'h00;             cmd_dc = 1'b1; end
            4'd2:  begin cmd_byte = 8'h00;             cmd_dc = 1'b1; end
            4'd3:  begin cmd_byte = (WIDTH-1) >> 8;    cmd_dc = 1'b1; end
            4'd4:  begin cmd_byte = (WIDTH-1) & 8'hFF; cmd_dc = 1'b1; end
            4'd5:  begin cmd_byte = 8'h2B;             cmd_dc = 1'b0; end // PASET
            4'd6:  begin cmd_byte = y0_reg[15:8];      cmd_dc = 1'b1; end
            4'd7:  begin cmd_byte = y0_reg[7:0];       cmd_dc = 1'b1; end
            4'd8:  begin cmd_byte = y1[15:8];          cmd_dc = 1'b1; end
            4'd9:  begin cmd_byte = y1[7:0];           cmd_dc = 1'b1; end
            default: begin cmd_byte = 8'h2C;           cmd_dc = 1'b0; end // RAMWR
        endcase
    end

    // ---- MMIO readback (debug) ----
    always @(*) begin
        rdata = 32'd0;
        if (addr[13:2] == CTRL_IDX) rdata = {31'b0, enable};
        else if (addr[13:2] == DIV_IDX) rdata = {24'b0, div};
    end

    always @(posedge clk) begin
        if (rst) begin
            enable <= 0; div <= 0;
            busy <= 0; shift <= 0; bit_cnt <= 0; phase <= 0; dcnt <= 0;
            start_req <= 0; start_byte <= 0; start_dc <= 0;
            sck <= 0; mosi <= 0; dc <= 0;
            state <= S_IDLE; abs_y <= 0; y0_reg <= 0; srow <= 0; grow <= 0;
            row_base <= 0; col <= 0; cmd_i <= 0; xbit <= 0; pb <= 0;
        end else begin
            // ---- MMIO writes ----
            if (sel && we) begin
                if (addr[13:2] == CTRL_IDX)      enable <= wdata[0];
                else if (addr[13:2] == DIV_IDX)  div    <= wdata[7:0];
                else if (addr[13:2] < NCELL)           cram[addr[13:2]] <= wdata[15:0];
            end

            // ---- byte shifter (identical to vram_lcd) ----
            if (busy) begin
                if (dcnt != div) dcnt <= dcnt + 1'b1;
                else if (!phase) begin dcnt <= 0; sck <= 1; phase <= 1; end
                else begin
                    dcnt <= 0; sck <= 0; phase <= 0;
                    shift <= {shift[6:0], 1'b0}; mosi <= shift[6];
                    bit_cnt <= bit_cnt - 1'b1;
                    if (bit_cnt == 1) busy <= 0;
                end
            end else if (start_req) begin
                busy <= 1; shift <= start_byte; bit_cnt <= 8; phase <= 0;
                mosi <= start_byte[7]; sck <= 0; dcnt <= 0; dc <= start_dc;
                start_req <= 0;
            end

            // ---- raster FSM ----
            case (state)
                S_IDLE: begin
                    if (enable) begin
                        abs_y <= 0; y0_reg <= 0; srow <= 0; grow <= 0;
                        row_base <= 0; col <= 0; cmd_i <= 0; xbit <= 0; pb <= 0;
                        state <= S_CMD;
                    end
                end
                S_CMD: begin
                    if (!busy && !start_req) begin
                        start_req <= 1; start_byte <= cmd_byte; start_dc <= cmd_dc;
                        if (cmd_i == 4'd10) begin
                            cmd_i <= 0; col <= 0; xbit <= 0; pb <= 0;
                            state <= S_COL0;
                        end else begin
                            cmd_i <= cmd_i + 4'd1;
                        end
                    end
                end
                // 2-cycle load: cell_q (cycle 1) then font_q (cycle 2)
                S_COL0: state <= S_COL1;
                S_COL1: state <= S_COLE;
                S_COLE: begin
                    if (!busy && !start_req) begin
                        start_req <= 1; start_byte <= pix_byte; start_dc <= 1'b1;
                        if (pb == 2'd2) begin
                            pb <= 0;
                            if (xbit == (CW-1)) state <= S_ADV;  // column done
                            else xbit <= xbit + 4'd1;
                        end else begin
                            pb <= pb + 2'd1;
                        end
                    end
                end
                S_ADV: begin
                    xbit <= 0; pb <= 0;
                    if (col == (COLS-1)) begin
                        // row finished: advance to the next pixel row
                        col      <= 0;
                        abs_y    <= abs_y + 16'd1;
                        srow     <= srow + 9'd1;
                        if (grow == (CH-1)) begin
                            grow <= 0; row_base <= row_base + COLS;
                        end else begin
                            grow <= grow + 1'b1;
                        end
                        if (srow == (STRIP-1)) state <= S_NEXT;   // strip done
                        else                   state <= S_COL0;   // next row
                    end else begin
                        col <= col + 12'd1;
                        state <= S_COL0;                          // next column
                    end
                end
                S_NEXT: begin
                    if (!enable) state <= S_IDLE;
                    else begin
                        srow <= 0; cmd_i <= 0;
                        if (abs_y == HEIGHT) begin
                            // wrap to a fresh frame
                            abs_y <= 0; y0_reg <= 0; grow <= 0; row_base <= 0;
                        end else begin
                            y0_reg <= abs_y;
                        end
                        state <= S_CMD;
                    end
                end
                default: state <= S_IDLE;
            endcase
        end
    end
endmodule
