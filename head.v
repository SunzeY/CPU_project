`timescale 1ns / 1ps
`define sll    Instr[31:26]==6'b000000 && Instr[5:0]==6'b000000
`define andu   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100100
`define jalr   Instr[31:26]==6'b000000 && Instr[5:0]==6'b001001
`define bgezall Instr[31:26]==6'b000001 && Instr[20:16]==5'b10011
`define bltzal Instr[31:26]==6'b000001 && Instr[20:16]==5'b10000
`define j      Instr[31:26]==6'b000010
`define addi   Instr[31:26]==6'b001000
`define lwso   Instr[31:26]==6'b111001
`define xoru   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100110
`define lwld   Instr[31:26]==6'b100001 //using lh's Opcode
`define lrm    Instr[31:26]==6'b100000 //using lb's Opcode

`define addu   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100001
`define subu   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100011
`define lw     Instr[31:26]==6'b100011
`define sw     Instr[31:26]==6'b101011
`define beq    Instr[31:26]==6'b000100
`define lui    Instr[31:26]==6'b001111
`define ori    Instr[31:26]==6'b001101
`define jal    Instr[31:26]==6'b000011
`define jr     Instr[31:26]==6'b000000 && Instr[5:0]==6'b001000