# RISC-V Pipeline Core

## Overview
This project implements a **32-bit RISC-V pipelined processor** in Verilog.
The design executes instructions using a five-stage pipeline (Fetch, Decode, Execute, Memory, Writeback) and includes hazard detection for data hazards.

---

## Features 
- 32-bit pipelined RISC-V processor
- Five-stage pipeline:
  -Fetch (IF) – fetch instruction from memory
  -Decode (ID) – decode instruction and read registers
  -Execute (EX) – perform ALU operations
  -Memory (MEM) – access data memory
  -Writeback (WB) – write results to the register file

-RV32I Instruction Set Support (Subset):
  -Arithmetic: ADD, SUB, ADDI
  -Logical: AND, OR, XOR, ANDI, ORI, XORI
  -Load/Store: LW, SW
  -Branch: BEQ, BNE 
  -Jump: JAL, JALR 

-Hazard Unit:
  -Detects data hazards (RAW)
  -Implements forwarding for hazard handling

---

## Top Architecture
<img width="952" height="618" alt="Pipelined RISC V" src="https://github.com/user-attachments/assets/ba1e9cbf-6e15-4983-8e7f-03ca7d3807dc" />

---

## Simulation Results


  
