`timescale 1ns / 1ps
`include "head.v"
`define Timer1 (32'h0000_7f00<=ALURS_M_I && ALURS_M_I<=32'h0000_7f0b)
`define Timer2 (32'h0000_7f10<=ALURS_M_I && ALURS_M_I<=32'h0000_7f1b)
`define DMad   ((ALURS_M_I[31]==0)&& ALURS_M_I<=32'h0000_2ffc)
module M(
    input clk,
    input reset,
	 input [31:0] PrRD_M_I,
	 output [31:2] PrAddr_M_O,
	 output [31:0] PrWD_M_O,
	 input [31:0] MacroPC,
	 input [31:0] Instr,
	 input [5:0] HWInt,
	 input [8:2] ExCode_M_I,
	 input [31:0] PC,
    input [31:0] ALURS_M_I,
    input [31:0] WD_M_I,
	 input Forward_M_I,
    input [31:0] TFW_M_I,
	 input MacroBD,
	 input EXLSet,
	 input EXLClr,
    output [31:0] RD_M_O,
	 output RFWr_M_O,
	 output DMWr_M_O,
	 output IntReq_M_O,
	 output [31:0] EPC_M_O,
	 output mtEPC_M_O,
	 output eret_M_O,
	 output [8:2] ExCode_M_O
    );
	 
	 wire AdEL;
	 wire AdEs;
	 wire [8:2] ExCode_M;
	 wire [31:0] WDs; 
	 wire [31:0] RD_M; 
	 wire [1:0] WDSel;
	 wire [31:0] DOut;
	 wire [1:0] Mem_type;
	 
	 assign eret_M_O = `eret;
	 
	 assign PrAddr_M_O = ALURS_M_I[31:2];
	 assign PrWD_M_O = WDs;
	 
	 assign mtEPC_M_O = `mtc0 && Instr[15:11]==5'd14;
	 
	 assign DMWr_M_O = ~IntReq_M_O && DMWr;
	 
	 assign WDs = (Forward_M_I)? TFW_M_I : WD_M_I;
	 
	 assign RD_M_O =  (`lw && (`Timer1 || `Timer2)) ? PrRD_M_I :
														 (`mfc0) ?     DOut : RD_M;
														 
	 assign AdEL = (`lw && (|ALURS_M_I[1:0]))||(((`lh)||(`lhu)) && ALURS_M_I[0])
					 ||(((`lh)||(`lhu)||(`lb)||(`lbu)) && (`Timer1||`Timer2))
					 ||((`lw||`lh||`lhu||`lb||`lbu) && ~((`DMad)||(`Timer1)||(`Timer2)));

	 assign AdEs = (`sw && (|ALURS_M_I[1:0]))||(`sh && ALURS_M_I[0])
					 ||((`sh||`sb) && (`Timer1||`Timer2))
					 ||((`sw) && (ALURS_M_I==32'h0000_7f08|| ALURS_M_I==32'h0000_7f18))
					 ||((`sh||`sb||`sw) && ~(`DMad||`Timer1||`Timer2));
	 
	 assign We = ~IntReq_M_O && `mtc0;
	 assign ExCode_M[8] =  ExCode_M_I[8];
    assign ExCode_M[7] = AdEL|AdEs;
	 assign ExCode_M[6:2] = (AdEL) ? 4 : 5;
	 assign ExCode_M_O = ExCode_M_I[7] ? ExCode_M_I : ExCode_M;
					
	 
	 CP0 CP0(
    .A1(Instr[15:11]), 
    .A2(Instr[15:11]), 
    .DIn(WDs), 
    .PC(MacroPC[31:2]), 
    .ExCode({MacroBD, ExCode_M_O[7:2]}), 
    .HWInt(HWInt), 
    .We(We), 
    .EXLSet(EXLSet), 
    .EXLClr(EXLClr), 
    .clk(clk), 
    .reset(reset), 
    .IntReq_O(IntReq_M_O), 
    .EPC(EPC_M_O), 
    .DOut(DOut)
    );
	 
	 Controller Controller_M (
    .Instr(Instr),
    .WDSel(WDSel), 
    .RFWr(RFWr_M_O), 
    .DMWr(DMWr), 
    .Mem_type(Mem_type)
    );

	 DM DM_M (
    .clk(clk), 
    .reset(reset), 
    .pc(PC),
	 .M_type(Mem_type),
    .scr(DMWr_M_O&(`DMad)), 
    .addr(ALURS_M_I), 
    .din(WDs), 
    .dout(RD_M)
    );


endmodule
