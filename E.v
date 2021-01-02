`timescale 1ns / 1ps
`include "head.v"
module E(
    input [31:0] Instr,
	 input Zero_E_I,
	 input [31:0] PC_E_I,
    input [31:0] RD1_E_I,
    input [31:0] RD2_E_I,
    input [31:0] Ext_E_I,
    input [1:0] ForwardRsE_E_I,
    input [1:0] ForwardRtE_E_I,
	 input [31:0] TMF_E_I,
    input [31:0] TWF_E_I,
    output [31:0] ALURS_E_O,
    output [31:0] WD_E_O,
	 output RFWr_E_O,
    output [4:0] DstE_E_O,
	 output [31:0] Instr_E_O
    );
	 
	 wire [2:0] ALUOp;
	 wire ALUSrc;
	 wire [31:0] SrcA;
	 wire [31:0] SrcB;
	 wire [1:0] WRSel;
	 wire [31:0] result;
	 
	 assign Instr_E_O = Instr;
	 
	 assign SrcA = (ForwardRsE_E_I==2'b01)? TMF_E_I :
						(ForwardRsE_E_I==2'b10)? TWF_E_I : RD1_E_I;
	 
	 assign WD_E_O = (ForwardRtE_E_I==2'b01)? TMF_E_I :
						  (ForwardRtE_E_I==2'b10)? TWF_E_I : RD2_E_I;
						 
	 assign SrcB = (ALUSrc) ? 	Ext_E_I : WD_E_O;
	 
	 assign DstE_E_O = (WRSel==2'b00)?  Instr[20:16]:
					       (WRSel==2'b01)?  Instr[15:11]:
					       (WRSel==2'b10)?  5'h1f : 5'b0;
							 
	 assign ALURS_E_O = (AdOp) ? PC_E_I + 8 : result;
							 
	 ALU ALU_E (
    .ALUControl(ALUOp), 
	 .Instr(Instr),
    .SrcA(SrcA), 
    .SrcB(SrcB), 
    .result(result)
    );

	 Controller Controller_E (
    .Zero(Zero_E_I), 
    .Instr(Instr), 
	 .RFWr(RFWr_E_O),
    .WRSel(WRSel),  
    .ALUOp(ALUOp), 
    .ALUSrc(ALUSrc),
	 .AdOp(AdOp)
    );
endmodule
