module flag_register #(parameter MAX_WIDTH = 8)
(
    input wire clk,                     // Clock input.
    input wire rst,                     // Asynchronous reset.
    input wire enaf,                    // Flag register enable.
    input wire [MAX_WIDTH-1:0] dataa,   // Data used to generate flags.
    input wire carry,                   // Carry input from arithmetic unit.
    output reg C,                       // Carry flag.
    output reg N,                       // Negative flag.
    output reg P,                       // Parity flag.
    output reg Z                        // Zero flag.
);

// Sequential flag register (only on the rising edge of clk when enaf is active):
always @(posedge clk, posedge rst) begin
    if (rst) begin
        C <= 1'b0;
        N <= 1'b0;
        P <= 1'b0;
        Z <= 1'b0;
    end else if (enaf) begin
        C <= carry;
        N <= dataa[MAX_WIDTH-1];
        P <= ~(dataa[7] ^ dataa[6] ^ dataa[5] ^ dataa[4] ^ dataa[3] ^ dataa[2] ^ dataa[1] ^ dataa[0]);
        Z <= (dataa == {MAX_WIDTH{1'b0}});
    end
end

endmodule
