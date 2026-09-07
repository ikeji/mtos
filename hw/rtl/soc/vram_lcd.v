// vram_lcd.v — hardware LCD refresh engine.
//
// Continuously streams a RGB565 framebuffer in SDRAM (the "VRAM") to the
// ILI9488 over SPI, so the CPU never touches the panel during rendering:
// software just pokes pixels into VRAM and this engine paints them.
//
// The panel drops a single RAMWR burst longer than ~6k pixels (see the
// fill notes), so the frame is streamed in row STRIPs, each a fresh
// CASET/PASET/RAMWR window followed by STRIP*WIDTH pixels. After the last
// strip it wraps to strip 0 — a free-running full-frame refresh at the SPI
// rate (~5 fps for 480x320x18bpp over a 20 MHz SCK).
//
// No multipliers: STRIP must divide HEIGHT so every strip is the same size,
// the pixel word address just runs linearly from BASE across the frame
// (VRAM is row-major and strips are contiguous), and the strip's top row y0
// is tracked incrementally. This keeps the Gowin toolchain from inferring a
// DSP (its gowin_pack DSP handler is broken in this oss-cad-suite build).
//
// MMIO (word regs):
//   +0x0 CTRL   bit0 = enable (0 releases the LCD bus back to the CPU)
//   +0x4 BASE   VRAM base as an SDRAM *word* address (2 px per word)
//   +0x8 DIV    SCK = clk / (2*(div+1)); div in bits[7:0]
//   +0xC STATUS bit0 = active (mid-frame)
//
// SDRAM read master: valid/ready/addr(word)/rdata, mirrors the CPU port.
// LCD out: sck/mosi/dc — muxed onto the panel pins by the top level when
// `owner` (= CTRL enable) is set; CS/RST/BL stay on the GPIO block.
module vram_lcd #(
    parameter integer WIDTH  = 480,
    parameter integer HEIGHT = 320,
    parameter integer STRIP  = 10       // rows/strip; must divide HEIGHT, WIDTH*STRIP < ~6000
)(
    input  wire        clk,
    input  wire        rst,
    // MMIO control
    input  wire        sel,
    input  wire        we,
    input  wire [3:0]  addr,
    output reg  [31:0] rdata,
    input  wire [31:0] wdata,
    // SDRAM read master (word addressed)
    output reg         m_valid,
    input  wire        m_ready,
    output reg  [20:0] m_addr,
    input  wire [31:0] m_rdata,
    output wire        mem_busy,      // a read is outstanding
    output wire        owner,         // 1 = engine drives the LCD pins
    // LCD SPI out
    output reg         sck,
    output reg         mosi,
    output reg         dc             // 0 = command, 1 = data
);
    localparam integer NSTRIP   = HEIGHT / STRIP;
    localparam integer STRIP_PX = STRIP * WIDTH;   // compile-time constant

    reg        enable;
    reg [20:0] base;
    reg [7:0]  div;
    assign owner = enable;

    // ---- byte shifter (SPI mode 0, MSB first) ----
    reg        busy;
    reg [7:0]  shift;
    reg [3:0]  bit_cnt;
    reg        phase;
    reg [7:0]  dcnt;
    reg        start_req;
    reg [7:0]  start_byte;
    reg        start_dc;

    // ---- strip / pixel sequencing ----
    localparam S_IDLE = 3'd0, S_CMD = 3'd1, S_PIX = 3'd2, S_NEXT = 3'd3;
    reg [2:0]  state;
    reg [8:0]  strip;
    reg [15:0] y0;             // top row of the current strip
    reg [3:0]  cmd_i;
    reg [16:0] px_left;
    reg        have_word;
    reg [31:0] pix_word;
    reg        sub;            // 0 = low pixel of the word, 1 = high
    reg [1:0]  pb;             // byte within a pixel: 0=R 1=G 2=B
    assign mem_busy = m_valid;

    wire [15:0] y1 = y0 + (STRIP - 1);

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
            4'd6:  begin cmd_byte = y0[15:8];          cmd_dc = 1'b1; end
            4'd7:  begin cmd_byte = y0[7:0];           cmd_dc = 1'b1; end
            4'd8:  begin cmd_byte = y1[15:8];          cmd_dc = 1'b1; end
            4'd9:  begin cmd_byte = y1[7:0];           cmd_dc = 1'b1; end
            default: begin cmd_byte = 8'h2C;           cmd_dc = 1'b0; end // RAMWR
        endcase
    end

    wire [15:0] cur_px = sub ? pix_word[31:16] : pix_word[15:0];
    reg  [7:0]  pix_byte;
    always @(*) begin
        case (pb)
            2'd0:    pix_byte = {cur_px[15:11], 3'b0}; // R
            2'd1:    pix_byte = {cur_px[10:5],  2'b0}; // G
            default: pix_byte = {cur_px[4:0],   3'b0}; // B
        endcase
    end

    always @(*) begin
        case (addr[3:2])
            2'd3:    rdata = {31'b0, (state != S_IDLE)};
            default: rdata = 32'd0;
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            enable <= 0; base <= 0; div <= 0;
            busy <= 0; shift <= 0; bit_cnt <= 0; phase <= 0; dcnt <= 0;
            start_req <= 0; start_byte <= 0; start_dc <= 0;
            sck <= 0; mosi <= 0; dc <= 0;
            state <= S_IDLE; strip <= 0; y0 <= 0; cmd_i <= 0; px_left <= 0;
            have_word <= 0; pix_word <= 0; sub <= 0; pb <= 0;
            m_valid <= 0; m_addr <= 0;
        end else begin
            if (sel && we) begin
                case (addr[3:2])
                    2'd0: enable <= wdata[0];
                    2'd1: base   <= wdata[20:0];
                    2'd2: div    <= wdata[7:0];
                    default: ;
                endcase
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

            // ---- sequencer ----
            case (state)
                S_IDLE: begin
                    if (enable) begin strip <= 0; y0 <= 0; cmd_i <= 0; m_addr <= base; state <= S_CMD; end
                end
                S_CMD: begin
                    if (!busy && !start_req) begin
                        start_req <= 1; start_byte <= cmd_byte; start_dc <= cmd_dc;
                        if (cmd_i == 4'd10) begin
                            cmd_i <= 0;
                            px_left <= STRIP_PX;
                            have_word <= 0; sub <= 0; pb <= 0;
                            state <= S_PIX;
                        end else begin
                            cmd_i <= cmd_i + 4'd1;
                        end
                    end
                end
                S_PIX: begin
                    if (px_left == 0) begin
                        if (!busy) state <= S_NEXT;
                    end else if (!have_word) begin
                        if (!m_valid) m_valid <= 1'b1;
                        else if (m_ready) begin
                            m_valid <= 1'b0;
                            pix_word <= m_rdata;
                            have_word <= 1'b1;
                            m_addr <= m_addr + 21'd1;
                        end
                    end else if (!busy && !start_req) begin
                        start_req <= 1; start_byte <= pix_byte; start_dc <= 1'b1;
                        if (pb == 2'd2) begin
                            pb <= 0;
                            px_left <= px_left - 1'b1;
                            if (sub == 1'b1) begin sub <= 0; have_word <= 0; end
                            else sub <= 1'b1;
                        end else begin
                            pb <= pb + 2'd1;
                        end
                    end
                end
                S_NEXT: begin
                    if (!enable) state <= S_IDLE;
                    else if (strip == (NSTRIP - 1)) begin
                        // wrap to a fresh frame: reset strip, y0, and the
                        // linear VRAM read pointer back to BASE.
                        strip <= 0; y0 <= 0; m_addr <= base; state <= S_CMD;
                    end else begin
                        strip <= strip + 9'd1; y0 <= y0 + STRIP; state <= S_CMD;
                    end
                end
                default: state <= S_IDLE;
            endcase
        end
    end
endmodule
