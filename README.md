# Binary Multiplier

## Overview

This project implements a **16-bit binary multiplier** using Verilog. The design is based on **shift-and-add multiplication** and includes various submodules for arithmetic and control operations.

## Features

- Implements 16-bit multiplication using shift-and-add method
- Uses **ALU** for addition and subtraction operations
- Incorporates **shift registers** for partial product shifting
- Includes a **D Flip-Flop** for storing intermediate values
- Controlled by a **finite state machine (FSM)**
- Counter for managing iterations

## Module Descriptions

### 1. `multiplierbinary`

This is the top-level module integrating all submodules:

- **Registers:** Shift registers for operands
- **ALU:** Performs addition and subtraction
- **D Flip-Flop:** Holds temporary values
- **Counter:** Controls multiplication iterations
- **Controller:** FSM that manages execution states

### 2. `shiftreg`

Implements a **16-bit shift register** with:

- Load (`ld`)
- Clear (`clr`)
- Shift (`sft`)

### 3. `PIPO`

Implements a **Parallel-In Parallel-Out (PIPO) register** to store the multiplier.

### 4. `dff`

A **D Flip-Flop** used to store and update intermediate values.

### 5. `ALU`

Implements arithmetic operations:

- Addition (`addsub = 1`)
- Subtraction (`addsub = 0`)

### 6. `counter`

A **5-bit counter** that decrements until multiplication completes.

### 7. `controller`

Implements the **FSM** to control the multiplication process, handling:

- Initialization
- Partial product computation
- Shifting operations
- Completion detection

## How to Use

### Simulation

1. Compile the Verilog files using a simulator (such as ModelSim or Vivado).
2. Provide the input values (`data_in` for multiplicand and multiplier).
3. Observe outputs (`qm1`, `eqz`) to verify correct multiplication.

### FPGA Implementation

1. Load the Verilog code into an FPGA toolchain (Xilinx Vivado, Quartus, etc.).
2. Synthesize and implement the design.
3. Deploy to hardware and test using testbench inputs.

## Dependencies

- Verilog HDL
- Simulation tools (ModelSim, Vivado, Quartus, etc.)
- FPGA board (for hardware implementation)

## Future Enhancements

- Support for larger bit-width multiplication (e.g., 32-bit, 64-bit)
- Optimization for power and area efficiency
- Integration with a processor for embedded applications

##

