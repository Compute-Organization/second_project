`timescale 1ns / 1ps

module shift_unit #(parameter N = 8)
(
    input wire [1:0] shamt,     // Shift configuration.
    input wire [N-1:0] dataa,   // Post processing data result.
    output reg [N-1:0] dataout  // result.
);

// Procedural statement combinational shift logic:
always @* begin
    case (shamt)
        2'b00: dataout = dataa;                 // No shift - 00.
        2'b01: dataout = {1'b0, dataa[N-1:1]};  // Shift Right Logical (SRL) - 01.
        2'b10: dataout = {dataa[N-2:0], 1'b0};  // Shift Left Logical (SRL) - 01.
        default: dataout = {N{1'b0}};           // No used - 11, so just fill with zeros.
    endcase
end

endmodule