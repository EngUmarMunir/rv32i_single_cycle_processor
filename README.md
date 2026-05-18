# RV32I Single-Cycle Processor

A RISC-V single-cycle RV32I processor implemented in SystemVerilog. The design follows a modular datapath structure, including separate units for control, ALU, memory, and register file. Each instruction executes in a single clock cycle.

## Project Structure

- `riscv_top.sv` – Top-level CPU integration (datapath + control)
- `program_counter.sv` – Program counter logic
- `inst_mem.sv` – Instruction memory
- `reg_file.sv` – 32-register RV32I register file
- `main_ctrl.sv` – Main control unit (opcode decoding)
- `alu_ctrl.sv` – ALU control logic
- `alu.sv` – Arithmetic Logic Unit
- `imm_gen.sv – Immediate generator
- `branch.sv` – Branch decision unit
- `data_mem.sv` – Data memory
- `load_store_unit.sv` – Load/store data handling
- `mux.sv` – Multiplexer utility module
- `fib_im.mem` – Instruction memory initialization file

## Features

- RV32I base integer instruction support
- Single-cycle execution (no pipeline hazards)
- Modular and readable RTL design
- Supports arithmetic, logic, branch, load, store, and jump instructions
- Simulation-ready with self-checking testbenches

## Simulation

Tested using Vivado XSim or compatible SystemVerilog simulators.
## Steps
1. Create a new Vivado project
2. Add all `.sv` files as design sources
3. Add the desired testbench (*_tb.sv) as simulation top
4. Ensure `.mem` files remain in the project directory
5. Run simulation

Use `riscv_tb` for top-level verification.

## Notes

- Each instruction completes in one cycle (non-pipelined design)
- Testbenches access internal signals for verification purposes only
- Any extension (new instructions or features) requires updates in control, ALU decode, and test programs

# rv32i_single_cycle_processor
