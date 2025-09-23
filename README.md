# RISC-V Pipeline Core

## Overview
This project implements a **32-bit RISC-V pipelined processor** in Verilog.
The design executes instructions using a five-stage pipeline (Fetch, Decode, Execute, Memory, Writeback) and includes hazard detection for data hazards.

---

## Features

- **32-bit pipelined RISC-V processor**  

- **Five-stage pipeline**:  
  - **Fetch (IF)** – fetch instruction from memory  
  - **Decode (ID)** – decode instruction and read registers  
  - **Execute (EX)** – perform ALU operations  
  - **Memory (MEM)** – access data memory  
  - **Writeback (WB)** – write results to the register file  

- **RV32I Instruction Set Support (Subset)**:  
  - **Arithmetic:** `ADD`, `SUB`, `ADDI`  
  - **Logical:** `AND`, `OR`, `XOR`, `ANDI`, `ORI`, `XORI`  
  - **Load/Store:** `LW`, `SW`  
  - **Branch:** `BEQ`, `BNE` 
  - **Jump:** `JAL`, `JALR` 

- **Hazard Unit**:  
  - Detects **data hazards (RAW)**  
  - Implements **forwarding** to resolve hazards  

---

## Top Architecture
<img width="1364" height="850" alt="Screenshot 2025-09-23 184258" src="https://github.com/user-attachments/assets/7d74762a-8543-4b56-8d73-602dbc36eeb2" />



---

## Simulation Results

<img width="1782" height="1755" alt="RISCV_Pipelined" src="https://github.com/user-attachments/assets/4ab7fcb7-a01d-4a51-8dd2-43e6d4b221ca" />

---

## References

1. Sarah L. Harris and David Money Harris, *Digital Design and Computer Architecture: RISC-V Edition*, Morgan Kaufmann, 2021.  

2. Sarah Harris, *RISC-V David Harris and Sarah Harris Microarchitecture* [YouTube Playlist].  
   Available: [YouTube – Sarah Harris](https://www.youtube.com/watch?v=lrN-uBKooRY&list=PLhA3DoZr6boVQy9Pz-aPZLH-rA6DvUidB&index=1)

3.  RISC-V: From Transistors to AI, *RISC-V Pipeline Core in Verilog* [YouTube Playlist].
    Available: [YouTube – RISC-V: From Transistors to AI](https://www.youtube.com/playlist?list=PL5AmAh9QoSK4fNTAQf2g-1s6FvQ8edoWd)

---

## License
This project is **open-source** and available under the [MIT License](LICENSE).

---

## Author

**Subramanian T H**  
Final Year ECE Student - Sri Venkateswaraa College of Technology | VLSI Enthusiast
- LinkedIn: linkedin.com/in/subramanian-t-h/  
- Email: subramanith.ece@gmail.com



   
  
