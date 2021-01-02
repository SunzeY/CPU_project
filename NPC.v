`timescale 1ns / 1ps
`include "head.v"
module NPC(pc, IMM, RA, NPCOp, Npc);
input [31:0] pc;
input [31:0] RA;
input [25:0] IMM;
input [2:0] NPCOp;
output [31:0] Npc;


assign Npc = (NPCOp==3'b000) ? pc + 4:
				 (NPCOp==3'b001) ? pc + {{14{IMM[15]}}, IMM[15:0], 2'b0}:
				 (NPCOp==3'b010) ? {pc[31:28], IMM[25:0], 2'b0}:
				 (NPCOp==3'b011) ? RA[31:0] : 
				 (NPCOp==3'b100) ? pc + 8 : 32'h0000_3000;

    
endmodule
