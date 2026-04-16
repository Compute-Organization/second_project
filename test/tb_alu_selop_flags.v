`timescale 1 ns / 1 ps

module tb_alu_selop_flags();

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
        input [7:0] a_in;
        input [7:0] b_in;
        input [2:0] sel_in;
        input       enaf_in;
        begin
            // Inputs are updated on the falling edge so they are stable
            // before the next rising edge, just as they would arrive from
            // the control unit in the processor.
            @(negedge clk_tb);
            busA_tb  = a_in;
            busB_tb  = b_in;
            selop_tb = sel_in;
            shamt_tb = 2'b00;
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

        // CASE 1: selop=000 -> B.
        apply_case(8'h3C, 8'hA5, 3'b000, 1'b1);

        // CASE 2: selop=001 -> NOT B.
        apply_case(8'h3C, 8'hA5, 3'b001, 1'b1);

        // CASE 3: selop=010 -> A AND B.
        apply_case(8'hCC, 8'hAA, 3'b010, 1'b1);

        // CASE 4: selop=011 -> A OR B.
        apply_case(8'h0C, 8'hA0, 3'b011, 1'b1);

        // CASE 5: selop=100 -> A XOR B.
        apply_case(8'hF0, 8'h5A, 3'b100, 1'b1);

        // CASE 6: selop=101 -> A + B.
        apply_case(8'd10, 8'd20, 3'b101, 1'b1);

        // CASE 7: selop=110 -> B + 1.
        apply_case(8'd0, 8'd7, 3'b110, 1'b1);

        // CASE 8: selop=111 -> -B.
        apply_case(8'd0, 8'd5, 3'b111, 1'b1);

        // CASE 9: zero-result arithmetic case -> Z must become 1.
        apply_case(8'd0, 8'd0, 3'b111, 1'b1);

        // CASE 10: negative result from -B -> N must become 1.
        apply_case(8'd0, 8'd200, 3'b111, 1'b1);

        // CASE 11: carry generation in A + B -> C must become 1.
        apply_case(8'hFF, 8'h01, 3'b101, 1'b1);

        // CASE 12: disabled flags -> busC changes, flags must hold.
        apply_case(8'hAA, 8'h55, 3'b100, 1'b0);

        $stop;
    end

endmodule
