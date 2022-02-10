# MIPS-CPU-Simiulator
32 bit MIPS CPU Simulator

This project, simulates 32bit MIPS processor with verilog.

# Prerequisites

This project can be simply run in modelsim (If you use modelsim you can ignore the following).
To run this project in linux, before running, you need to install ``` iverilog ``` and ``` gtkwave ```.

# Simulation

To compile, run and get the wave, simply run the ``` run.sh ``` file with ``` sudo ```.
```
sudo bash ./run.sh

```

# Instructions

This processor supports the instructions below.

```
R-Type: add, sub, or, and, slt
J-Type: j
I-Type: sw, lw, addi, slti, andi, ori, beq, bneq
```
