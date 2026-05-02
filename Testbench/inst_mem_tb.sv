`timescale 1ns/1ps

module inst_mem_tb;
    logic [31:0] read_addr;
    logic [31:0] inst_out;

    inst_mem dut (
        .read_addr(read_addr),
        .inst_out(inst_out)
    );

    initial begin
        read_addr = 32'h00000000;
        #10 read_addr = 32'h00000004;
        #10 read_addr = 32'h00000008;
        #10 read_addr = 32'h0000000C;
        #10 read_addr = 32'h00000010;
        #10 read_addr = 32'h00000014;
        #10 read_addr = 32'h00000018;
        #10 read_addr = 32'h0000001C;
        #10 read_addr = 32'h00000020;
        #10 read_addr = 32'h00000024;
        #10 $finish;
    end
endmodule
