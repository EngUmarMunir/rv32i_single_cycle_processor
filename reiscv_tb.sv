`timescale 1ns/1ps

module reiscv_tb;

    logic clk;
    logic rest;

    int cycle_count = 0;
    int error_count = 0;

    logic [31:0] prev_pc;

    riscv_top dut (
        .clk(clk),
        .rest(rest)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rest = 1;
        prev_pc = 0;
        #20;
        rest = 0;

        $display("\n[%0t] reset released\n", $time);
    end

    // Monitor the CPU while reset is deasserted.
    always @(posedge clk) begin
        if (!rest) begin
            cycle_count++;

            if (!$isunknown(dut.pc_out) && !$isunknown(dut.instruction)) begin
                $display("Cycle=%0d | PC=0x%08h | Instr=0x%08h",
                         cycle_count, dut.pc_out, dut.instruction);
            end

            if ($isunknown(dut.pc_out)) begin
                $display("ERROR: PC is unknown at cycle %0d", cycle_count);
                error_count++;
            end

            if ($isunknown(dut.instruction)) begin
                $display("ERROR: instruction is unknown at cycle %0d", cycle_count);
                error_count++;
            end

            if (dut.pc_out[1:0] != 2'b00) begin
                $display("ERROR: PC is misaligned at cycle %0d | PC=%h",
                         cycle_count, dut.pc_out);
                error_count++;
            end

            if (cycle_count > 5 && dut.pc_out == prev_pc) begin
                $display("WARNING: PC is not changing (possible loop)");
            end

            prev_pc <= dut.pc_out;
        end
    end

    initial begin
        #3000;

        $display("\n==============================");
        $display("TOTAL CYCLES = %0d", cycle_count);
        $display("TOTAL ERRORS = %0d", error_count);

        if (error_count == 0)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        $display("==============================\n");

        $finish;
    end

endmodule
