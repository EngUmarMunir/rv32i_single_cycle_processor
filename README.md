# RV32I Single-Cycle Processor

This repository contains a single-cycle RV32I processor written in SystemVerilog, along with self-checking testbenches and program memory images for simulation.

The design is built as a single clocked datapath. Fetch, decode, execute, memory access, and writeback are still the main stages of the CPU, but they are part of one cycle rather than separate pipeline steps. The code is organized into small modules so each part of the processor is easy to understand and verify on its own.

## Project Structure

- `riscv_top.sv` - top-level integration of the CPU datapath and control logic
- `program_counter.sv` - program counter update logic
- `inst_mem.sv` - instruction memory
- `reg_file.sv` - 32-register RV32I register file
- `main_ctrl.sv` - opcode decode and main control signals
- `alu_ctrl.sv` - ALU operation decode
- `alu.sv` - arithmetic and logic unit
- `imm_gen.sv` - immediate generator for RV32I instruction formats
- `branch.sv` - branch decision logic
- `data_mem.sv` - data memory for load and store operations
- `load_store_unit.sv` - load/store data formatting and extension
- `mux.sv` - shared multiplexer helper module
- `fib_im.mem` - instruction memory initialization file

## Features

- RV32I integer instruction support
- Immediate, register, branch, load, store, and jump paths
- Separate control and datapath modules
- Comprehensive simulation testbench for instruction-level verification

## Simulation

The project is intended for a SystemVerilog simulator such as Vivado XSim.

### Vivado flow

1. Create a new Vivado project.
2. Add all `.sv` source files as design sources.
3. Add the desired `*_tb.sv` file as the simulation top.
4. Ensure the `.mem` files stay in the project directory so the memories load correctly.
5. Run the simulation.

For top-level verification, use `riscv_tb` as the simulation top.

## Notes

- The design is a single-cycle implementation, so each instruction completes in one cycle and there is no forwarding or pipeline hazard logic.
- The testbench reads internal state directly for verification, which is useful for simulation but not intended for synthesis.
- If you add new instructions or memory behavior, update the control logic, ALU decode, and the comprehensive test program together.

## Suggested GitHub Workflow

After adding a Git remote, the usual flow is:

1. `git init`
2. `git add .`
3. `git commit -m "Initial commit"`
4. `git remote add origin <your-repo-url>`
5. `git push -u origin main`
# rv32i_single_cycle_processor
