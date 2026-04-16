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
            // Las entradas cambian justo despues del flanco de subida.
            // Asi se emula el comportamiento de registros aguas arriba,
            // y el flag_register captura el nuevo dato en el siguiente
            // flanco de subida.
            @(posedge clk_tb);
            #1;
            dataa_tb = data_in;
            carry_tb = carry_in;
            enaf_tb  = enaf_in;

            // Espera al siguiente flanco de subida para que el DUT capture.
            @(posedge clk_tb);
            #1;
        end
    endtask

    initial begin
        clk_tb   = 1'b0;
        rst_tb   = 1'b1;
        enaf_tb  = 1'b0;
        dataa_tb = 8'h00;
        carry_tb = 1'b0;

        // CASE 0: reset asincrono.
        #20;
        @(posedge clk_tb);
        #1;
        rst_tb = 1'b0;

        // CASE 1: registro deshabilitado; las banderas deben permanecer en cero.
        apply_case(8'hAA, 1'b1, 1'b0);

        // CASE 2: resultado cero.
        apply_case(8'h00, 1'b0, 1'b1);

        // CASE 3: resultado negativo (bit mas significativo en 1).
        apply_case(8'h80, 1'b0, 1'b1);

        // CASE 4: carry activo.
        apply_case(8'h01, 1'b1, 1'b1);

        // CASE 5: paridad par (0000_0011 tiene dos unos).
        apply_case(8'h03, 1'b0, 1'b1);

        // CASE 6: paridad impar (0000_0111 tiene tres unos).
        apply_case(8'h07, 1'b0, 1'b1);

        // CASE 7: deshabilitado nuevamente; las banderas deben conservar el caso previo.
        apply_case(8'hFF, 1'b1, 1'b0);

        $stop;
    end

endmodule