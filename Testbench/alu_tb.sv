`timescale 1ns/1ps

module alu_tb;
    logic [31:0] operand1;
    logic [31:0] operand2;
    logic [3:0] operation;
    logic [31:0] result;
    logic zero;

    alu dut (
        .a(operand1),
        .b(operand2),
        .control_in(operation),
        .result(result),
        .zero(zero)
    );

    initial begin
        operand1 = 32'h00000005;
        operand2 = 32'h00000003;
        operation = 4'b0010; // ADD
        #10;

        operand1 = 32'h00000005;
        operand2 = 32'h00000003;
        operation = 4'b0010;
        #10;

        operand1 = 32'h00000005;
        operand2 = 32'h00000003;
        operation = 4'b0110;
        #10;

        operand1 = 32'h00000001;
        operand2 = 32'h00000002;
        operation = 4'b0011;
        #10;

        operand1 = 32'h00000001;
        operand2 = 32'h00000002;
        operation = 4'b0011;
        #10;

        operand1 = 32'h00000005;
        operand2 = 32'h00000003;
        operation = 4'b0100;
        #10;

        operand1 = 32'h00000005;
        operand2 = 32'h00000003;
        operation = 4'b0101;
        #10;

        operand1 = 32'h00000005;
        operand2 = 32'h00000003;
        operation = 4'b1110;
        #10;

        operand1 = 32'h00000004;
        operand2 = 32'h00000001;
        operation = 4'b0111;
        #10;

        operand1 = 32'hFFFFFFFC; // -4 in 2's complement
        operand2 = 32'h00000001;
        operation = 4'b1000;
        #10;

        operand1 = 32'h00000005;
        operand2 = 32'h00000003;
        operation = 4'b1001;
        #10;

        operand1 = 32'h00000005;
        operand2 = 32'h00000003;
        operation = 4'b1010;
        #10;
        $finish;
    end
endmodule
