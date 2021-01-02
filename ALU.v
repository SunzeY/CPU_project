`timescale 1ns / 1ps
`include "head.v"
module ALU(ALUControl, SrcA, SrcB, Instr, result, Overflow);
   input [3:0] ALUControl;
	input [31:0] Instr;
   input [31:0] SrcA;
   input [31:0] SrcB;
   output [31:0] result;
	output Overflow;
	wire [32:0] temp;	

assign temp = (`sub) ? {{SrcA[31]}, SrcA} - {{SrcB[31]}, SrcB}:
				  (`add||`addi)? {{SrcA[31]}, SrcA} + {{SrcB[31]}, SrcB} : 0;

assign Overflow = temp[31] != temp[32];

function [31:0] calc; 
    input [31:0] srca;
    input [31:0] srcb;
    input [4:0] Aluop;
	 input [4:0] Shift;
	 integer i, cnt;
    begin
        case(Aluop)
            4'b0000:begin
                calc = srca + srcb; 
            end
            4'b0001:begin
                calc = srca - srcb;
            end
            4'b0010:begin
                calc = srca & srcb;
            end
            4'b0011:begin
                calc = srca | srcb;
            end
            4'b0100:begin
                calc = ~ (srca | srcb);
            end
            4'b0101:begin
					 calc = srca ^ srcb;
            end
				4'b0110:begin
					 if(`sll) calc = srcb << Shift;
					 else     calc = srcb << srca[4:0];
            end
				4'b0111:begin
					if(`sra) calc = $signed($signed(srcb) >>> $signed(Shift));
					else     calc = $signed($signed(srcb) >>> $signed(srca[4:0]));
				end
				4'b1000:begin
					if(`srl) calc = srcb >> Shift;
					else     calc = srcb >> srca[4:0];
				end
				4'b1001:begin
					calc = $signed(srca)<$signed(srcb);
				end
				4'b1010:begin
					calc = srca < srcb;
				end
				4'b1011:begin
					calc = srcb;
				end
        endcase
    end
endfunction

	assign result = calc(SrcA, SrcB, ALUControl, Instr[10:6]);

endmodule
