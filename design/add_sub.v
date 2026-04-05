module add_sub #(parameter N = 8)
(
    input wire [N-1:0] a,   // Operand A.
    input wire [N-1:0] b,   // Operand B.
    input wire addn_sub,    // Operation selector: 0 = add, 1 = subtract.
    output wire [N-1:0] s,  // Arithmetic result.
    output wire cout        // Carry out / borrow-related output.
);

// We create signals for hold the middle results:
wire [N-1:0] bxor;
wire [N-1:0] add_nsub_vector;

// If addn_sub = 0 -> vector = 000...N, so B is unchanged.
// If addn_sub = 1 -> vector = 111...N, so B is inverted.
assign add_nsub_vector = {N{addn_sub}};

// Conditional inversion of B:
assign bxor = b ^ add_nsub_vector;

// N-bit adder used for both operations:
nbit_adder #(.N(N)) adder_instance (
    .a(a),
    .b(bxor),
    .cin(addn_sub),
    .s(s),
    .cout(cout)
);

endmodule