`timescale 1ns/1ps

module reg_file_tb;
    logic clk;
    logic rest;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [31:0] data_w;
    logic RegWrite;
    logic [31:0] read_data1;
    logic [31:0] read_data2;

    reg_file dut (
        .clk(clk),
        .rest(rest),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .data_w(data_w),
        .RegWrite(RegWrite),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rest = 1;
        #20 rest = 0;
    end

    initial begin
        rs1 = 5'b00000;
        rs2 = 5'b00000;
        rd = 5'b00001;
        data_w = 32'h00000005;
        RegWrite = 1;
        #10;
        RegWrite = 0;
        #10;

        rs1 = 5'b00000;
        rs2 = 5'b00000;
        rd = 5'b00010;
        data_w = 32'h00000006;
        RegWrite = 1;
        #10;
        RegWrite = 0;
        #10;

        rs1 = 5'b00001;
        rs2 = 5'b00010;

        #10;
        rs1 = 5'b00000;
        rs2 = 5'b00000;
        rd = 5'b00011;
        data_w = 32'h0000000B;
        RegWrite = 1;
        #10;
        RegWrite = 0;
        #10;

        rs1 = 5'b00000;
        rs2 = 5'b00000;
        rd = 5'b00100;
        data_w = 32'h00000011;
        RegWrite = 1;
        #10;
        RegWrite = 0;
        #10;
        rs1 = 5'b00011;
        rs2 = 5'b00100;
        #10;
        $finish;
    end
endmodule
