`timescale 1ns/1ps

module alu_ctrl_tb;

    logic [1:0] ALUop;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [3:0] operation;

    alu_ctrl dut (
        .ALUop(ALUop),
        .funct3(funct3),
        .funct7(funct7),
        .operation(operation)
    );

    task automatic check;
        input logic [3:0] expected;
        input string name;
        begin
            #1;
            if (operation !== expected)
                $display("FAIL: %s | got=%b expected=%b", name, operation, expected);
            else
                $display("PASS: %s | operation=%b", name, operation);
        end
    endtask

    initial begin
        $display("ALU CONTROL TEST");

        ALUop=2'b10; funct3=3'b000; funct7=7'b0000000; #10;
        check(4'b0010, "ADD");

        ALUop=2'b10; funct3=3'b000; funct7=7'b0100000; #10;
        check(4'b0110, "SUB");

        ALUop=2'b10; funct3=3'b100; funct7=7'b0000000; #10;
        check(4'b1110, "XOR");

        ALUop=2'b10; funct3=3'b110; funct7=7'b0000000; #10;
        check(4'b1010, "OR");

        ALUop=2'b10; funct3=3'b111; funct7=7'b0000000; #10;
        check(4'b1001, "AND");

        ALUop=2'b11; funct3=3'b000; funct7=7'b0000000; #10;
        check(4'b0010, "ADDI");

        ALUop=2'b11; funct3=3'b001; funct7=7'b0000000; #10;
        check(4'b0011, "SLLI");

        ALUop=2'b11; funct3=3'b101; funct7=7'b0000000; #10;
        check(4'b0111, "SRLI");

        ALUop=2'b11; funct3=3'b101; funct7=7'b0100000; #10;
        check(4'b1000, "SRAI");

        ALUop=2'b01; funct3=3'b000; funct7=7'b0000000; #10;
        check(4'b0110, "BRANCH (SUB)");

        ALUop=2'b00; funct3=3'b000; funct7=7'b0000000; #10;
        check(4'b0010, "LOAD/STORE (ADD)");

        $display("TEST COMPLETE");
        $finish;
    end

endmodule
