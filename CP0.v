`timescale 1ns / 1ps

`define Hit_SR2     A2==5'd12
`define Hit_EPC2    A2==5'd14

`define Hit_SR1     A1==5'd12
`define Hit_Cause1  A1==5'd13
`define Hit_EPC1    A1==5'd14
`define Hit_PRID1   A1==5'd15

`define EXL SR[1]
`define IE  SR[0]
`define IM  SR[15:10]
`define BD  Cause[31]
`define IP  Cause[15:10]
`define EXC Cause[6:2]

module CP0(
    input [4:0] A1,
    input [4:0] A2,
    input [31:0] DIn,
    input [31:2] PC,
    input [8:2] ExCode,
    input [5:0] HWInt,
    input We,
    input EXLSet,
    input EXLClr,
    input clk,
    input reset,
    output IntReq_O,
    output reg [31:0] EPC,
    output [31:0] DOut
    );
	 
	 wire [6:2] EXC0;
	 wire BD0;
	 
	 reg [31:0] SR;
	 reg [31:0] Cause;
	 reg [31:0] PRID;
	 
	 assign IntReq_O = ((|(HWInt[5:0] & `IM) & `IE) |  ExCode[7])& !`EXL;
	 
	 assign EXC0 = ((|(HWInt[5:0] & `IM) & `IE)) ? 6'b0 : ExCode[6:2];
	 
	 assign BD0 = ExCode[8] ? 1 : 0;
					  
	 assign DOut = `Hit_SR1    ? SR    :
						`Hit_Cause1 ? Cause :
						`Hit_EPC1   ? EPC   :
						`Hit_PRID1  ? PRID  : 0;
	 
	 initial begin
		SR <= 0;
		Cause <= 0;
		EPC <= 32'h0000_0000;
		PRID <= 32'd983499284;
	 end
	 always @(posedge clk)begin
		if(reset)begin
			SR <= 0;
			Cause <= 0;
			EPC <= 32'h0000_0000;
			PRID <= 32'd983499284;	
		end
		else begin
		   `IP  <= HWInt;
			if(EXLSet)begin
				`EXL <= 1;
			end
			if(EXLClr)begin
				`EXL <= 0;
			end
		   if(We)begin
				if(`Hit_SR2) {`IM, `EXL, `IE} <= {DIn[15:10], DIn[1], DIn[0]};
				else if(`Hit_EPC2) EPC <= DIn;
			end
		   if(IntReq_O)begin
				`EXL <= 1;
				 if(BD0) EPC <= {PC-1, 2'b0};
				 else EPC <= {PC, 2'b0};
				`EXC <= EXC0;
				`BD  <= BD0;
			end
		end
	 end
endmodule
