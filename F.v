`timescale 1ns / 1ps
`define eret Instr_F[31:26]==6'b010000 && Instr_F[5:0]==6'b011000
module F(
    input clk_F,
    input reset_F,
	 input [31:0] EPC_F_I,
	 input mtEPC_D_I,
	 input mtEPC_E_I,
	 input mtEPC_M_I,
	 input PCtoIn,
	 input PCBack,
    input PCE_F,
    input [25:0] IMM_F,
    input [31:0] RA_F,
    input [1:0] NpcOp_F,
	 input isBranch,
    output [31:0] Instr_F,
    output [31:0] PC_F,
	 output [8:2] ExCode_F_O
    );

	 //wire declare
	 wire [31:0] Instr;
	 wire [31:0] Npc_F; 
	 wire [31:0] pc_F;
	 assign PC_F = pc_F;
	 
	 assign ExCode_F_O [8] = isBranch;
	 assign ExCode_F_O [7] = (|pc_F[1:0]) || $signed(pc_F)<32'h0000_3000 || $signed(pc_F)>32'h0000_4ffc;
	 assign ExCode_F_O [6:2] = 4;
	 
	 assign Instr_F = ExCode_F_O [7] ? 0 : Instr;
	 
	 PC PC0_F (
    .clk(clk_F), 
    .reset(reset_F), 
    .PCEn(PCE_F), 
	 .PCtoIn(PCtoIn),
	 .PCBack(PCBack),
    .Npc(Npc_F), 
    .pc(pc_F)
    );
	 
	 NPC NPC_F (
	 .Instr(Instr_F),
	 .EPC(EPC_F_I),
    .pc(pc_F), 
    .IMM(IMM_F), 
    .RA(RA_F),
	 .PCtoIn(PCtoIn),
	 .PCBack(PCBack),
    .NPCOp(NpcOp_F), 
    .Npc(Npc_F)
    );
	
	 IM IM_F (
    .Iaddr(pc_F), 
    .Instr(Instr)
    );
endmodule
