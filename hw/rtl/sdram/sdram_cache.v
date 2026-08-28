// sdram_cache.v — direct-mapped, write-through, 1-word-line cache in
// front of sdram_ctrl. Same valid/ready port on both sides. The core is
// single-issue with one memory port and there is no DMA, so a unified
// cache needs no coherence logic (write hits update the line).
//   hit  : 2 clocks (lookup + data)     miss: lookup + one SDRAM access
//   write: always goes to SDRAM (write-through), line updated on hit
// Reset flushes the tag array (LINES clocks) before accepting requests.
module sdram_cache #(
    parameter integer LINES = 2048          // words; 2048 = 8 KB data + 22 Kbit tags
) (
    input  wire        clk,
    input  wire        rst,
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

    localparam S_FLUSH = 3'd0, S_IDLE = 3'd1, S_LOOKUP = 3'd2, S_MEMR = 3'd3, S_MEMW = 3'd4;
    reg [2:0]   state;
    reg [IW-1:0] fidx;
    reg [20:0]  a_lat; reg [31:0] wd_lat; reg [3:0] ws_lat;

    wire [IW-1:0] idx     = addr[IW-1:0];
    wire [IW-1:0] idx_lat = a_lat[IW-1:0];
    wire [TW-1:0] tag_lat = a_lat[20:IW];
    wire          hit     = tag_q[TW] && (tag_q[TW-1:0] == tag_lat);
    wire          is_wr   = (ws_lat != 4'b0);

    // tag / data array ports (synchronous read; write in LOOKUP/MEMR)
    reg          we_line;              // write whole line (fill)
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
                if (valid && !ready) begin
                    a_lat <= addr; wd_lat <= wdata; ws_lat <= wstrb;
                    state <= S_LOOKUP;                 // tag_q / q* valid next cycle
                end
            end
            S_LOOKUP: begin
                if (is_wr) begin
                    m_valid <= 1'b1; m_addr <= a_lat; m_wdata <= wd_lat; m_wstrb <= ws_lat;
                    state <= S_MEMW;
                end else if (hit) begin
                    rdata <= {q3, q2, q1, q0}; ready <= 1'b1; state <= S_IDLE;
                end else begin
                    m_valid <= 1'b1; m_addr <= a_lat; m_wstrb <= 4'b0;
                    state <= S_MEMR;
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
