`timescale 1ns/1ps

module main_ctrl_tb;

    logic [6:0] opcode;
    logic RegWrite;
    logic [1:0] ImmSrc;
    logic ALUSrc;
    logic MemWrite;
    logic [1:0] ResultSrc;
    logic Branch;
    logic Jump;
    logic [1:0] ALU_op;

    integer test_num = 0;
    integer passed   = 0;

    main_ctrl dut (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .Jump(Jump),
        .ALU_op(ALU_op)
    );

    task automatic verify(
        input string name,
        input logic exp_regwrite,
        input logic [1:0] exp_immsrc,
        input logic exp_alusrc,
        input logic exp_memwrite,
        input logic [1:0] exp_resultsrc,
        input logic exp_branch,
        input logic exp_jump,
        input logic [1:0] exp_alu_op
    );
        #1;
        test_num++;

        if (RegWrite  === exp_regwrite &&
            ImmSrc    === exp_immsrc   &&
            ALUSrc    === exp_alusrc   &&
            MemWrite  === exp_memwrite &&
            ResultSrc === exp_resultsrc &&
            Branch    === exp_branch   &&
            Jump      === exp_jump     &&
            ALU_op    === exp_alu_op) begin

            $display("PASS: %s", name);
            passed++;
        end else begin
            $display("FAIL: %s", name);
            $display("   Got -> RW:%b Imm:%b ALUSrc:%b MW:%b RS:%b Br:%b J:%b ALUop:%b",
                      RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, Jump, ALU_op);
            $display("   Exp -> RW:%b Imm:%b ALUSrc:%b MW:%b RS:%b Br:%b J:%b ALUop:%b\n",
                      exp_regwrite, exp_immsrc, exp_alusrc, exp_memwrite,
                      exp_resultsrc, exp_branch, exp_jump, exp_alu_op);
        end
    endtask

    initial begin
        $display("=================================");
        $display("MAIN CONTROL TEST");
        $display("=================================\n");

        opcode = 7'b0000011;
        verify("LOAD (LW)", 1, 2'b00, 1, 0, 2'b01, 0, 0, 2'b00);

        opcode = 7'b0100011;
        verify("STORE (SW)", 0, 2'b01, 1, 1, 2'b00, 0, 0, 2'b00);

        opcode = 7'b0110011;
        verify("R-TYPE", 1, 2'b00, 0, 0, 2'b00, 0, 0, 2'b10);

        opcode = 7'b1100011;
        verify("BRANCH", 0, 2'b10, 0, 0, 2'b00, 1, 0, 2'b01);

        opcode = 7'b0010011;
        verify("I-TYPE", 1, 2'b00, 1, 0, 2'b00, 0, 0, 2'b11);

        opcode = 7'b1101111;
        verify("JAL", 1, 2'b11, 0, 0, 2'b10, 0, 1, 2'b00);

        opcode = 7'b0110111;
        verify("LUI", 1, 2'b11, 1, 0, 2'b00, 0, 0, 2'b00);

        opcode = 7'b0010111;
        verify("AUIPC", 1, 2'b11, 1, 0, 2'b00, 0, 0, 2'b00);

        opcode = 7'b1111111;
        verify("DEFAULT", 0, 2'b00, 0, 0, 2'b00, 0, 0, 2'b00);

        $display("=================================");
        $display("RESULT: %0d / %0d PASSED", passed, test_num);
        $display("=================================");

        if (passed == test_num)
            $display("ALL TESTS PASSED");
        else
            $display("%0d TESTS FAILED", test_num - passed);

        $finish;
    end

endmodule
