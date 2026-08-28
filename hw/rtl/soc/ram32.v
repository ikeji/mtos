// ram32.v — 32-bit wide RAM with byte enables, built from four
// independent 8-bit memories (yosys maps these to Gowin BSRAM cleanly;
// a single 32-bit memory with byte enables did not). Synchronous read,
// data valid the cycle after `addr` is presented. Init files come from
// tools/bin2hex.py (INIT.b0 .. INIT.b3).
module ram32 #(
    parameter integer WORDS = 8192,
    parameter         INIT  = ""
) (
    input  wire                     clk,
    input  wire [$clog2(WORDS)-1:0] addr,   // word address
    input  wire [31:0]              wdata,
    input  wire [3:0]               we,
    output wire [31:0]              rdata
);
    reg [7:0] ram0 [0:WORDS-1];
    reg [7:0] ram1 [0:WORDS-1];
    reg [7:0] ram2 [0:WORDS-1];
    reg [7:0] ram3 [0:WORDS-1];
    initial if (INIT != "") begin
        $readmemh({INIT, ".b0"}, ram0);
        $readmemh({INIT, ".b1"}, ram1);
        $readmemh({INIT, ".b2"}, ram2);
        $readmemh({INIT, ".b3"}, ram3);
    end
    reg [7:0] q0, q1, q2, q3;
    always @(posedge clk) begin if (we[0]) ram0[addr] <= wdata[7:0];   q0 <= ram0[addr]; end
    always @(posedge clk) begin if (we[1]) ram1[addr] <= wdata[15:8];  q1 <= ram1[addr]; end
    always @(posedge clk) begin if (we[2]) ram2[addr] <= wdata[23:16]; q2 <= ram2[addr]; end
    always @(posedge clk) begin if (we[3]) ram3[addr] <= wdata[31:24]; q3 <= ram3[addr]; end
    assign rdata = {q3, q2, q1, q0};
endmodule
