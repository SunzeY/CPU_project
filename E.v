`timescale 1ns / 1ps
`include "head.v"
module E(
	 input clk,
	 input reset,
    input [31:0] Instr,
	 input InReq_E_I,
	 input [8:2] ExCode_E_I,
	 input [31:0] PC_E_I,
    input [31:0] RD1_E_I,
    input [31:0] RD2_E_I,
    input [31:0] Ext_E_I,
    input [1:0] ForwardRsE_E_I,
    input [1:0] ForwardRtE_E_I,
	 input [31:0] TMF_E_I,
    input [31:0] TWF_E_I,
	 input eret_E_I,
    output [31:0] ALURS_E_O,
    output [31:0] WD_E_O,
	 output RFWr_E_O,
    output [4:0] DstE_E_O,
	 output Stall_E_O,
	 output [8:2] ExCode_E_O,
	 output mtEPC_E_O
    );
	 
	 wire [8:2] ExCode_E;
	 wire [1:0] REOp;
	 wire [1:0] HiLoWr;
	 wire Start;
	 wire [31:0] Hi;
	 wire [31:0] Lo;
	 wire [3:0] ALUOp;
	 wire ALUSrc;
	 wire [31:0] SrcA;
	 wire [31:0] SrcB;
	 wire [1:0] WRSel;
	 wire [31:0]ALURS_Er;
	 wire StallEr;
	 wire [1:0] HiLoWrE;
	
	 assign mtEPC_E_O = `mtc0 && Instr[15:11]==5'd14;
	 
	 assign Start = start_E && ~InReq_E_I && ~eret_E_I;
	 
	 assign ExCode_E [8:7] = {ExCode_E_I[8], Overflow};
	 assign ExCode_E [6:2] = (`lw||`lh||`lb||`lbu||`lhu)? 5'd4 :
							       (`sw||`sb||`sh)            ? 5'd5 : 5'd12;
	 
	 assign ExCode_E_O = (ExCode_E_I[7])? ExCode_E_I : ExCode_E;
	 
	 assign Stall_E_O = StallEr | Start;
	 
	 assign SrcA = (ForwardRsE_E_I==2'b01)? TMF_E_I :
						(ForwardRsE_E_I==2'b10)? TWF_E_I : RD1_E_I;
	 
	 assign WD_E_O = (ForwardRtE_E_I==2'b01)? TMF_E_I :
						  (ForwardRtE_E_I==2'b10)? TWF_E_I : RD2_E_I;
						 
	 assign SrcB = (ALUSrc) ? 	Ext_E_I : WD_E_O;
	 
	 assign DstE_E_O = (WRSel==2'b00)?  Instr[20:16]:
					       (WRSel==2'b01)?  Instr[15:11]:
					       (WRSel==2'b10)?  5'h1f : 5'b0;
							 
	 assign ALURS_E_O = (REOp==2'b01)? Hi :
						     (REOp==2'b10)? Lo : 
							  (REOp==2'b11)? PC_E_I+8 : ALURS_Er;
							  
	 assign HiLoWrE = {HiLoWr[1]&(~InReq_E_I)&(~eret_E_I), HiLoWr[0]&(~InReq_E_I)&(~eret_E_I)};
							 
	 MD MD_E (
    .clk(clk), 
    .reset(reset), 
    .instr(Instr), 
    .SrcA(SrcA), 
    .SrcB(SrcB), 
    .start(Start), 
    .HiLoWr(HiLoWrE), 
    .stall(StallEr), 
    .Hi(Hi), 
    .Lo(Lo)
    );

	 ALU ALU_E (
    .ALUControl(ALUOp), 
	 .Instr(Instr),
    .SrcA(SrcA), 
    .SrcB(SrcB), 
    .result(ALURS_Er),
	 .Overflow(Overflow)
    );

	 Controller Controller_E (
    .Zero(Zero), 
    .Instr(Instr),
	 .RFWr(RFWr_E_O),
    .WRSel(WRSel),  
    .ALUOp(ALUOp), 
    .ALUSrc(ALUSrc),
	 .REOp(REOp),
	 .HiLoWr(HiLoWr), 
	 .Start(start_E)
    );

endmodule
