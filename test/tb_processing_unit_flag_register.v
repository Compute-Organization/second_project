`timescale 1 ns / 1 ps

module tb_processing_unit_flag_register();

    reg        clk_tb;
    reg        rst_tb;
    reg        enaf_tb;
    reg  [7:0] dataa_tb;
    reg  [7:0] datab_tb;
    reg  [2:0] selop_tb;
    wire [7:0] result_tb;
    wire       cout_tb;
    wire       C_tb;
    wire       N_tb;
    wire       P_tb;
    wire       Z_tb;

    processing_unit #(
        .N(8)
    ) DUT_PU (
        .dataa (dataa_tb),
        .datab (datab_tb),
        .selop (selop_tb),
        .result(result_tb),
        .cout  (cout_tb)
    );

    flag_register #(
        .MAX_WIDTH(8)
    ) DUT_FR (
        .clk  (clk_tb),
        .rst  (rst_tb),
        .enaf (enaf_tb),
        .dataa(result_tb),
        .carry(cout_tb),
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
            // Inputs are changed on the falling edge so the new processing
            // result arrives before the next rising edge, where the flags are
            // actually registered.
            @(negedge clk_tb);
            dataa_tb = a_in;
            datab_tb = b_in;
            selop_tb = sel_in;
            enaf_tb  = enaf_in;
            @(posedge clk_tb);
            #1;
        end
    endtask

    initial begin
        clk_tb   = 1'b0;
        rst_tb   = 1'b1;
        enaf_tb  = 1'b0;
        dataa_tb = 8'h00;
        datab_tb = 8'h00;
        selop_tb = 3'b000;

        // CASE 0: asynchronous reset.
        #120;
        rst_tb = 1'b0;

        // CASE 1: PASS B.
        apply_case(8'h00, 8'hA5, 3'b000, 1'b1);

        // CASE 2: A AND B.
        apply_case(8'hCC, 8'hAA, 3'b010, 1'b1);

        // CASE 3: A + B without carry.
        apply_case(8'd10, 8'd20, 3'b101, 1'b1);

        // CASE 4: A + B with carry.
        apply_case(8'hFF, 8'h01, 3'b101, 1'b1);

        // CASE 5: -B with zero result.
        apply_case(8'h00, 8'h00, 3'b111, 1'b1);

        // CASE 6: -B with negative result.
        apply_case(8'h00, 8'd200, 3'b111, 1'b1);

        // CASE 7: flags disabled, result changes but flags must hold.
        apply_case(8'hF0, 8'h0F, 3'b100, 1'b0);

        $stop;
    end

endmodule
