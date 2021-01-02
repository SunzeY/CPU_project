`timescale 1ns / 1ps
`include "head.v"
`define seqn 2'b00
`define beqn 2'b01
`define jn   2'b10
`define jrn  2'b11

module NPC(Instr, EPC, pc, IMM, PCtoIn, PCBack, RA, NPCOp, Npc);
input [31:0] Instr;
input [31:0] EPC;
input [31:0] pc;
input [31:0] RA;
input [25:0] IMM;
input PCtoIn;
input PCBack;
input [1:0] NPCOp;
output [31:0] Npc;

wire [31:0] NPC;

assign NPC = (NPCOp==`seqn) ? pc + 4:
				 (NPCOp==`beqn) ? pc + {{14{IMM[15]}}, IMM[15:0], 2'b0}:
				 (NPCOp==`jn)   ? {pc[31:28], IMM[25:0], 2'b0}:
				 (NPCOp==`jrn)  ? RA[31:0] : 32'h0000_3000;
				 
assign Npc = (PCtoIn) ? 32'h0000_4180 :
				 (PCBack) ? EPC : NPC;
    
endmodule
