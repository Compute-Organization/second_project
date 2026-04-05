`timescale 1 ns / 1 ps

module tb_processing_unit_verilog();

    reg  [7:0] dataa_tb;
    reg  [7:0] datab_tb;
    reg  [2:0] selop_tb;
    wire [7:0] result_tb;
    wire       cout_tb;

    processing_unit #(
        .N(8)
    ) DUT (
        .dataa (dataa_tb),
        .datab (datab_tb),
        .selop (selop_tb),
        .result(result_tb),
        .cout  (cout_tb)
    );

    initial begin

        // CASE 0: selop=000 -> B.
        dataa_tb = 8'h3C;
        datab_tb = 8'hA5;
        selop_tb = 3'b000;
        #200;

        // CASE 1: selop=001 -> NOT B.
        dataa_tb = 8'h3C;
        datab_tb = 8'hA5;
        selop_tb = 3'b001;
        #200;

        // CASE 2: selop=010 -> A AND B.
        dataa_tb = 8'hCC;
        datab_tb = 8'hAA;
        selop_tb = 3'b010;
        #200;

        // CASE 3: selop=011 -> A OR B.
        dataa_tb = 8'h0C;
        datab_tb = 8'hA0;
        selop_tb = 3'b011;
        #200;

        // CASE 4: selop=100 -> A XOR B.
        dataa_tb = 8'hF0;
        datab_tb = 8'h5A;
        selop_tb = 3'b100;
        #200;

        // CASE 5: selop=101 -> A + B, no carry.
        dataa_tb = 8'd3;
        datab_tb = 8'd5;
        selop_tb = 3'b101;
        #200;

        // CASE 6: selop=101 -> A + B, with carry.
        dataa_tb = 8'd200;
        datab_tb = 8'd100;
        selop_tb = 3'b101;
        #200;

        // CASE 7: selop=110 -> B + 1.
        dataa_tb = 8'd0;
        datab_tb = 8'd7;
        selop_tb = 3'b110;
        #200;

        // CASE 8: selop=110 -> B + 1, overflow.
        dataa_tb = 8'd0;
        datab_tb = 8'hFF;
        selop_tb = 3'b110;
        #200;

        // CASE 9: selop=111 -> -B.
        dataa_tb = 8'd0;
        datab_tb = 8'd5;
        selop_tb = 3'b111;
        #200;

        // CASE 10: selop=111 -> -0.
        dataa_tb = 8'd0;
        datab_tb = 8'd0;
        selop_tb = 3'b111;
        #200;

        $stop;
    end

endmodule
