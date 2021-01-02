//`timescale 1ns / 1ps
`include "head.v"
module GRF(clk, reset, Instr, PC, RegWrite, A1, A2, Waddr, WData, RD1, RD2);
   input clk;
	input reset;
	input [31:0] Instr;
	input [31:0] PC;
	input RegWrite;
   input [4:0] A1;
   input [4:0] A2;
   input [4:0] Waddr;
   input [31:0] WData;
   output [31:0] RD1;
   output [31:0] RD2;
	
	reg [31:0] reg_file [0:31];
	
	initial begin: init_mem
		reg[5:0] tempi;
			for(tempi=0;tempi<32;tempi=tempi+1)
				reg_file[tempi] <= 0;
	end
	
	always @(posedge clk) begin
		if(reset) begin: clr_mem
			reg[5:0] tempi;
				for(tempi=0;tempi<32;tempi=tempi+1)
					reg_file[tempi] = 0;
		end
	   else if(RegWrite) begin
			if(Waddr!=0)begin 
				reg_file [Waddr] <= WData;
				$display("%d@%h: $%d <= %h", $time, PC, Waddr, WData);
			end
		end
	end
	assign RD1 = (A1==Waddr&&RegWrite==1&&A1!=0)? WData : reg_file[A1];
	assign RD2 = (A2==Waddr&&RegWrite==1&&A2!=0)? WData : reg_file[A2];
	
endmodule
