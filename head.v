`timescale 1ns / 1ps

//CPC
//`define syscall  Instr[31:26]==6'b000000 && Instr[5:0]==6'b001100
`define eret   Instr[31:26]==6'b010000 && Instr[5:0]==6'b011000
`define mfc0   Instr[31:26]==6'b010000	&&	Instr[25:21]==5'b00000 && Instr[10:0]==11'b000000000
`define mtc0   Instr[31:26]==6'b010000	&&	Instr[25:21]==5'b00100 && Instr[10:0]==11'b000000000

//LS 8
`define lw     Instr[31:26]==6'b100011
`define lh     Instr[31:26]==6'b100001
`define lhu    Instr[31:26]==6'b100101
`define lb     Instr[31:26]==6'b100000
`define lbu    Instr[31:26]==6'b100100
`define sw     Instr[31:26]==6'b101011
`define sh     Instr[31:26]==6'b101001
`define sb     Instr[31:26]==6'b101000

//B 6
`define beq    Instr[31:26]==6'b000100
`define bne    Instr[31:26]==6'b000101
`define bgez   Instr[31:26]==6'b000001 && Instr[20:16]==5'b00001
`define bgtz   Instr[31:26]==6'b000111
`define blez   Instr[31:26]==6'b000110
`define bltz   Instr[31:26]==6'b000001 && Instr[20:16]==5'b00000

//RI 8
`define addi   Instr[31:26]==6'b001000
`define addiu  Instr[31:26]==6'b001001
`define andi   Instr[31:26]==6'b001100
`define lui    Instr[31:26]==6'b001111
`define ori    Instr[31:26]==6'b001101
`define slti   Instr[31:26]==6'b001010
`define sltiu  Instr[31:26]==6'b001011
`define xori   Instr[31:26]==6'b001110

//R
`define sll    Instr[31:26]==6'b000000 && Instr[5:0]==6'b000000
`define srl    Instr[31:26]==6'b000000 && Instr[5:0]==6'b000010
`define sra    Instr[31:26]==6'b000000 && Instr[5:0]==6'b000011
`define sllv   Instr[31:26]==6'b000000 && Instr[5:0]==6'b000100
`define srlv   Instr[31:26]==6'b000000 && Instr[5:0]==6'b000110
`define srav   Instr[31:26]==6'b000000 && Instr[5:0]==6'b000111
`define add    Instr[31:26]==6'b000000 && Instr[5:0]==6'b100000
`define addu   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100001
`define sub    Instr[31:26]==6'b000000 && Instr[5:0]==6'b100010
`define subu   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100011
`define andu   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100100
`define oru    Instr[31:26]==6'b000000 && Instr[5:0]==6'b100101
`define xoru   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100110
`define noru   Instr[31:26]==6'b000000 && Instr[5:0]==6'b100111
`define slt    Instr[31:26]==6'b000000 && Instr[5:0]==6'b101010
`define sltu   Instr[31:26]==6'b000000 && Instr[5:0]==6'b101011
`define jr     Instr[31:26]==6'b000000 && Instr[5:0]==6'b001000
`define jalr   Instr[31:26]==6'b000000 && Instr[5:0]==6'b001001

//j
`define j      Instr[31:26]==6'b000010
`define jal    Instr[31:26]==6'b000011

//MD
`define mult   Instr[31:26]==6'b000000 && Instr[5:0]==6'b011000 && Instr[15:6]==10'b0
`define multu  Instr[31:26]==6'b000000 && Instr[5:0]==6'b011001 && Instr[15:6]==10'b0
`define div    Instr[31:26]==6'b000000 && Instr[5:0]==6'b011010 && Instr[15:6]==10'b0
`define divu   Instr[31:26]==6'b000000 && Instr[5:0]==6'b011011 && Instr[15:6]==10'b0

//DC
`define mfhi   Instr[31:26]==6'b000000 && Instr[5:0]==6'b010000 && Instr[25:16]==10'b0
`define mflo   Instr[31:26]==6'b000000 && Instr[5:0]==6'b010010 && Instr[25:16]==10'b0
`define mthi   Instr[31:26]==6'b000000 && Instr[5:0]==6'b010001 && Instr[20:6]==15'b0
`define mtlo   Instr[31:26]==6'b000000 && Instr[5:0]==6'b010011 && Instr[20:6]==15'b0
