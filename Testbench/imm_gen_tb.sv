`timescale 1ns/1ps

module imm_gen_tb;

    logic [31:0] instruction;
    logic [31:0] ImmExt;
    logic [31:0] expected;

    integer test_num = 0;
    integer passed   = 0;

    imm_gen dut (
        .instruction(instruction),
        .ImmExt(ImmExt)
    );
    task automatic verify(input string test_name, input logic [31:0] expected_val);
        #1;
        test_num++;

        if (ImmExt === expected_val) begin
            $display("PASS: %s", test_name);
            passed++;
        end else begin
            $display("FAIL: %s", test_name);
            $display("  Expected: 0x%08h", expected_val);
            $display("  Got:      0x%08h", ImmExt);
            $display("  Diff:     0x%08h", expected_val ^ ImmExt);
            $display("  Instr:    %032b\n", instruction);
        end
    endtask

    initial begin
        $display("==========================================");
        $display("IMMEDIATE GENERATOR TEST");
        $display("==========================================\n");

        instruction = 32'b000000001010_00010_000_00001_0010011;
        verify("I-Type (ADDI +10)", 32'd10);

        instruction = 32'b111111111011_00100_000_00011_0010011;
        verify("I-Type (ADDI -5)", 32'hFFFF_FFFB);

        instruction = 32'b0000000_00001_00010_010_01000_0100011;
        verify("S-Type (SW +8)", 32'd8);

        instruction = 32'b1111111_00101_00110_010_11100_0100011;
        verify("S-Type (SW -4)", 32'hFFFF_FFFC);

        instruction = 32'b0_000000_00001_00010_000_1000_0_1100011;
        verify("B-Type (BEQ +16)", 32'd16);

        instruction = 32'b1_111111_00011_00100_000_1100_1_1100011;
        verify("B-Type (BEQ -8)", 32'hFFFF_FFF8);

        instruction = 32'b0_1000000000_0_00000000_00001_1101111;
        verify("J-Type (JAL +1024)", 32'd1024);

        instruction = 32'b1_1100000000_1_11111111_00010_1101111;
        verify("J-Type (JAL -512)", 32'hFFFF_FE00);

        instruction = 32'b00010010001101000101_00001_0110111;
        verify("U-Type (LUI 0x12345)", 32'h12345000);

        instruction = 32'b10101011110011011110_00010_0010111;
        verify("U-Type (AUIPC 0xABCDE)", 32'hABCDE000);

        $display("==========================================");
        $display("RESULT: %0d / %0d tests passed", passed, test_num);
        $display("==========================================");

        if (passed == test_num)
            $display("ALL TESTS PASSED");
        else
            $display("%0d TESTS FAILED", test_num - passed);

        $finish;
    end

endmodule
