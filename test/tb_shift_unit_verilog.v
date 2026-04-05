`timescale 1 ns / 1 ps

module tb_shift_unit_verilog();

    reg  [1:0] shamt_tb;
    reg  [7:0] dataa_tb;
    wire [7:0] dataout_tb;

    shift_unit #(
        .N(8)
    ) DUT (
        .shamt  (shamt_tb),
        .dataa  (dataa_tb),
        .dataout(dataout_tb)
    );

    initial begin

        // CASE 0: shamt=00 -> No shift.
        dataa_tb = 8'b10110011;
        shamt_tb = 2'b00;
        #200;

        // CASE 1: shamt=01 -> Logical right shift by 1.
        dataa_tb = 8'b10110011;
        shamt_tb = 2'b01;
        #200;

        // CASE 2: shamt=10 -> Logical left shift by 1.
        dataa_tb = 8'b10110011;
        shamt_tb = 2'b10;
        #200;

        // CASE 3: shamt=11 -> Not used, output forced to zero.
        dataa_tb = 8'b10110011;
        shamt_tb = 2'b11;
        #200;

        // CASE 4: left shift overflows the MSB.
        dataa_tb = 8'b10000001;
        shamt_tb = 2'b10;
        #200;

        // CASE 5: right shift drops the LSB.
        dataa_tb = 8'b00000001;
        shamt_tb = 2'b01;
        #200;

        // CASE 6: zero input stays zero.
        dataa_tb = 8'b00000000;
        shamt_tb = 2'b00;
        #200;

        $stop;
    end

endmodule
