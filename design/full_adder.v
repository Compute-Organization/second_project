module full_adder (
    input wire a,       // Bit a.
    input wire b,       // Bit b.
    input wire cin,     // Carry in.
    output wire s,      // Partial sum result.
    output wire cout    // Carry out result.
);

// 1-bit full adder.
assign s = a ^ b ^ cin;                         // Sum.
assign cout = (a & b) | (a & cin) | (b & cin);  // Carry out.

endmodule