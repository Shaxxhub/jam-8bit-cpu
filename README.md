# 8bit-cpu

PROJECT DOCUMENTATION
Design and Implementation of a Simple 8-bit Multi-Cycle CPU Using Verilog

1.1 Introduction
This project involves the design and implementation of a simple 8-bit CPU using Verilog HDL. The CPU follows a multi-cycle architecture, where each instruction is executed across multiple clock cycles. The design emphasizes clear separation between datapath and control logic, making it modular, extensible, and easy to debug.
The processor supports arithmetic, logical, memory, and control flow instructions, and is verified using a complete simulation testbench.

1.2 CPU Architecture Overview
The CPU follows a Harvard architecture, with separate instruction and data memories.
Key characteristics:
•	Data width: 8 bits
•	Address width: 8 bits
•	Register file: 8 registers × 8 bits
•	Execution model: Multi-cycle (Fetch, Decode, Execute, Writeback)

1.3 Instruction Set Architecture (ISA)
Instruction Format (8 bits)
[7:5] Opcode
[4:2] rd   (destination register)
[1:0] rs   (source register)

Opcode	Instruction	Description
000	ADD	R[rd] = R[rd] + R[rs]
001	SUB	R[rd] = R[rd] − R[rs]
010	AND	Bitwise AND
011	OR	Bitwise OR
100	XOR	Bitwise XOR
101	LOAD	R[rd] = MEM[R[rs]]
110	STORE	MEM[R[rs]] = R[rd]
111	JMP	PC = R[rs]



Arithmetic / Logic Instructions
Opcode	Mnemonic	Operation
000	ADD	R[rd] ← R[rd] + R[rs]
001	SUB	R[rd] ← R[rd] - R[rs]
010	AND	R[rd] ← R[rd] & R[rs]
011	OR	R[rd] ← R[rd] | R[rs]
100	XOR	R[rd] ← R[rd] ^ R[rs]
•	Uses ALU and Writes result back to register file

Memory Instructions
Opcode	Mnemonic	Operation
101	LOAD	R[rd] ← MEM[R[rs]]
110	STORE	MEM[R[rs]] ← R[rd]
•	Address comes from register and no immediate addressing (simpler hardware)
	
Control Instruction
Opcode	Mnemonic	Operation
111	JMP	PC ← R[rd]



1.4 Datapath Components
Program Counter (PC)
•	Holds the address of the current instruction
•	Updated during FETCH or JMP
•	Controlled using pc_en and pc_load
Output waveform
 

Instruction Memory (ROM)
•	Size: 256 × 8
•	Read-only
•	Addressed by PC
Output waveform using sample hex file as input
 

Instruction Register (IR)
•	Stores fetched instruction
•	Loaded only during FETCH (ir_load)
Output Waveform 
 

Register File
•	8 general-purpose registers
•	2 read ports, 1 write port
•	Synchronous write, combinational read
Output Waveform
 

Arithmetic Logic Unit (ALU)
•	Pure combinational unit
•	Supports arithmetic and logical operations
•	Generates zero and carry flags
Output waveform
•	Binary
 

•	Decimal value
 

Data Memory (RAM)
•	Size: 256 × 8
•	Synchronous write
•	Combinational read
•	Used for LOAD and STORE
Output Waveform
 

1.5 Control Unit (FSM)
The CPU uses a 4-state finite state machine:
State	Function
FETCH	Fetch instruction, increment PC
DECODE	Decode instruction, read registers
EXECUTE	ALU operation / memory access / jump
WRITEBACK	Write result back to register file

FSM Design Principles
•	State transitions depend only on clock and reset
•	Control outputs depend on current state and opcode
•	All control signals are combinational

1.6 CPU Top Module
The top module integrates all sub-modules and forms the complete datapath. It contains no behavioral logic, only structural connections between components.



Output waveform
 

1.7 Verification Strategy
A full system testbench was developed to:
•	Generate clock and reset
•	Load instructions via program.hex
•	Observe PC, instruction flow, control signals, ALU outputs, and memory behavior
Waveform analysis confirms correct multi-cycle execution.

1.8 Conclusion
The designed CPU successfully demonstrates:
•	Proper multi-cycle execution
•	Clean FSM-controlled datapath
•	Modular and synthesizable RTL design
The project provides a strong foundation for understanding processor design and digital system integration.

