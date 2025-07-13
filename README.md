# Pipelined Parametrized Matrix Multiplier

This project implements a pipelined and parameterized 3x3 matrix multiplier in Verilog, optimized for FPGA synthesis. The design demonstrates pipelining at both the dot product and matrix levels for efficient throughput and modularity.

## Features
- Fully pipelined MAC (Multiply-Accumulate) chain using `mulnaccum`
- Modular dot product using `dot_product_pipelined`
- Parameterized matrix multiplier (`N` and `BitWidth`)
- Scalable for larger matrix sizes
- Clean testbenches for each module

## Files Included
- `Final-design.v` – Contains all modules in a single file
- `dot_product_pipelined_design.v` / `dot_product_pipelined_testbench.v`
- `matrix_multiplication.v` / `matrix_multiplication_tb.v`
- `basic_design.v` / `basic_testbench.v`
- `final_tesbench.v` – Final testbench for top-level integration

## Simulation
Use a simulator like **Icarus Verilog** or Vivado to run the testbench:
```bash
iverilog -o sim.out matrix_multiplication.v matrix_multiplication_tb.v
vvp sim.out

## Synthesis Notes
Array ports like `a[0:2]` and `b[0:2]` work fine for simulation,  
but **for synthesis (Vivado etc.), you'll need to flatten them** into separate wires.  
A flattened version is already included in this repo.
