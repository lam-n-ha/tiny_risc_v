# tiny_risc_v
Tiny Risc-V architecture implemented in Verilog using Quartus Prime and ModelSim-Altera
NOTE: This project is not completed. LUI, AUIPC, LW, SW, JAL, JALR, BEQ, BNE, BLT, BGE, BLTU and BGEU has not been implemented. The FSM has been tested to works with OP and OP-IMM instructions.
This architecture hardware implementation implements 32 of the 34 instructions in the document "Tiny RISC-V Instruction Set Architecture", which can be found: https://www.csl.cornell.edu/courses/ece5745/handouts/ece5745-tinyrv-isa.txt
This project is implemented on Quartus and simulated with ModelSim-Altera, as COVID-19 restrictions means that I don't have access to an FPGA

The list of instructions is: 
ADD, ADDI, SUB, MUL
AND, ANDI, OR, ORI, XOR, XORI
SLT, SLTI, SLTU, SLTIU
SRA, SRAI, SRL, SRLI, SLL, SLLI
LUI, AUIPC
LW, SW
JAL, JALR
BEQ, BNE, BLT, BGE, BLTU, BGEU

This project includes an instruction decoder, a memory initialization file storing a list of instructions, a register file, an ALU and an Finite State Machine to perform the steps of processing instructions. The project also have a testbench.
