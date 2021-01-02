`timescale 1ns / 1ps
`include "head.v"
module W(
    input [31:0] Instr,
	 input Zero_W_I,
    input [31:0] PC_W_I,
	 input [31:0] RD_W_I,
	 input [31:0] WD_W_I,
	 input [31:0] ALURS_W_I,
    output [31:0] WD_W_O,
	 output RFWr_W_O
    );
	 
	 wire [1:0] WDSel;
	 wire [32:0] tem;
	 wire [31:0] RD_f;
	 
	 assign WD_W_O = (WDSel==2'b00)? ALURS_W_I:
	                 (WDSel==2'b01)? RD_f     :
						  (WDSel==2'b10)? PC_W_I + 8 : 32'h0000_3000;
					  
	 assign tem = {WD_W_I[31], WD_W_I}+ {RD_W_I[31], RD_W_I};  
	 assign overflow = tem[32]!=tem[31];
	 assign RD_f = (LDOp==1) ? tem [31:0]: 
						(`lrm)	 ?	WD_W_I : RD_W_I;

	 Controller Controller_W (
    .Zero(Zero_W_I), 
    .Instr(Instr), 
	 .overflow(overflow),
    .WDSel(WDSel), 
    .RFWr(RFWr_W_O),
	 .LDOp(LDOp)
    );
	 
endmodule
