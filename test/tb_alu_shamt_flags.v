`timescale 1 ns / 1 ps

module tb_alu_shamt_flags();

    reg        clk_tb;
    reg        rst_tb;
    reg        enaf_tb;
    reg  [7:0] busA_tb;
    reg  [7:0] busB_tb;
    reg  [2:0] selop_tb;
    reg  [1:0] shamt_tb;
    wire [7:0] busC_tb;
    wire       C_tb;
    wire       N_tb;
    wire       P_tb;
    wire       Z_tb;

    alu #(
        .MAX_WIDTH(8)
    ) DUT (
        .clk  (clk_tb),
        .rst  (rst_tb),
        .busA (busA_tb),
        .busB (busB_tb),
        .selop(selop_tb),
        .shamt(shamt_tb),
        .enaf (enaf_tb),
        .busC (busC_tb),
        .C    (C_tb),
        .N    (N_tb),
        .P    (P_tb),
        .Z    (Z_tb)
    );

    always #50 clk_tb = ~clk_tb;

    task apply_case;
        input [7:0] b_in;
        input [1:0] shamt_in;
        input       enaf_in;
        begin
            // In this test, selop remains fixed in PASS B and the inputs are
            // updated one half-cycle before the active rising edge.
            @(negedge clk_tb);
            busA_tb  = 8'h00;
            busB_tb  = b_in;
            selop_tb = 3'b000;
            shamt_tb = shamt_in;
            enaf_tb  = enaf_in;
            @(posedge clk_tb);
            #1;
        end
    endtask

    initial begin
        clk_tb   = 1'b0;
        rst_tb   = 1'b1;
        enaf_tb  = 1'b0;
        busA_tb  = 8'h00;
        busB_tb  = 8'h00;
        selop_tb = 3'b000;
        shamt_tb = 2'b00;

        // CASE 0: asynchronous reset.
        #120;
        rst_tb = 1'b0;

        // CASE 1: shamt=00 -> no shift.
        apply_case(8'b10110111, 2'b00, 1'b1);

        // CASE 2: shamt=01 -> logical right shift.
        apply_case(8'b10110111, 2'b01, 1'b1);

        // CASE 3: shamt=10 -> logical left shift.
        apply_case(8'b10110111, 2'b10, 1'b1);

        // CASE 4: shamt=11 -> output forced to zero.
        apply_case(8'b10110111, 2'b11, 1'b1);

        // CASE 5: MSB active without shift -> N must become 1.
        apply_case(8'h80, 2'b00, 1'b1);

        // CASE 6: same data with left shift -> busC changes but flags follow result.
        apply_case(8'h80, 2'b10, 1'b1);

        // CASE 7: small value with right shift.
        apply_case(8'h01, 2'b01, 1'b1);

        // CASE 8: zero input with right shift -> Z must become 1.
        apply_case(8'h00, 2'b01, 1'b1);

        // CASE 9: disabled flags -> busC changes, flags must hold.
        apply_case(8'h55, 2'b10, 1'b0);

        $stop;
    end

endmodule
