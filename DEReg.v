`timescale 1ns / 1ps
module DEReg(
    input clk,
    input reset,
	 input Flush_DE_I,
    input [31:0] Instr_DE_I,
    input [31:0] PC_DE_I,
    input [31:0] RD1_DE_I,
    input [31:0] RD2_DE_I,
	 input [2:0] Tnew_DE_I,
	 input [31:0] Ext_DE_I,
    output reg [31:0] Instr_DE_O,
	 output reg [31:0] PC_DE_O,
	 output reg [31:0] RD1_DE_O,
	 output reg [31:0] RD2_DE_O,
    output reg [2:0]  Tnew_DE_O,
	 output reg [31:0] Ext_DE_O
    );
	 initial begin
		Instr_DE_O <= 32'h0000_0000;
		PC_DE_O    <= 32'h0000_3000;
		RD1_DE_O   <= 0;
		RD2_DE_O   <= 0;
		Ext_DE_O   <= 0;
		Tnew_DE_O  <= 0;	
	 end
	 always @(posedge clk)begin
		 if(reset)begin
			Instr_DE_O <= 32'h0000_0000;
			PC_DE_O    <= 32'h0000_3000;
		 end
		 else begin
			 if(Flush_DE_I)begin
				Instr_DE_O <= 32'h0000_0000;
				PC_DE_O    <= 32'h0000_3000;
			 end
			 else begin
				 Instr_DE_O <= Instr_DE_I;
				 PC_DE_O    <= PC_DE_I;
				 RD1_DE_O   <= RD1_DE_I;
				 RD2_DE_O   <= RD2_DE_I;
				 Tnew_DE_O  <= (|Tnew_DE_I) ? Tnew_DE_I-1 : 0;
				 Ext_DE_O <= Ext_DE_I;
			 end
		 end
	 end

endmodule
