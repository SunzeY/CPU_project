`timescale 1ns / 1ps
`define sig   2'b00
`define unsig 2'b01
`define lui   2'b10
module Extender( ExtControl, Src, result);
   input [1:0] ExtControl;
   input [15:0] Src;
   output [31:0] result;

	assign result = (ExtControl==`sig)  ? {{16{Src[15]}}, {Src[15:0]}}:
						 (ExtControl==`unsig)? {16'b0, {Src[15:0]}}        :
						 (ExtControl==`lui)?   {{Src[15:0]}, 16'b0}        :
													  32'h 0000_0000;
endmodule
