`timescale 1ns / 1ps
module M(
    input clk,
    input reset,
	 input [31:0] Instr,
	 input [31:0] PC,
    input [31:0] ALURS_M_I,
    input [31:0] WD_M_I,
	 input Forward_M_I,
    input [31:0] TFW_M_I,
	 input [4:0] Dst_M_I,
    output [31:0] RD_M_O,
	 output RFWr_M_O,
	 output DMWr_M_O,
	 output [4:0] Dst_M_O
    );
	 
	 wire [31:0] WDs; 
	 wire [1:0] WDSel;
	 wire [1:0] Mem_type;
	 assign WDs = (Forward_M_I)? TFW_M_I : WD_M_I;
	 
	 assign Dst_M_O = Dst_M_I;
	 
	 Controller Controller_M (
    .Instr(Instr),
    .WDSel(WDSel), 
    .RFWr(RFWr_M_O), 
    .DMWr(DMWr_M_O), 
    .Mem_type(Mem_type)
    );

	 DM DM_M (
    .clk(clk), 
    .reset(reset), 
    .pc(PC),
	 .M_type(Mem_type),
    .scr(DMWr_M_O), 
    .addr(ALURS_M_I&16383), 
    .din(WDs), 
    .dout(RD_M_O)
    );


endmodule
