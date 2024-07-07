# Pipelined Carry Select Adder

## Overview

This repository contains the implementation of a pipelined carry select adder, designed and optimized using Synopsys Design Compiler (DC) and Synopsys Prime Time (PT). The project was completed as part of the ECE-527 course at Portland State University in Fall 2023.

## Project Description

### Introduction

The project involves designing a 4-bit and an 8-bit pipelined carry select adder using Verilog. The primary objectives are to implement the adders, synthesize them using DC, perform static timing analysis (STA) using PT, and optimize the design for maximum throughput.

### Tasks

#### Task 1: Setting Up the Environment
- Followed the getting started guide to set up the environment and paths for DC and PT.
- Briefly read through the user manual to understand the basic commands and functional options.

#### Task 2: 4-bit Pipelined Carry Select Adder
1. **Design Implementation:**
   - Designed a 4-bit pipelined carry select adder using 2-bit full adders as basic blocks.
   - Created a testbench to verify the correctness of the design.

2. **Synthesis:**
   - Synthesized the design using Design Compiler to generate a netlist.
   - Analyzed the maximum delay using DC reports and calculated the minimum clock period.

3. **Static Timing Analysis:**
   - Imported the netlist into Prime Time for STA.
   - Used specific constraints for input delay, clock latency, and clock skew.
   - Reduced the clock period until the design failed to meet constraints, recording the minimum clock period and calculating the throughput.

#### Task 3: 8-bit Pipelined Carry Select Adder
- Expanded the 4-bit carry select adder to an 8-bit version.
- Ensured the design was pipelined with at least two stages.
- Synthesized and performed STA to achieve maximum throughput.

## Results

### Throughput Calculation
- **4-bit Pipelined Adder:**
  - Minimum clock period: 2.36 ns
  - Maximum throughput: 423,728,814 sums/second

- **8-bit Pipelined Adder:**
  - Minimum clock period: 2.36 ns
  - Maximum throughput: 423,728,814 sums/second (due to pipelining, despite the increased bit-width)

### Static Timing Analysis (STA) Report
- The STA reports for both the 4-bit and 8-bit adders are included in the `reports` directory.

## Conclusion

This project provided hands-on experience with Verilog design, synthesis using Design Compiler, and static timing analysis using Prime Time. The pipelined carry select adder design demonstrates the trade-offs between complexity, speed, and area in digital design.

## Documentation

- [Project 2 Assignment](./docs/Project_2_Assignment.pdf)
- [Project 2 Report](./docs/Project_2_Report.pdf)

## Contact

For any questions or further information, please contact:
- Alexander Maso: amaso@pdx.edu
