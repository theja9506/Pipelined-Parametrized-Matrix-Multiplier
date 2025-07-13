# Pipelined Parametrized Matrix Multiplier

This project implements a pipelined 3x3 matrix multiplier in Verilog. The design is optimized for simulation and synthesis through a modular and step-by-step structure. The final version is flattened for synthesis tools like Vivado that don't support array ports.

## Overview

The matrix multiplier is built from the ground up:
1. A basic, unpipelined design
2. A pipelined, parameterized version using arrays
3. A fully flattened version for synthesis with waveform verification

Each version is placed in its own folder with both design and testbench files.

## Structure

### Final Design after parametrization
- Fully pipelined and parameterized version (`N=3`, `BitWidth=8`)
- Uses array-style ports like `a[0:2]`, `b[0:2]`
- Simulation-friendly but not directly synthesizable on Vivado

### Final Design after flattening
- Flattened version with scalar ports like `A00`, `A01`, ..., `C22`
- Compatible with synthesis tools (Vivado, etc.)
- Includes:
  - `Final-design.v` (flattened design)
  - `final_testbench.v`
  - `wave.vcd` (for waveform analysis)

### Other folders
- `basic_design/`: Initial non-pipelined version
- `dot_product_pipelined/`: Individual pipelined dot product module and testbench
- `matrix_multiplication/`: Parameterized matrix-level pipelined design

## How to Simulate

To simulate the **flattened version**:

```bash
iverilog -o sim.out "Final Design after flattening/Final-design.v" "Final Design after flattening/final_testbench.v"
vvp sim.out

You can view the output waveform using GTKWave: gtkwave wave.vcd

Synthesis Notes
Array ports (a[0:2], b[0:2], etc.) used in the parameterized version work fine for simulation but are not supported by synthesis tools like Vivado. That’s why a flattened version is included.

If you want to scale this to larger matrix sizes, you’ll need to regenerate the flattened version accordingly.

