`timescale 1 ns / 1 ps

module tb_alu_combined;

    reg        clk_tb;
    reg        rst_tb;
    reg        enaf_next;
    reg  [7:0] busA_next;
    reg  [7:0] busB_next;
    reg  [2:0] selop_next;
    reg  [1:0] shamt_next;
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
        .clk   (clk_tb),
        .rst   (rst_tb),
        .busA  (busA_tb),
        .busB  (busB_tb),
        .selop (selop_tb),
        .shamt (shamt_tb),
        .enaf  (enaf_tb),
        .busC  (busC_tb),
        .C     (C_tb),
        .N     (N_tb),
        .P     (P_tb),
        .Z     (Z_tb)
    );

    // Clock
    initial begin
        clk_tb = 1'b0;
        forever #50 clk_tb = ~clk_tb;
    end

    always @(posedge clk_tb or posedge rst_tb) begin
        if (rst_tb) begin
            enaf_tb  <= 1'b0;
            busA_tb  <= 8'h00;
            busB_tb  <= 8'h00;
            selop_tb <= 3'b000;
            shamt_tb <= 2'b00;
        end else begin
            enaf_tb  <= enaf_next;
            busA_tb  <= busA_next;
            busB_tb  <= busB_next;
            selop_tb <= selop_next;
            shamt_tb <= shamt_next;
        end
    end

    always @(posedge clk_tb)
        $display("%0t ns -> POSedge clk_tb | A=%h B=%h selop=%b shamt=%b enaf=%b | busC=%h C=%b N=%b P=%b Z=%b",
                 $time, busA_tb, busB_tb, selop_tb, shamt_tb, enaf_tb, busC_tb, C_tb, N_tb, P_tb, Z_tb);

    task queue_case;
        input [7:0] a_in;
        input [7:0] b_in;
        input [2:0] sel_in;
        input [1:0] shamt_in;
        input       enaf_in;
        begin
            busA_next  = a_in;
            busB_next  = b_in;
            selop_next = sel_in;
            shamt_next = shamt_in;
            enaf_next  = enaf_in;

            @(posedge clk_tb);
            #1;
        end
    endtask

    initial begin
        rst_tb     = 1'b1;

        enaf_next  = 1'b0;
        busA_next  = 8'h00;
        busB_next  = 8'h00;
        selop_next = 3'b000;
        shamt_next = 2'b00;

        // Reset
        #120;
        rst_tb = 1'b0;

        // CASE 1: B, no shift
        queue_case(8'h3C, 8'hA5, 3'b000, 2'b00, 1'b1);

        // CASE 2: B, logical right shift
        queue_case(8'h3C, 8'hA5, 3'b000, 2'b01, 1'b1);

        // CASE 3: B, logical left shift
        queue_case(8'h3C, 8'hA5, 3'b000, 2'b10, 1'b1);

        // CASE 4: A AND B, no shift
        queue_case(8'hCC, 8'hAA, 3'b010, 2'b00, 1'b1);

        // CASE 5: A AND B, logical right shift
        queue_case(8'hCC, 8'hAA, 3'b010, 2'b01, 1'b1);

        // CASE 6: A XOR B, no shift
        queue_case(8'hF0, 8'h0F, 3'b100, 2'b00, 1'b1);

        // CASE 7: A XOR B, logical left shift
        queue_case(8'hF0, 8'h0F, 3'b100, 2'b10, 1'b1);

        // CASE 8: A + B, no shift
        queue_case(8'd50, 8'd60, 3'b101, 2'b00, 1'b1);

        // CASE 9: A + B, logical right shift
        queue_case(8'd50, 8'd60, 3'b101, 2'b01, 1'b1);

        // CASE 10: B + 1, no shift
        queue_case(8'd0, 8'd7, 3'b110, 2'b00, 1'b1);

        // CASE 11: B + 1, logical left shift
        queue_case(8'd0, 8'd7, 3'b110, 2'b10, 1'b1);

        // CASE 12: -B, no shift
        queue_case(8'd0, 8'd25, 3'b111, 2'b00, 1'b1);

        // CASE 13: -B, logical right shift
        queue_case(8'd0, 8'd25, 3'b111, 2'b01, 1'b1);

        // CASE 14: Arithmetic zero case
        queue_case(8'd0, 8'd0, 3'b111, 2'b00, 1'b1);

        // CASE 15: Negative arithmetic case
        queue_case(8'd0, 8'd200, 3'b111, 2'b00, 1'b1);

        // CASE 16: Carry case
        queue_case(8'hFF, 8'h01, 3'b101, 2'b00, 1'b1);

        // CASE 17: shamt = 11 -> output forced to zero
        queue_case(8'hAA, 8'h55, 3'b000, 2'b11, 1'b1);

        // CASE 18: Disabled flags -> busC changes, flags hold
        queue_case(8'hAA, 8'h55, 3'b100, 2'b10, 1'b0);

        @(posedge clk_tb);
        #1;

        $stop;
    end

endmodule