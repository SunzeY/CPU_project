`timescale 1ns / 1ps
`include "head.v"
module F(
    input clk_F,
    input reset_F,
    input PCE_F,
    input [25:0] IMM_F,
    input [31:0] RA_F,
    input [2:0] NpcOp_F,
    output [31:0] Instr_F,
    output [31:0] PC_F
    );

	 //wire declare
	 wire [31:0] Npc_F; 
	 wire [31:0] pc_F;
	 
	 assign PC_F = pc_F;

	 PC PC0_F (
    .clk(clk_F), 
    .reset(reset_F), 
    .PCEn(PCE_F), 
    .Npc(Npc_F), 
    .pc(pc_F)
    );
	 
	 NPC NPC_F (
    .pc(pc_F), 
    .IMM(IMM_F), 
    .RA(RA_F), 
    .NPCOp(NpcOp_F), 
    .Npc(Npc_F)
    );
	
	 IM IM_F (
    .Iaddr(pc_F), 
    .Instr(Instr_F)
    );
endmodule
