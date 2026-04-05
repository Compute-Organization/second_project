`timescale 1ns / 1ps

module alu #(parameter MAX_WIDTH = 8)
(
    input wire clk,                     // Synchronous clock.
    input wire rst,                     // Restart device (all internal values restarted).
    input wire [MAX_WIDTH-1:0] busA,    // 0 to 8 A bits input.
    input wire [MAX_WIDTH-1:0] busB,    // 0 to 8 B bits input.
    input wire [2:0] selop,             // Select Operation look up table. 
    input wire [1:0] shamt,             // Shift configuration.
    input wire enaf,                    // Able or disable device.
    output wire [MAX_WIDTH-1:0] busC,   // Output operation result.
    output wire C, N, Z, P              // Flags.
);

// We create signals for hold the middle results:
wire[MAX_WIDTH-1:0] result;
wire cout;

// performs the ALU selected gated operation process: 
processing_unit #(.N(MAX_WIDTH)) pu (
    .dataa(busA),
    .datab(busB),
    .selop(selop),
    .result(result),
    .cout(cout)
);

// Performs the ALU selected shift operation process:
shift_unit #(.N(MAX_WIDTH)) su (
    .shamt(shamt),
    .dataa(result),
    .dataout(busC)
);

// Performs the ALU flag behavior response:
flag_register #(.MAX_WIDTH(MAX_WIDTH)) fr (
    .clk(clk),
    .rst(rst),
    .enaf(enaf),
    .dataa(result),
    .carry(cout),
    .C(C),
    .N(N),
    .P(P),
    .Z(Z)
);

endmodule