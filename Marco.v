`timescale 1ns / 1ps
module Marco(
    input [31:0] PC_M,
    input [31:0] PC_E,
    input [31:0] PC_D,
    input [31:0] PC_F,
    input [8:2] Exc_M,
    input [8:2] Exc_E,
    input [8:2] Exc_D,
    input [8:2] Exc_F,
    output [31:0] MacroPC,
    output MacroBD
    );
	 
	
	assign MacroPC = (PC_M || Exc_M[7]) ? (PC_M) :
                    (PC_E || Exc_E[7]) ? (PC_E) : 
                    (PC_D || Exc_D[7]) ? (PC_D) : 
                    (PC_F) ? (PC_F) : 0;
						  
	assign MacroBD = (PC_M || Exc_M[7]) ? (Exc_M[8]) : 
                    (PC_E || Exc_E[7]) ? (Exc_E[8]) : 
                    (PC_D || Exc_D[7]) ? (Exc_D[8]) : 
                    (PC_F) ? (Exc_F[8]) : 0;

endmodule
