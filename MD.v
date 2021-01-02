`timescale 1ns / 1ps
module MD(
    input clk,
    input reset,
	 input [31:0] instr,
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
	 reg div0;
	 reg type;
	 
	 reg [63:0] buff;
	 always @(*)begin
		if(type&&unsign)begin
			buff = SrcAM * SrcBM;
		end
		else if(type&&~unsign)begin
			buff = ($signed(SrcAM))*($signed(SrcBM));
		end
		else if(~type&&unsign)begin
			buff[63:32] = (SrcBM==0) ? buff[63:32] : SrcAM % SrcBM;
			buff[31:0]  = (SrcBM==0) ? buff[31:0] : SrcAM / SrcBM;
		end
		else if(~type&&~unsign)begin
			buff[63:32] = (SrcBM==0) ? buff[63:32] : $signed($signed(SrcAM) % $signed(SrcBM));
			buff[31:0]  = (SrcBM==0) ? buff[31:0] : $signed($signed(SrcAM) / $signed(SrcBM));
		end
	 end
	 
	 initial begin
		Hi <= 0;
		Lo <= 0;
		SrcAM <= 0;
		SrcBM <= 0;
		type <= 0;
		unsign <= 0;
		div0  <= 0;
		cnt <= 0;
		stall <= 0;
		buff  <= 0;
	 end
	 always @(posedge clk)begin
		if(reset)begin
			Hi <= 0;
			Lo <= 0;
			SrcAM <= 0;
			SrcBM <= 0;
			type <= 0;
			unsign <= 0;
			div0  <= 0;
			cnt <= 0;
			stall <= 0;
			buff  <= 0;
		end
		else if(HiLoWr==2'b01) Hi <= SrcA;
		else if(HiLoWr==2'b10) Lo <= SrcA;
		else if(start)begin
			SrcAM <= SrcA;
			SrcBM <= SrcB;
			stall <= 1;
			if(instr[5:0]==6'b011000||instr[5:0]==6'b011001)begin
				cnt <= 4;
				type <= 1;
			end
			else begin
				div0 = (SrcB==0);
				cnt <= 9;
				type <= 0;
			end
			if(instr[5:0]==6'b011001||instr[5:0]==6'b0011011)
				unsign <= 1;
			else
				unsign <= 0;
		end
		else if(stall&&cnt==0&&(~div0))begin
			Hi <= buff[63:32];
			Lo <= buff[31:0];
			div0 <= 0;
			stall <= 0;
		end
		else if(stall&&cnt==0&&(div0))begin
			div0 <= 0;
			stall <= 0;
		end
		else cnt <= (cnt==0)? cnt : cnt - 1;
	end
endmodule
