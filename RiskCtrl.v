`timescale 1ns / 1ps
`include "head.v"
module RiskCtrl(
	 input clk,
	 input reset,
	 input RFWrE_R_I,
	 input RFWrM_R_I,
	 input RFWrW_R_I,
	 input DMWrM_R_I,
	 input Clrslot_R_I,
	 input [31:0] Instr,
    input [5:0] Tuse_R_I,
    input [2:0] TE_R_I,
    input [2:0] TM_R_I,
    input [2:0] TW_R_I,
    input [4:0] DstE_R_I,
    input [4:0] DstM_R_I,
    input [4:0] DstW_R_I,
    input [4:0] RsD_R_I,
    input [4:0] RtD_R_I,
    input [4:0] RsE_R_I,
    input [4:0] RtE_R_I,
	 
    output PCEnD_R_O,
    output EnD_R_O,
    output ForwardRsD_R_O,
    output ForwardRtD_R_O,
    output FlushE_R_O,
	 output FlushD_R_O,
    output [1:0] ForwardRtE_R_O,
    output [1:0] ForwardRsE_R_O,
	 output ForwardM_R_O
    );
	 wire [2:0]Tuse_Rs_I = Tuse_R_I[5:3];
	 wire [2:0]Tuse_Rt_I = Tuse_R_I[2:0];
	 
	 wire stalla;
	 wire stallb;
	 wire stall;
	 
	 assign stalla = (DstE_R_I!=0)&(RsD_R_I==DstE_R_I)&RFWrE_R_I&(Tuse_Rs_I<TE_R_I)||
						  (DstM_R_I!=0)&(RsD_R_I==DstM_R_I)&RFWrM_R_I&(Tuse_Rs_I<TM_R_I)||
						  (DstW_R_I!=0)&(RsD_R_I==DstW_R_I)&RFWrW_R_I&(Tuse_Rs_I<TW_R_I);
						  
    assign stallb = (DstE_R_I!=0)&(RtD_R_I==DstE_R_I)&RFWrE_R_I&(Tuse_Rt_I<TE_R_I)||
						  (DstM_R_I!=0)&(RtD_R_I==DstM_R_I)&RFWrM_R_I&(Tuse_Rt_I<TM_R_I)||
						  (DstW_R_I!=0)&(RtD_R_I==DstW_R_I)&RFWrW_R_I&(Tuse_Rt_I<TW_R_I);
						  
	 assign stall = stalla||stallb||((`lwld||`lrm)&&(Tuse_Rs_I<4||Tuse_Rt_I<4));
	 assign PCEnD_R_O = ~stall;
	 assign EnD_R_O = ~stall;
	 assign FlushE_R_O = stall;
	 assign FlushD_R_O = ~stall && Clrslot_R_I;

	 
	 assign ForwardRsD_R_O =  (DstM_R_I!=0)&&(DstM_R_I==RsD_R_I)&&RFWrM_R_I&&(TM_R_I==0)? 1:0;
																								
	 assign ForwardRtD_R_O =  (DstM_R_I!=0)&&(DstM_R_I==RtD_R_I)&&RFWrM_R_I&&(TM_R_I==0)? 1:0;
																								
	 assign ForwardRsE_R_O =  (DstM_R_I!=0)&&(DstM_R_I==RsE_R_I)&&RFWrM_R_I&&(TM_R_I==0)? 01:
						           (DstW_R_I!=0)&&(DstW_R_I==RsE_R_I)&&RFWrW_R_I&&(TW_R_I==0)?               10:
																												                   00;
																								
    assign ForwardRtE_R_O =  (DstM_R_I!=0)&&(DstM_R_I==RtE_R_I)&&RFWrM_R_I&&(TM_R_I==0)? 01:
						           (DstW_R_I!=0)&&(DstW_R_I==RtE_R_I)&&RFWrW_R_I&&(TW_R_I==0)?               10:
																												                   00;
																													  
	 assign ForwardM_R_O =  (DstW_R_I!=0)&&(DMWrM_R_I)&&(DstW_R_I==DstM_R_I)&&(RFWrW_R_I)&&(TW_R_I==0)? 1:0;																												  
	
	 

endmodule
