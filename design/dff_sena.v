module dff_sena (
    input wire clk, // Clock input.
    input wire rst, // Asynchronous reset.
    input wire ena, // Enable signal.
    input wire d,   // Data input.
    output reg q    // Registered output.
);

// D flip-flop with asynchronous reset and synchronous enable:
always @(posedge clk, posedge rst) begin
    if (rst) begin
        q <= 1'b0;          // Reset output to zero.
    end else if (ena) begin
        q <= d;             // Load input data only when enable is active.
    end
end

endmodule