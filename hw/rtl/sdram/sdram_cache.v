// sdram_cache.v — direct-mapped, write-through, 1-word-line cache in
// front of sdram_ctrl. Same valid/ready port on both sides. The core is
// single-issue with one memory port and there is no DMA into this port, so a
// unified cache needs no coherence logic (write hits update the line).
//   hit  : 2 clocks (lookup + data)     miss: lookup + one SDRAM access
//   write: always writes a FULL word to SDRAM (see below), line updated
// Reset flushes the tag array (LINES clocks) before accepting requests.
//
// Sub-word writes never go to SDRAM as byte/halfword (DQM-masked) writes: a
// DQM-masked write is not honoured reliably by this SDRAM datapath (it worked
// in sim but silently dropped the byte on real hardware, so a second master —
// the display engine reading SDRAM directly — saw stale data). Instead the
// cache does read-modify-write and always issues wstrb=1111 to sdram_ctrl:
//   sub-word HIT : merge the new bytes into the cached word, write it back.
//   sub-word MISS: read the word from SDRAM, merge, write it back (and fill).
module sdram_cache #(
    parameter integer LINES = 2048          // words; 2048 = 8 KB data + 22 Kbit tags
) (
    input  wire        clk,
    input  wire        rst,
    input  wire        inval,      // pulse: invalidate everything (after a DMA into the SDRAM)
    output wire        flushing,
    // CPU side
    input  wire        valid,
    output reg         ready,
    input  wire [20:0] addr,
    input  wire [31:0] wdata,
    input  wire [3:0]  wstrb,
    output reg  [31:0] rdata,
    // memory side (sdram_ctrl)
    output reg         m_valid,
    input  wire        m_ready,
    output reg  [20:0] m_addr,
    output reg  [31:0] m_wdata,
    output reg  [3:0]  m_wstrb,
    input  wire [31:0] m_rdata
);
    localparam integer IW = $clog2(LINES);
    localparam integer TW = 21 - IW;

    reg  [TW:0]  tags [0:LINES-1];          // {valid, tag}
    reg  [TW:0]  tag_q;
    reg  [7:0]   d0 [0:LINES-1]; reg [7:0] d1 [0:LINES-1]; reg [7:0] d2 [0:LINES-1]; reg [7:0] d3 [0:LINES-1];
    reg  [7:0]   q0, q1, q2, q3;

    localparam S_FLUSH = 3'd0, S_IDLE = 3'd1, S_LOOKUP = 3'd2, S_MEMR = 3'd3,
               S_MEMW = 3'd4, S_RMWR = 3'd5;
    reg [2:0]   state;
    reg [IW-1:0] fidx;
    reg [20:0]  a_lat; reg [31:0] wd_lat; reg [3:0] ws_lat;

    wire [IW-1:0] idx     = addr[IW-1:0];
    wire [IW-1:0] idx_lat = a_lat[IW-1:0];
    wire [TW-1:0] tag_lat = a_lat[20:IW];
    wire          hit     = tag_q[TW] && (tag_q[TW-1:0] == tag_lat);
    wire          is_wr   = (ws_lat != 4'b0);
    wire          full_wr = (ws_lat == 4'hF);
    assign flushing = (state == S_FLUSH);

    // per-byte write mask + merge helpers (RMW builds a full word every time)
    wire [31:0] wmask      = {{8{ws_lat[3]}}, {8{ws_lat[2]}}, {8{ws_lat[1]}}, {8{ws_lat[0]}}};
    wire [31:0] line_word  = {q3, q2, q1, q0};
    wire [31:0] merge_line = (line_word & ~wmask) | (wd_lat & wmask);   // sub-word hit
    wire [31:0] merge_mem  = (m_rdata   & ~wmask) | (wd_lat & wmask);   // sub-word miss (RMW read)

    // tag / data array ports (synchronous read; write in LOOKUP/MEMR/RMWR)
    reg  [3:0]   we_lanes;             // byte lanes to update
    reg  [31:0]  wline;
    reg  [IW-1:0] widx;
    reg          we_tag; reg [TW:0] wtag;
    always @(posedge clk) begin
        if (we_tag) tags[widx] <= wtag;
        tag_q <= tags[idx];
    end
    always @(posedge clk) begin if (we_lanes[0]) d0[widx] <= wline[7:0];   q0 <= d0[idx]; end
    always @(posedge clk) begin if (we_lanes[1]) d1[widx] <= wline[15:8];  q1 <= d1[idx]; end
    always @(posedge clk) begin if (we_lanes[2]) d2[widx] <= wline[23:16]; q2 <= d2[idx]; end
    always @(posedge clk) begin if (we_lanes[3]) d3[widx] <= wline[31:24]; q3 <= d3[idx]; end

    always @(*) begin
        we_lanes = 4'b0; wline = 32'b0; widx = idx_lat; we_tag = 1'b0; wtag = {1'b1, tag_lat};
        case (state)
            S_FLUSH: begin we_tag = 1'b1; widx = fidx; wtag = {(TW+1){1'b0}}; end
            S_LOOKUP: if (is_wr && hit) begin we_lanes = ws_lat; wline = wd_lat; end
            // sub-word write miss: the RMW read fills the line with the merged
            // word (old bytes from SDRAM + the new bytes), tag now valid.
            S_RMWR:   if (m_ready) begin we_lanes = 4'hF; wline = merge_mem; we_tag = 1'b1; end
            // load miss: fill the line from SDRAM.
            S_MEMR:   if (m_ready) begin we_lanes = 4'hF; wline = m_rdata; we_tag = 1'b1; end
            default: ;
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= S_FLUSH; fidx <= 0; ready <= 0; rdata <= 0; m_valid <= 0; m_addr <= 0; m_wdata <= 0; m_wstrb <= 0;
            a_lat <= 0; wd_lat <= 0; ws_lat <= 0;
        end else begin
            ready <= 1'b0;
            case (state)
            S_FLUSH: begin
                fidx <= fidx + 1'b1;
                if (fidx == LINES - 1) state <= S_IDLE;
            end
            S_IDLE: begin
                if (inval) begin fidx <= 0; state <= S_FLUSH; end
                else if (valid && !ready) begin
                    a_lat <= addr; wd_lat <= wdata; ws_lat <= wstrb;
                    state <= S_LOOKUP;                 // tag_q / q* valid next cycle
                end
            end
            S_LOOKUP: begin
                if (is_wr) begin
                    // Always write a full word to SDRAM (never DQM-masked).
                    if (full_wr) begin
                        m_valid <= 1'b1; m_addr <= a_lat; m_wdata <= wd_lat; m_wstrb <= 4'hF;
                        state <= S_MEMW;
                    end else if (hit) begin
                        m_valid <= 1'b1; m_addr <= a_lat; m_wdata <= merge_line; m_wstrb <= 4'hF;
                        state <= S_MEMW;
                    end else begin
                        // sub-word miss: read the current word first (RMW).
                        m_valid <= 1'b1; m_addr <= a_lat; m_wstrb <= 4'b0;
                        state <= S_RMWR;
                    end
                end else if (hit) begin
                    rdata <= line_word; ready <= 1'b1; state <= S_IDLE;
                end else begin
                    m_valid <= 1'b1; m_addr <= a_lat; m_wstrb <= 4'b0;
                    state <= S_MEMR;
                end
            end
            S_RMWR: begin
                // read done -> issue the merged full-word write back.
                if (m_ready) begin
                    m_valid <= 1'b1; m_addr <= a_lat; m_wdata <= merge_mem; m_wstrb <= 4'hF;
                    state <= S_MEMW;
                end
            end
            S_MEMR: begin
                if (m_ready) begin m_valid <= 1'b0; rdata <= m_rdata; ready <= 1'b1; state <= S_IDLE; end
            end
            S_MEMW: begin
                if (m_ready) begin m_valid <= 1'b0; ready <= 1'b1; state <= S_IDLE; end
            end
            default: state <= S_IDLE;
            endcase
        end
    end
endmodule
