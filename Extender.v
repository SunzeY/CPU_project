`timescale 1ns / 1ps
`include "head.v"
module Extender( ExtControl, Src, Instr, result);
   input [1:0] ExtControl;
   input [15:0] Src;
	input [31:0] Instr;
   output [31:0] result;

	assign result = (ExtControl==2'b00)  ? {{16{Src[15]}}, {Src[15:0]}}:
						 (ExtControl==2'b01)? {16'b0, {Src[15:0]}}        :
						 (ExtControl==2'b10)?   {{Src[15:0]}, 16'b0}        :
													  32'h 0000_0000;
endmodule
