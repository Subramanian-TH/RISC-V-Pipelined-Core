# 5-Stage Pipelined RISC-V Processor (RV32I)

<p align="center">
  <img src="https://img.shields.io/badge/RISC--V-RV32I-0078df?style=for-the-badge&logo=riscv&logoColor=white" alt="RISC-V RV32I" />
  <img src="https://img.shields.io/badge/HDL-VERILOG-f37b21?style=for-the-badge" alt="HDL VERILOG" />
  <img src="https://img.shields.io/badge/TOOL-XILINX VIVADO-e04c38?style=for-the-badge" alt="XILINX VIVADO" />
  <img src="https://img.shields.io/badge/CPU-5--STAGE%20PIPELINE-97ca00?style=for-the-badge" alt="CPU 5-STAGE PIPELINE" />
</p>

## 📚 Contents

1. [Project Overview](#1-project-overview)
2. [Architecture Diagram](#2-architecture-diagram)

   * [5-Stage Pipelined Datapath](#5-stage-pipelined-datapath)
   * [Advanced Hazard Management](#advanced-hazard-management)
3. [RV32I Instruction Set Supported](#3-rv32i-instruction-set-supported)
4. [Verification & Test Program](#4-verification--test-program)

   * [Assembly to Machine Code Mapping](#assembly-to-machine-code-mapping)
   * [Memory Initialization (.mem file)](#memory-initialization-mem-file)
5. [Simulation Results](#5-simulation-results)
6. [Elaborated RTL Schematic](#6-elaborated-rtl-schematic)
7. [References](#7-references)
8. [License](#8-license)
9. [About the Developer](#9-about-the-developer)

---

## 1. Project Overview

This project is a complete RTL design and verification of a 32-bit RISC-V microprocessor, built to demonstrate practical digital design and pipeline architecture principles. 

**Core Highlights:**
* **Architecture:** 5-stage pipelined soft core implementing the standard RV32I instruction set.
* **Hazard Resolution:** Features a comprehensive hazard detection unit to manage pipeline execution.
* **Data Forwarding:** Implements internal data bypassing to resolve data dependencies dynamically.
* **Stall & Flush Logic:** Accurately handles load-use stalls and branch/jump flushes to maintain a correct execution path.
* **Implementation:** Written in Verilog HDL and optimized for Xilinx Vivado workflows.
  
  ---

## 2. Architecture Diagram

The core implements a classic 5-stage pipeline (Fetch, Decode, Execute, Memory, Writeback) optimized for the RV32I instruction set. To maximize instruction throughput and handle dependencies, the datapath is tightly integrated with a dedicated, centralized Hazard Unit.

### 5-Stage Pipelined Datapath:
  * **Instruction Fetch (IF):** Retrieves instructions from Instruction Memory and increments the Program Counter (PC).
  * **Instruction Decode (ID):** Includes the Register File and a centralized Control Unit that decodes instructions and propagates control signals down the pipeline.
  * **Execute (EX):** Contains the ALU for arithmetic/logic operations and a dedicated adder for computing branch/jump target addresses.
  * **Memory (MEM):** Handles read and write operations to the Data Memory.
  * **Writeback (WB):** Selects the final result (from the ALU, Memory, or PC+4) and writes it back to the Register File.

### Advanced Hazard Management:
  * **Data Forwarding (Bypass Network):** To resolve Read-After-Write (RAW) data hazards without stalling, the Execute stage features 3-to-1 multiplexers at the ALU inputs. The Hazard Unit asserts `ForwardAE` and `ForwardBE` to route results directly from the MEM stage (`ALUResultM`) or WB stage (`ResultW`) back to the ALU.
  * **Load-Use Stalling:** When a data dependency cannot be resolved via forwarding (e.g., an instruction needs data immediately after a Load), the Hazard Unit asserts `StallF` and `StallD`. This freezes the PC and IF/ID registers, injecting a pipeline bubble to allow the memory read to complete.
  * **Control Hazard Resolution (Flushing):** Branch conditions and target addresses are resolved in the Execute stage (`PCSrcE`). If a branch is taken, the Hazard Unit asserts `FlushD` and `FlushE` to clear the instructions erroneously loaded into the IF/ID and ID/EX pipeline registers, ensuring the correct execution path is maintained.

<div align="center">
  <table>
    <thead>
      <tr>
        <th align="center">RISC-V 5-Stage Pipelined Architecture</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td align="center">
          <img src="https://github.com/user-attachments/assets/b6b5c97a-acb5-49ad-99c6-e9c859a992b7" width="837" height="543" alt="RISCV pipelined with hazard handling" />
        </td>
      </tr>
    </tbody>
  </table>
</div>

  ---

## 3. RV32I Instruction Set Supported 
  - **Arithmetic:** `ADD`, `SUB`, `ADDI`  
  - **Logical:** `AND`, `OR`, `XOR`, `ANDI`, `ORI`, `XORI`  
  - **Load/Store:** `LW`, `SW`  
  - **Branch:** `BEQ`, `BNE` 
  - **Jump:** `JAL`, `JALR` 

---

## 4. Verification & Test Program

To verify the core's pipeline and hazard management logic, the following RISC-V assembly program is loaded into the Instruction Memory. This specific sequence is designed to rigorously test the processor's handling of read-after-write (RAW) data hazards, control flow changes (branching and jumping), and memory access operations.

### Assembly to Machine Code Mapping

| Memory Address | Machine Code (Hex) | RISC-V Assembly | Description |
| :--- | :--- | :--- | :--- |
| `0x00` | `0083A023` | `sw x8, 0(x7)` | Store word from `x8` to memory at `x7` |
| `0x04` | `00A30293` | `addi x5, x6, 10` | Add immediate: `x5 = x6 + 10` |
| `0x08` | `0084A303` | `lw x6, 8(x9)` | Load word into `x6` from `x9 + 8` |
| `0x0C` | `00948463` | `beq x9, x9, 8` | Branch if equal: Jump forward 8 bytes |
| `0x10` | `00628533` | `add x10, x5, x6` | Add: `x10 = x5 + x6` |
| `0x14` | `06300713` | `addi x14, x0, 99` | Load immediate 99 into `x14` |
| `0x18` | `004000EF` | `jal x1, 4` | Jump and link: Jump forward 4 bytes |
| `0x1C` | `00D665B3` | `or x11, x12, x13` | Bitwise OR: `x11 = x12 | x13` |

### Memory Initialization (`.mem` file)
In the simulation environment, this machine code is initialized into the instruction memory array using the Verilog `$readmemh()` system task. 

```text
@00000000
0083A023
00A30293
0084A303
00948463
00628533
06300713
004000EF
00D665B3
```
---

## 5. Simulation Results

This processor core was verified running the instruction sequence above in the Xilinx Vivado Simulator. The waveforms below demonstrate the seamless flow through the 5-stage pipeline, the dynamic resolution of Read-After-Write (RAW) data hazards via forwarding, and the flushing logic triggered by control hazards.

<img width="1746" height="616" alt="Screenshot 2026-03-20 231424" src="https://github.com/user-attachments/assets/ed0c63a0-64f2-4286-87f3-daa5cda58fe9" />
<img width="1751" height="580" alt="Screenshot 2026-03-20 231456" src="https://github.com/user-attachments/assets/c9abef14-7b7b-405a-9830-ad27d0acf737" />
<img width="1745" height="490" alt="Screenshot 2026-03-20 231523" src="https://github.com/user-attachments/assets/eff4fc91-4111-409a-9dac-a265797e6b33" />

---

## 6. Elaborated RTL Schematic

The following schematic was generated via Xilinx Vivado, detailing the top-level entity of the processor. It highlights the inter-stage pipeline registers, the feedback paths for data forwarding and writeback, and the integration of the centralized Hazard Unit.

<div align="center">
  <table>
    <thead>
      <tr>
        <th align="center">RTL Schematic</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td align="center">
          <img width="1841" height="728" alt="Screenshot 2026-03-20 232219" src="https://github.com/user-attachments/assets/ce4ea1ce-b49b-4293-ab51-134c65eb814d" />
        </td>
      </tr>
    </tbody>
  </table>
</div>

## 7. References

1. Sarah L. Harris and David Money Harris, *Digital Design and Computer Architecture: RISC-V Edition*, Morgan Kaufmann, 2021.
2. Sarah Harris, *RISC-V Microarchitecture* (YouTube Playlist). Available: [YouTube - Sarah Harris](https://www.youtube.com/watch?v=lrN-uBKooRY&list=PLhA3DoZr6boVQy9Pz-aPZLH-rA6DvUidB&index=1)
3. RISC-V: From Transistors to AI, *RISC-V Pipeline Core in Verilog* (YouTube Playlist). Available: [YouTube - RISC-V: From Transistors to AI](https://www.youtube.com/playlist?list=PL5AmAh9QoSK4fNTAQf2g-1s6FvQ8edoWd)

---

## 8. License

This project is open-source and available under the [MIT License](https://opensource.org/licenses/MIT).

---

## 9. About the Developer

**Subramanian T H**  
Final Year ECE Student - Sri Venkateswaraa College of Technology | VLSI Enthusiast

- LinkedIn: linkedin.com/in/subramanian-t-h/  
- Email: subramanith.ece@gmail.com


