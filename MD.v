`timescale 1ns / 1ps
`include "head.v"
module MD(
    input clk,
    input reset,
	 input [31:0] Instr,
    input [31:0] SrcA,
    input [31:0] SrcB,
    input start,
    input [1:0] HiLoWr,
    output reg stall,
    output reg [31:0] Hi,
    output reg [31:0] Lo
    );
	 reg [31:0] SrcAM;
	 reg [31:0] SrcBM;
	 reg [3:0] cnt;
	 reg unsign;
	 reg type;
	 reg [1:0] New_Instr_type;
	 
	 reg [63:0] buff;
	 always @(*)begin
		if(New_Instr_type == 1)begin
			buff = (Hi||Lo) - SrcAM * SrcBM;
		end
		else if(type&&unsign)begin
			buff = SrcAM * SrcBM;
		end
		else if(type&&~unsign)begin
			buff = ($signed(SrcAM))*($signed(SrcBM));
		end
		else if(~type&&unsign)begin
			buff[63:32] = (SrcBM==0) ? 0 : SrcAM % SrcBM;
			buff[31:0]  = (SrcBM==0) ? 0 : SrcAM / SrcBM;
		end
		else if(~type&&~unsign)begin
			buff[63:32] = (SrcBM==0) ? 0 : $signed(SrcAM) % $signed(SrcBM);
			buff[31:0]  = (SrcBM==0) ? 0 : $signed(SrcAM) / $signed(SrcBM);
		end
	 end
	 
	 initial begin
		Hi <= 0;
		Lo <= 0;
		SrcAM <= 0;
		SrcBM <= 0;
		type <= 0;
		unsign <= 0;
		cnt <= 0;
		stall <= 0;
		buff  <= 0;
		New_Instr_type <= 0;
	 end
	 always @(posedge clk)begin
		if(reset)begin
			Hi <= 0;
			Lo <= 0;
			SrcAM <= 0;
			SrcBM <= 0;
			type <= 0;
			unsign <= 0;
			cnt <= 0;
			stall <= 0;
			buff  <= 0;
			New_Instr_type <= 0;
		end
		else if(HiLoWr==2'b01) Hi <= SrcA;
		else if(HiLoWr==2'b10) Lo <= SrcA;
		else if(start)begin
			SrcAM <= SrcA;
			SrcBM <= SrcB;
			stall <= 1;
			if(`msub)begin
				cnt <= 4;
				New_Instr_type <= 1;
			end
			else if(`mult||`multu)begin
				New_Instr_type <= 0;
				cnt <= 4;
				type <= 1;
			end
			else begin
				New_Instr_type <= 0;
				cnt <= 9;
				type <= 0;
			end
			if(`divu||`multu)
				unsign <= 1;
			else
				unsign <= 0;
		end
		else if(stall&&cnt==0)begin
			Hi <= buff[63:32];
			Lo <= buff[31:0];
			stall <= 0;
		end
		else cnt <= (cnt==0)? cnt : cnt - 1;
	end
endmodule
