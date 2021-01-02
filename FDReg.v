`timescale 1ns / 1ps
module FDReg(
    input clk,
    input reset,
    input FDEn_FD_I,
	 input Flush_FD_I,
    input [31:0] Instr_FD_I,
    input [31:0] PC_FD_I,
    output reg [31:0] Instr_FD_O,
    output reg [31:0] PC_FD_O
    );
	 initial begin
		Instr_FD_O <= 32'h0000_0000;
		PC_FD_O    <= 32'h0000_3000;
	 end
	 always @(posedge clk)begin
		if(reset)begin
			Instr_FD_O <= 32'h0000_0000;
			PC_FD_O    <= 32'h0000_3000;
		end
		else if(FDEn_FD_I)begin
			Instr_FD_O <= Instr_FD_I;
			PC_FD_O    <= PC_FD_I;
		end
	end


endmodule
