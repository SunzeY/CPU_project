`timescale 1ns / 1ps
`define seqn 2'b00
`define beqn 2'b01
`define jn   2'b10
`define jrn  2'b11

module NPC(pc, IMM, RA, NPCOp, pc4, Npc);
input [31:0] pc;
input [31:0] RA;
input [25:0] IMM;
input [1:0] NPCOp;
output [31:0] Npc;
output [31:0] pc4;

assign pc4 = pc + 4;

assign Npc = (NPCOp==`seqn) ? pc + 4:
				 (NPCOp==`beqn) ? pc + 4 + {{14{IMM[15]}}, IMM[15:0], 2'b0}:
				 (NPCOp==`jn)   ? {pc[31:28], IMM[25:0], 2'b0}:
				 (NPCOp==`jrn)  ? RA[31:0] : 32'h0000_3000;

    
endmodule
