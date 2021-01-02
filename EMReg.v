`timescale 1ns / 1ps
module EMReg(
    input clk,
    input reset,
	 input Flush_EM_I,
    input [31:0] Instr_EM_I,
	 input [8:2] ExCode_EM_I,
    input [31:0] PC_EM_I,
    input [31:0] ALURS_EM_I,
    input [31:0] WD_EM_I,
    input [4:0] Dst_EM_I,
	 input [2:0] Tnew_EM_I,
	 input eret,
	 input [31:0] EPC,
	 output reg [31:0] Instr_EM_O,
    output reg [31:0] PC_EM_O,
    output reg [31:0] ALURS_EM_O,
    output reg [31:0] WD_EM_O,
    output reg [4:0] Dst_EM_O,
	 output reg [2:0] Tnew_EM_O,
	 output reg [8:2] ExCode_EM_O
    );
	 initial begin
		Instr_EM_O <= 32'h0000_0000;
		PC_EM_O    <= 32'h0000_0000;
		Dst_EM_O   <= 5'b00000;
		ALURS_EM_O <= 0;
		WD_EM_O    <= 0;
		Dst_EM_O   <= 0;
		Tnew_EM_O  <= 0;
		ExCode_EM_O <= 0;
	 end
    always @(posedge clk)begin
		 if(reset)begin
			Instr_EM_O <= 32'h0000_0000;
			PC_EM_O    <= 0;
			ALURS_EM_O <= 0;
			WD_EM_O    <= 0;
			Dst_EM_O   <= 0;
			ExCode_EM_O <= 0;
		 end
		 else begin
			if(Flush_EM_I)begin
				Instr_EM_O <= 32'h0000_0000;
				PC_EM_O    <= 0;
				ALURS_EM_O <= 0;
				WD_EM_O    <= 0;
				Dst_EM_O   <= 0;
				ExCode_EM_O <= 0;
			end
			else begin
				Instr_EM_O <= Instr_EM_I;
				PC_EM_O    <= PC_EM_I;
				ALURS_EM_O <= ALURS_EM_I;
				WD_EM_O    <= WD_EM_I;
				Dst_EM_O   <= Dst_EM_I;
				ExCode_EM_O <= ExCode_EM_I;
				Tnew_EM_O  <= (|Tnew_EM_I)? Tnew_EM_I-1 : 0;
			end
	    end
	 end
	 
endmodule
