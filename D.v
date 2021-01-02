`timescale 1ns / 1ps
`include "head.v"
module D(
	 input clk,
	 input reset,
    input [31:0] Instr,
    input [31:0] PC_D_I,
	 input [4:0]  WR_D_I,
	 input [31:0] WD_D_I,
	 input RFWr_D_I,
	 input ForwardRs_D_I,
	 input ForwardRt_D_I,
	 input [31:0] EMF_D_I,
    output [2:0] NPCOp_D_O,
	 output Clrslot,
	 output Zero_D_O,
    output [5:0] Tuse_D_O,
    output [2:0] Tnew_D_O,
    output [31:0] RD1_D_O,
    output [31:0] RD2_D_O,
    output [31:0] Ext_D_O
    );
	 
	 wire [31:0] RD1r_D;
	 wire [31:0] RD2r_D;
	 wire [1:0] BOp;
	 wire [1:0] ExtOp;
	 wire [2:0] TUsers;
	 wire [2:0] TUsert;
	 
	 assign Tuse_D_O = {TUsers[2:0], TUsert[2:0]};
	 
	 assign RD1_D_O = (ForwardRs_D_I) ? EMF_D_I : RD1r_D;
	 assign RD2_D_O = (ForwardRt_D_I) ? EMF_D_I : RD2r_D;
	 
	 assign Zero_D_O = (BOp==2'b00)? (RD1_D_O==RD2_D_O)  :
							 (BOp==2'b01)? $signed(RD1_D_O)>=0 :
							 (BOp==2'b10)? $signed(RD1_D_O)<0  : 0;
	 Controller Controller_D (
    .Zero(Zero_D_O), 
    .Instr(Instr), 
    .NPCOp(NPCOp_D_O),  
	 .BOp(BOp),
    .ExtOp(ExtOp),
	 .Clrslot(Clrslot)
    );
	 
	 GRF GRF_D (
    .clk(clk), 
    .reset(reset), 
    .PC(PC_D_I), 
	 .Instr(Instr),
    .RegWrite(RFWr_D_I), 
    .A1(Instr[25:21]), 
    .A2(Instr[20:16]), 
    .Waddr(WR_D_I), 
    .WData(WD_D_I), 
    .RD1(RD1r_D), 
    .RD2(RD2r_D)
    );
	 
	 Extender Extender_D (
    .ExtControl(ExtOp), 
	 .Instr(Instr),
    .Src(Instr[15:0]), 
    .result(Ext_D_O)
    );
	 
	 ACoder ACoder_D (
    .Instr(Instr), 
    .TUsers(TUsers), 
    .TUsert(TUsert), 
    .TNew(Tnew_D_O)
    );
endmodule
