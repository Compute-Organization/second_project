module processing_unit #(parameter N = 8)
(
    input wire [N-1:0] dataa,   // Operand A.
    input wire [N-1:0] datab,   // Operand B.
    input wire [2:0] selop,     // Operation selector.
    output reg [N-1:0] result,  // Selected processing result.
    output wire cout            // Carry out for arithmetic operations.
);

// We create signals for hold the middle results:
wire [N-1:0] not_b;
wire [N-1:0] a_and_b;
wire [N-1:0] a_or_b;
wire [N-1:0] a_xor_b;
wire [N-1:0] a_plus_b;
wire [N-1:0] b_plus_one;
wire [N-1:0] neg_b;
wire c_add, c_plus1, c_negB;

// Pure combinational logic operations:
assign not_b = ~datab;
assign a_and_b = dataa & datab;
assign a_or_b = dataa | datab;
assign a_xor_b = dataa ^ datab;

// Arithmetic operation: A + B:
add_sub #(.N(N)) AplusB (
    .a(dataa),
    .b(datab),
    .addn_sub(1'b0),
    .s(a_plus_b),
    .cout(c_add)
);

// Arithmetic operation: B + 1:
add_sub #(.N(N)) Bplus1 (
    .a(datab),
    .b({{(N-1){1'b0}}, 1'b1}),
    .addn_sub(1'b0),
    .s(b_plus_one),
    .cout(c_plus1)
);

// Arithmetic operation: -B = 0 - B:
add_sub #(.N(N)) negB (
    .a({N{1'b0}}),
    .b(datab),
    .addn_sub(1'b1),
    .s(neg_b),
    .cout(c_negB)
);

// Main result selection logic:
always @* begin
    case (selop)
        3'b000: result = datab;
        3'b001: result = not_b;
        3'b010: result = a_and_b;
        3'b011: result = a_or_b;
        3'b100: result = a_xor_b;
        3'b101: result = a_plus_b;
        3'b110: result = b_plus_one;
        default: result = neg_b;
    endcase
end

// Carry output management:
assign cout =   (selop[1:0] == 2'b01) ? c_add :
                (selop[1:0] == 2'b10) ? c_plus1 : 
                (selop[1:0] == 2'b11) ? c_negB : 1'b0;

endmodule