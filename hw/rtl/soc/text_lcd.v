// text_lcd.v — text-mode LCD refresh engine (character generator).
//
// A hardware text console: the CPU writes a grid of character cells (char +
// fg/bg colour); this engine rasters them to the ILI9488, expanding the glyph
// itself. Hankaku (8x16) glyphs come from an on-chip font ROM (BSRAM). Zenkaku
// (16x16 JIS) glyphs are too big for BSRAM (~282 KB), so they live in SDRAM
// and the engine fetches the glyph row over its SDRAM read master — a zenkaku
// character occupies two adjacent cells (left half + right half) that share a
// kuten index. So text costs ~zero SDRAM bandwidth for ASCII and only a couple
// of bytes per rendered zenkaku pixel-row (see docs/task/vram_console.md).
//
// Cell (32-bit, written over MMIO):
//   [7:0]   char     hankaku code (used when zen=0)
//   [11:8]  fg       4-bit palette index
//   [15:12] bg       4-bit palette index
//   [16]    zen      1 = zenkaku (fetch glyph row from SDRAM)
//   [17]    zright   zenkaku right half (0 = left 8 px, 1 = right 8 px)
//   [31:18] kuten    zenkaku glyph index (94*94 fits in 14 bits)
//
// No multipliers (the gowin_pack DSP handler is broken in this build):
// row_base advances by +COLS per text row, font_addr = {char, glyph_row}, and
// the zenkaku SDRAM word addr = zbase + (kuten<<3) + (grow>>1).
//
// MMIO (word addressed, addr[13:2] = word index):
//   0 .. NCELL-1 : cell RAM (32-bit)
//   CTRL_IDX     : bit0 = enable
//   DIV_IDX      : SCK = clk / (2*(div+1)); div in bits[7:0]
//   ZBASE_IDX    : zenkaku font base as an SDRAM *word* address
module text_lcd #(
    parameter integer WIDTH   = 480,
    parameter integer HEIGHT  = 320,
    parameter integer CW      = 8,
    parameter integer CH      = 16,
    parameter integer CHBITS  = 4,       // log2(CH)
    parameter integer COLS    = 60,
    parameter integer ROWS    = 20,
    parameter integer STRIP   = 8,       // pixel rows/strip; STRIP*WIDTH < ~6000, divides HEIGHT
    parameter integer NCELL   = 1200,
    parameter integer CTRL_IDX  = 2048,
    parameter integer DIV_IDX   = 2049,
    parameter integer ZBASE_IDX = 2050,
    parameter         FONT_INIT = 0,
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
    // SDRAM read master (word addressed) — used only for zenkaku glyph rows
    output reg         m_valid,
    input  wire        m_ready,
    output reg  [20:0] m_addr,
    input  wire [31:0] m_rdata,
    output wire        owner,     // 1 = engine drives the LCD pins
    // LCD SPI out
    output reg         sck,
    output reg         mosi,
    output reg         dc
);
    localparam integer FONTN = 256 * CH;   // hankaku font ROM bytes

    // ---- storage ----
    reg [31:0] cram [0:NCELL-1];
    reg [7:0]  font [0:FONTN-1];
    initial begin
        if (FONT_INIT) $readmemh(FONT_HEX, font);
    end

    reg        enable;
    reg [7:0]  div;
    reg [20:0] zbase;              // zenkaku font SDRAM word base
    assign owner = enable;

    // ---- 16-colour palette (RGB565) ----
    function [15:0] pal(input [3:0] i);
        case (i)
            4'd0:  pal = 16'h0000; 4'd1:  pal = 16'h001F; 4'd2:  pal = 16'h07E0;
            4'd3:  pal = 16'h07FF; 4'd4:  pal = 16'hF800; 4'd5:  pal = 16'hF81F;
            4'd6:  pal = 16'hFD20; 4'd7:  pal = 16'hC618; 4'd8:  pal = 16'h7BEF;
            4'd9:  pal = 16'h041F; 4'd10: pal = 16'h07EF; 4'd11: pal = 16'h5FFF;
            4'd12: pal = 16'hFC10; 4'd13: pal = 16'hFC1F; 4'd14: pal = 16'hFFE0;
            default: pal = 16'hFFFF;
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
               S_ZWAIT = 3'd4, S_COLE = 3'd5, S_ADV = 3'd6, S_NEXT = 3'd7;
    reg [2:0]  state;
    reg [15:0] abs_y;
    reg [15:0] y0_reg;
    reg [8:0]  srow;
    reg [CHBITS-1:0] grow;
    reg [11:0] row_base;
    reg [11:0] col;
    reg [3:0]  cmd_i;
    reg [3:0]  xbit;
    reg [1:0]  pb;
    reg [7:0]  zrow;       // latched zenkaku glyph row byte (from SDRAM)

    wire [15:0] y1 = y0_reg + (STRIP - 1);

    // continuous BSRAM reads: cell then (for hankaku) its glyph row
    wire [11:0] cell_addr = row_base + col;
    reg  [31:0] cell_q;
    wire [7:0]  cur_char = cell_q[7:0];
    wire        is_zen   = cell_q[16];
    wire        zright   = cell_q[17];
    wire [13:0] kuten    = cell_q[31:18];
    wire [15:0] fg_col   = pal(cell_q[11:8]);
    wire [15:0] bg_col   = pal(cell_q[15:12]);
    wire [11:0] font_addr = {cur_char, grow};
    reg  [7:0]  font_q;
    always @(posedge clk) begin
        cell_q <= cram[cell_addr];
        font_q <= font[font_addr];
    end

    // zenkaku SDRAM word address: zbase + kuten*32bytes + grow*2bytes
    wire [20:0] zaddr = zbase + {kuten, 3'b0} + {17'b0, grow[CHBITS-1:1]};
    // the two glyph bytes sit at byte offset (grow&1)*2 within the fetched word
    wire [7:0]  z_left  = grow[0] ? m_rdata[23:16] : m_rdata[7:0];
    wire [7:0]  z_right = grow[0] ? m_rdata[31:24] : m_rdata[15:8];

    // current glyph row: hankaku uses font_q (BSRAM, stable this column),
    // zenkaku uses the byte latched from SDRAM in S_ZWAIT.
    wire [7:0]  cur_row = is_zen ? zrow : font_q;
    wire        on_bit  = cur_row[CW-1-xbit];
    wire [15:0] cur_px  = on_bit ? fg_col : bg_col;
    reg  [7:0]  pix_byte;
    always @(*) begin
        case (pb)
            2'd0:    pix_byte = {cur_px[15:11], 3'b0};
            2'd1:    pix_byte = {cur_px[10:5],  2'b0};
            default: pix_byte = {cur_px[4:0],   3'b0};
        endcase
    end

    // per-strip command bytes (CASET, PASET, RAMWR)
    reg [7:0] cmd_byte; reg cmd_dc;
    always @(*) begin
        case (cmd_i)
            4'd0:  begin cmd_byte = 8'h2A;             cmd_dc = 1'b0; end
            4'd1:  begin cmd_byte = 8'h00;             cmd_dc = 1'b1; end
            4'd2:  begin cmd_byte = 8'h00;             cmd_dc = 1'b1; end
            4'd3:  begin cmd_byte = (WIDTH-1) >> 8;    cmd_dc = 1'b1; end
            4'd4:  begin cmd_byte = (WIDTH-1) & 8'hFF; cmd_dc = 1'b1; end
            4'd5:  begin cmd_byte = 8'h2B;             cmd_dc = 1'b0; end
            4'd6:  begin cmd_byte = y0_reg[15:8];      cmd_dc = 1'b1; end
            4'd7:  begin cmd_byte = y0_reg[7:0];       cmd_dc = 1'b1; end
            4'd8:  begin cmd_byte = y1[15:8];          cmd_dc = 1'b1; end
            4'd9:  begin cmd_byte = y1[7:0];           cmd_dc = 1'b1; end
            default: begin cmd_byte = 8'h2C;           cmd_dc = 1'b0; end
        endcase
    end

    always @(*) begin
        rdata = 32'd0;
        if (addr[13:2] == CTRL_IDX)       rdata = {31'b0, enable};
        else if (addr[13:2] == DIV_IDX)   rdata = {24'b0, div};
        else if (addr[13:2] == ZBASE_IDX) rdata = {11'b0, zbase};
    end

    always @(posedge clk) begin
        if (rst) begin
            enable <= 0; div <= 0; zbase <= 0;
            busy <= 0; shift <= 0; bit_cnt <= 0; phase <= 0; dcnt <= 0;
            start_req <= 0; start_byte <= 0; start_dc <= 0;
            sck <= 0; mosi <= 0; dc <= 0;
            state <= S_IDLE; abs_y <= 0; y0_reg <= 0; srow <= 0; grow <= 0;
            row_base <= 0; col <= 0; cmd_i <= 0; xbit <= 0; pb <= 0;
            zrow <= 0; m_valid <= 0; m_addr <= 0;
        end else begin
            // ---- MMIO writes ----
            if (sel && we) begin
                if (addr[13:2] == CTRL_IDX)        enable <= wdata[0];
                else if (addr[13:2] == DIV_IDX)    div    <= wdata[7:0];
                else if (addr[13:2] == ZBASE_IDX)  zbase  <= wdata[20:0];
                else if (addr[13:2] < NCELL)       cram[addr[13:2]] <= wdata;
            end

            // ---- byte shifter ----
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
                S_COL0: state <= S_COL1;       // cell_q loading
                S_COL1: begin
                    // cell_q valid. Hankaku: font_q lands next cycle (S_COLE).
                    // Zenkaku: issue the SDRAM glyph-row read.
                    if (is_zen) begin
                        m_addr <= zaddr; m_valid <= 1'b1;
                        state  <= S_ZWAIT;
                    end else begin
                        state <= S_COLE;
                    end
                end
                S_ZWAIT: begin
                    if (m_valid && m_ready) begin
                        m_valid <= 1'b0;
                        zrow    <= zright ? z_right : z_left;
                        state   <= S_COLE;
                    end
                end
                S_COLE: begin
                    if (!busy && !start_req) begin
                        start_req <= 1; start_dc <= 1'b1; start_byte <= pix_byte;
                        if (pb == 2'd2) begin
                            pb <= 0;
                            if (xbit == (CW-1)) state <= S_ADV;
                            else xbit <= xbit + 4'd1;
                        end else begin
                            pb <= pb + 2'd1;
                        end
                    end
                end
                S_ADV: begin
                    xbit <= 0; pb <= 0;
                    if (col == (COLS-1)) begin
                        col   <= 0;
                        abs_y <= abs_y + 16'd1;
                        srow  <= srow + 9'd1;
                        if (grow == (CH-1)) begin
                            grow <= 0; row_base <= row_base + COLS;
                        end else begin
                            grow <= grow + 1'b1;
                        end
                        if (srow == (STRIP-1)) state <= S_NEXT;
                        else                   state <= S_COL0;
                    end else begin
                        col   <= col + 12'd1;
                        state <= S_COL0;
                    end
                end
                S_NEXT: begin
                    if (!enable) state <= S_IDLE;
                    else begin
                        srow <= 0; cmd_i <= 0;
                        if (abs_y == HEIGHT) begin
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
