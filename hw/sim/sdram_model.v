// sdram_model.v — behavioural SDR SDRAM (2M x 32, CL=2, BL=1) for sim.
// Checks the command protocol loosely (no timing checks); auto-precharge
// only. Storage is a sparse-ish plain array (8 MB of 32-bit words).
`timescale 1ns/1ps
module sdram_model (
    input  wire        clk,
    input  wire        cke,
    input  wire        cs_n, ras_n, cas_n, we_n,
    input  wire [10:0] addr,
    input  wire [1:0]  ba,
    input  wire [3:0]  dqm,
    inout  wire [31:0] dq
);
    reg [31:0] mem [0:2*1024*1024-1];
    reg [10:0] row [0:3];
    reg        act [0:3];
    reg [31:0] pipe0, pipe1; reg oe0, oe1, oe2; reg [31:0] dout;
    integer i; initial for (i = 0; i < 4; i = i + 1) act[i] = 0;
    wire [3:0] cmd = {cs_n, ras_n, cas_n, we_n};
    reg [31:0] wmask;
    always @(posedge clk) begin
        // read pipeline: data out CL=2 after READ command
        pipe1 <= pipe0; oe1 <= oe0; oe2 <= oe1; oe0 <= 0;
        case (cmd)
            4'b0011: begin row[ba] <= addr; act[ba] <= 1; end                      // ACTIVE
            4'b0101: begin                                                         // READ
                if (!act[ba]) $display("[sdram] READ on inactive bank %0d", ba);
                pipe0 <= mem[{ba, row[ba], addr[7:0]}]; oe0 <= 1;
                if (addr[10]) act[ba] <= 0;
            end
            4'b0100: begin                                                         // WRITE
                if (!act[ba]) $display("[sdram] WRITE on inactive bank %0d", ba);
                wmask = {{8{~dqm[3]}}, {8{~dqm[2]}}, {8{~dqm[1]}}, {8{~dqm[0]}}};
                mem[{ba, row[ba], addr[7:0]}] <= (mem[{ba, row[ba], addr[7:0]}] & ~wmask) | (dq & wmask);
                if (addr[10]) act[ba] <= 0;
            end
            4'b0010: begin if (addr[10]) begin act[0] <= 0; act[1] <= 0; act[2] <= 0; act[3] <= 0; end else act[ba] <= 0; end
            default: ;
        endcase
    end
    // CL=2: READ sampled at edge N → data driven after edge N+2 (pipe1 holds it after 2 edges)
    assign dq = oe2 ? pipe1 : 32'bz;
endmodule
