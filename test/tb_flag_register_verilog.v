`timescale 1 ns / 1 ps

module tb_flag_register_verilog();

    reg        clk_tb;
    reg        rst_tb;
    reg        enaf_tb;
    reg  [7:0] dataa_tb;
    reg        carry_tb;
    wire       C_tb;
    wire       N_tb;
    wire       P_tb;
    wire       Z_tb;

    flag_register #(
        .MAX_WIDTH(8)
    ) DUT (
        .clk  (clk_tb),
        .rst  (rst_tb),
        .enaf (enaf_tb),
        .dataa(dataa_tb),
        .carry(carry_tb),
        .C    (C_tb),
        .N    (N_tb),
        .P    (P_tb),
        .Z    (Z_tb)
    );

    always #50 clk_tb = ~clk_tb;

    task apply_case;
        input [7:0] data_in;
        input       carry_in;
        input       enaf_in;
        begin
            @(negedge clk_tb);
            dataa_tb = data_in;
            carry_tb = carry_in;
            enaf_tb  = enaf_in;
            @(posedge clk_tb);
            #1;
        end
    endtask

    integer i;
    integer c;

    initial begin
        clk_tb   = 1'b0;
        rst_tb   = 1'b1;
        enaf_tb  = 1'b0;
        dataa_tb = 8'h00;
        carry_tb = 1'b0;

        // CASE 0: asynchronous reset.
        #120;
        rst_tb = 1'b0;

        // CASE 1: disabled register must hold its value.
        apply_case(8'hAA, 1'b1, 1'b0);

        // CASE 2: zero result.
        apply_case(8'h00, 1'b0, 1'b1);

        // CASE 3: negative result.
        apply_case(8'h80, 1'b0, 1'b1);

        // CASE 4: carry flag active.
        apply_case(8'h01, 1'b1, 1'b1);

        // CASE 5: even parity.
        apply_case(8'h03, 1'b0, 1'b1);

        // CASE 6: odd parity.
        apply_case(8'h07, 1'b0, 1'b1);

        // CASE 7: disabled again, flags must remain unchanged.
        apply_case(8'hFF, 1'b1, 1'b0);

        // CASE 8: compact exhaustive sweep of carry and data.
        for (c = 0; c < 2; c = c + 1) begin
            for (i = 0; i < 256; i = i + 1) begin
                apply_case(i[7:0], c[0], 1'b1);
            end
        end

        $stop;
    end

endmodule
