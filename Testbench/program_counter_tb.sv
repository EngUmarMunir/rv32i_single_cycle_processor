`timescale 1ns/1ps

module program_counter_tb;
    logic clk;
    logic rest;
    logic [31:0] pc_in;
    logic [31:0] pc_out;

    program_counter dut (
        .clk(clk),
        .rest(rest),
        .pc_in(pc_in),
        .pc_out(pc_out)
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
        pc_in = 32'h00000000;
        #10 pc_in = 32'h00000004;
        #10 pc_in = 32'h00000008;
        #10 pc_in = 32'h0000000C;
        #10 $finish;
    end
endmodule
