`timescale 1ns / 1ps
`define addu 3'b000
`define subu 3'b001
`define andu 3'b010
`define oru  3'b011
`define sll  3'b100

module ALU(ALUControl, Instr, SrcA, SrcB, Zero, result);
   input [2:0] ALUControl;
	input [31:0] Instr;
   input [31:0] SrcA;
   input [31:0] SrcB;
   output Zero;
   output [31:0] result;
	
	assign result = (ALUControl==`addu)? SrcA + SrcB:
	                (ALUControl==`subu)? SrcA - SrcB:
						 (ALUControl==`andu)? SrcA & SrcB:
						 (ALUControl==`oru) ? SrcA | SrcB:
						 (ALUControl==`sll&&Instr[5:0]==6'b000100) ? SrcB << SrcA :
						 (ALUControl==`sll&&Instr[5:0]==6'b000000) ? SrcB << Instr[10:6] : 32'h0000_0000;
	
	assign Zero = (SrcA==SrcB);

endmodule
