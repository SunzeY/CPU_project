`timescale 1ns / 1ps
module PC(clk, reset, PCEn, PCBack, PCtoIn, Npc, pc);
   input clk;
   input reset;
	input PCEn;
	input PCtoIn;
	input PCBack;
   input wire[31:0] Npc;
   output reg [31:0] pc;
	
	initial begin
		pc <= 32'h0000_3000;
	end
	
	always @(posedge clk) begin
		if(reset)begin
			pc <= 32'h0000_3000;
		end
		else if(PCEn||PCtoIn||PCBack)begin
			pc <= Npc;
		end
	end
	

endmodule
