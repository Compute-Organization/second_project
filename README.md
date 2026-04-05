# ⚙️ Technologies

![HDL](https://img.shields.io/badge/HDL-Verilog-blue)
![Quartus](https://img.shields.io/badge/Quartus-II%2013.1-007ACC)
![ModelSim](https://img.shields.io/badge/ModelSim-Altera%2010.1d-purple)
![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey)
![Course](https://img.shields.io/badge/Course-Computer%20Organization-success)

Implementation and verification of the **Arithmetic Logic Unit (ALU)** for the **PDUA processor**, developed as part of the **Computer Organization** course project.

This repository focuses on the HDL design, simulation, and verification of the ALU architecture, including its internal modules, automated ModelSim test flows, and waveform themes for analysis.

---

## 📘 Project Overview

This project corresponds to the implementation in **Verilog** of the **PDUA processor ALU**, following the architecture discussed in class.

The ALU is composed of the following main blocks:

- **Shift Unit**
- **Flag Register**
- **Processing Unit**
- **Top-level ALU integration**
- **Instruction-level control verification** for `selop` and `shamt`

The goal is not only to implement the hardware, but also to verify its functional behavior through structured **testbenches**, synchronized control sequences, and reusable simulation scripts.

---

## 🧩 Implemented Modules

- 🔹 **`full_adder`**  
  1-bit full adder used as the base arithmetic building block.

- 🔹 **`nbit_adder`**  
  Parameterized ripple-carry adder.

- 🔹 **`add_sub`**  
  Parameterized adder/subtractor used for arithmetic operations.

- 🔹 **`shift_unit`**  
  Shift block that applies the displacement selected by `shamt`.

- 🔹 **`flag_register`**  
  Sequential register block for ALU flags.

- 🔹 **`processing_unit`**  
  Combinational block that generates the arithmetic and logic results selected by `selop`.

- 🔹 **`alu`**  
  Top-level ALU integrating processing, shifting, and flag generation.

---

## 🗂️ Repository Structure

```text
pd ua_alu_project/
├── design/        # Synthesizable Verilog HDL source files
├── test/          # Testbenches for each required module
├── run/           # ModelSim automation scripts
├── themes/        # Waveform visualization themes (.do)
├── results/       # Optional notes, screenshots, or reports
└── README.md
```
