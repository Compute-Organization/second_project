module nbit_adder #(parameter N = 8)
(
    input wire [N-1:0] a,   // Operand A.
    input wire [N-1:0] b,   // Operand B.
    input wire cin,         // Initial carry in.
    output wire [N-1:0] s,  // N-bit sum result.
    output wire cout        // Final carry out.
);

// We create signals for hold the middle results:
wire [N:0] carry;

// Connect external carry in to the first full adder.
assign carry[0] = cin;

// Generate N full adders to build the ripple-carry adder:
genvar i;
generate
    for (i = 0; i < N; i = i + 1) begin : adder
        full_adder fa(
            .a(a[i]),
            .b(b[i]),
            .cin(carry[i]),
            .s(s[i]),
            .cout(carry[i+1])   // Carry to next stage.
        );
    end
endgenerate

// Final carry out from the most significant stage.
assign cout = carry[N];

endmodule