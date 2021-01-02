`timescale 1ns / 1ps
`include "head.v"
module ALU(ALUControl, SrcA, SrcB, Instr, result);
   input [2:0] ALUControl;
	input [31:0] Instr;
   input [31:0] SrcA;
   input [31:0] SrcB;
   output [31:0] result;
wire [31:0] result; 

function [31:0] calc; 
    input [31:0] srca;
    input [31:0] srcb;
    input [3:0] Aluop;
	 integer i, cnt;
    begin
        case(Aluop)
            3'b000:begin
                calc = srca + srcb; 
            end
            3'b001:begin
                calc = srca - srcb;
            end
            3'b010:begin
                calc = srca & srcb;
            end
            3'b011:begin
                calc = srca << srcb[4:0];
            end
            3'b100:begin
                calc = srca | srcb;
            end
            3'b101:begin
					 calc = 0;
					 cnt = 0;
					 for(i=0;i<32;i=i+1)begin
						if(srca[i]==1) begin
							cnt = cnt + 1;
							if(cnt>calc) calc = cnt;
						end
						else cnt = 0;	
					 end
            end
				3'b110:begin
					calc = srcb;
				end
        endcase
    end
endfunction

	assign result = calc(SrcA, SrcB, ALUControl);
endmodule
