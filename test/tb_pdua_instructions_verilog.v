`timescale 1 ns / 1 ps

module tb_pdua_instructions_verilog();

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

    task issue_control_sequence;
        input [7:0] a_in;
        input [7:0] b_in;
        input [2:0] sel_in;
        input [1:0] shamt_in;
        begin
            @(negedge clk_tb);
            busA_tb  = a_in;
            busB_tb  = b_in;
            selop_tb = sel_in;
            shamt_tb = shamt_in;
            enaf_tb  = 1'b1;
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

        // CASE 0: reset sequence.
        #120;
        rst_tb = 1'b0;

        // CASE 1: B.
        issue_control_sequence(8'h00, 8'h55, 3'b000, 2'b00);

        // CASE 2: NOT B.
        issue_control_sequence(8'h00, 8'h55, 3'b001, 2'b00);

        // CASE 3: A AND B.
        issue_control_sequence(8'hF0, 8'h5A, 3'b010, 2'b00);

        // CASE 4: A OR B.
        issue_control_sequence(8'hF0, 8'h0A, 3'b011, 2'b00);

        // CASE 5: A XOR B.
        issue_control_sequence(8'hFF, 8'h0F, 3'b100, 2'b00);

        // CASE 6: A + B.
        issue_control_sequence(8'd25, 8'd10, 3'b101, 2'b00);

        // CASE 7: A + B with shift right.
        issue_control_sequence(8'd25, 8'd10, 3'b101, 2'b01);

        // CASE 8: B + 1 with shift left.
        issue_control_sequence(8'd0, 8'h7F, 3'b110, 2'b10);

        // CASE 9: -B.
        issue_control_sequence(8'd0, 8'd5, 3'b111, 2'b00);

        // CASE 10: -0 to verify zero flag.
        issue_control_sequence(8'd0, 8'd0, 3'b111, 2'b00);

        // CASE 11: B + 1 overflow to verify carry and zero behavior.
        issue_control_sequence(8'd0, 8'hFF, 3'b110, 2'b00);

        // CASE 12: output forced to zero by shamt=11.
        issue_control_sequence(8'h00, 8'h3C, 3'b000, 2'b11);

        $stop;
    end

endmodule
