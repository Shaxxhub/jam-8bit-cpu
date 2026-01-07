#  Design and Implementation of a Simple 8-bit Multi-Cycle CPU Using Verilog

## 📌 Overview

This project presents the **design and implementation of a simple 8-bit multi-cycle CPU** using **Verilog HDL**.
The CPU is built with a strong emphasis on **clear separation between datapath and control logic**, making the design **modular, extensible, and easy to debug**.

The processor supports **arithmetic, logical, memory, and control flow instructions** and is fully verified using a **system-level simulation testbench**.

---

## 🏗️ CPU Architecture Overview

The CPU follows a **Harvard architecture**, where instruction memory and data memory are separate.

### Key Characteristics

* **Data width:** 8 bits
* **Address width:** 8 bits
* **Register file:** 8 registers × 8 bits
* **Execution model:** Multi-cycle

  * Fetch
  * Decode
  * Execute
  * Writeback

Each instruction completes execution in **four clock cycles**.

---

## 📘 Instruction Set Architecture (ISA)

### Instruction Format (8 bits)

```
[7:5] Opcode
[4:2] rd   (destination register)
[1:0] rs   (source register)
```

---

### Supported Instructions

| Opcode | Instruction | Description           |
| ------ | ----------- | --------------------- |
| 000    | ADD         | R[rd] = R[rd] + R[rs] |
| 001    | SUB         | R[rd] = R[rd] − R[rs] |
| 010    | AND         | Bitwise AND           |
| 011    | OR          | Bitwise OR            |
| 100    | XOR         | Bitwise XOR           |
| 101    | LOAD        | R[rd] = MEM[R[rs]]    |
| 110    | STORE       | MEM[R[rs]] = R[rd]    |
| 111    | JMP         | PC = R[rs]            |

---

### Arithmetic / Logical Instructions

| Opcode | Mnemonic | Operation             |
| ------ | -------- | --------------------- |
| 000    | ADD      | R[rd] ← R[rd] + R[rs] |
| 001    | SUB      | R[rd] ← R[rd] − R[rs] |
| 010    | AND      | R[rd] ← R[rd] & R[rs] |
| 011    | OR       | R[rd] ← R[rd] | R[rs] |
| 100    | XOR      | R[rd] ← R[rd] ^ R[rs] |

* Executed using the **ALU**
* Result written back during **WRITEBACK**

---

### Memory Instructions

| Opcode | Mnemonic | Operation          |
| ------ | -------- | ------------------ |
| 101    | LOAD     | R[rd] ← MEM[R[rs]] |
| 110    | STORE    | MEM[R[rs]] ← R[rd] |

* Memory address comes from a register
* No immediate addressing (simplifies hardware)

---

### Control Instruction

| Opcode | Mnemonic | Operation  |
| ------ | -------- | ---------- |
| 111    | JMP      | PC ← R[rs] |

---

## 🔗 Datapath Components

### Program Counter (PC)

* Holds the address of the current instruction
* Updated during **FETCH** or **JMP**
* Controlled by `pc_en` and `pc_load`

---

### Instruction Memory (ROM)

* Size: **256 × 8 bits**
* Read-only
* Addressed by PC
* Initialized using `program.hex`

---

### Instruction Register (IR)

* Stores fetched instruction
* Loaded only during **FETCH** (`ir_load`)
* Ensures instruction stability across cycles

---

### Register File

* 8 general-purpose registers
* 2 read ports, 1 write port
* **Combinational read**
* **Synchronous write**

---

### Arithmetic Logic Unit (ALU)

* Fully combinational
* Supports arithmetic and logical operations
* Generates **zero** and **carry** flags
* No internal storage

---

### Data Memory (RAM)

* Size: **256 × 8 bits**
* Synchronous write
* Combinational read
* Used for **LOAD** and **STORE**

---

## 🕹️ Control Unit (FSM)

The CPU uses a **4-state Finite State Machine (FSM)** for control.

| State     | Function                              |
| --------- | ------------------------------------- |
| FETCH     | Fetch instruction and update PC       |
| DECODE    | Decode instruction and read registers |
| EXECUTE   | ALU operation / memory access / jump  |
| WRITEBACK | Write result back to register file    |

### FSM Design Principles

* State transitions depend only on **clock and reset**
* Control outputs depend on **current state and opcode**
* All control signals are **combinational**
* Only the **state register** is clocked

---

## 🧩 CPU Top Module

The top-level module integrates:

* PC
* Instruction Memory
* Instruction Register
* Control Unit
* Register File
* ALU
* Data Memory

The top module contains **no behavioral logic**—only **structural interconnections** forming the complete datapath.

---

## 🧪 Verification Strategy

A full **system-level testbench** was developed to verify the CPU.

### Verification Includes:

* Clock and reset generation
* Instruction loading via `program.hex`
* Observation of:

  * Program Counter
  * Instruction flow
  * FSM control signals
  * ALU outputs
  * Memory behavior

### Result:

Waveform analysis confirms **correct multi-cycle execution** of all instructions.

---

## ✅ Conclusion

The designed 8-bit CPU successfully demonstrates:

* Correct **multi-cycle instruction execution**
* Clean **FSM-controlled datapath**
* Modular and synthesizable RTL design

This project provides a **strong foundation** for understanding:

* Processor architecture
* FSM-based control
* RTL design methodology
* Timing-aware verification

---

## 🚀 Future Enhancements

* Immediate-mode instructions
* Pipelined execution
* Interrupt handling
* Status/flag registers
* Cache memory support

---

## 👤 Author

**Jami Shashank**
Electronics and Communication Engineering
VLSI / Digital Design Enthusiast

---



Just tell me 👍
