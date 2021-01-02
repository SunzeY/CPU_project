`timescale 1ns / 1ps
module MWReg(
    input clk,
    input reset,
    input [31:0] Instr_MW_I,
    input [31:0] PC_MW_I,
	 input [4:0] Dst_MW_I,
	 input [31:0] RD_MW_I,
	 input [31:0] ALURS_MW_I,
	 input [2:0] Tnew_MW_I,
	 input [31:0] WD_MW_I,
    output reg [31:0] Instr_MW_O,
    output reg [31:0] PC_MW_O,
    output reg [4:0] Dst_MW_O,
	 output reg [31:0] RD_MW_O,
	 output reg [31:0] ALURS_MW_O,
	 output reg [2:0] Tnew_MW_O,
	 output reg [31:0] WD_MW_O
    );
	 initial begin
		Instr_MW_O <= 32'h0000_0000;
		PC_MW_O    <= 32'h0000_3000;
		Dst_MW_O   <= 0;
		RD_MW_O    <= 0;
		ALURS_MW_O <= 0;
		Tnew_MW_O  <= 0;
		WD_MW_O    <= 0;
	 end
	 always @(posedge clk) begin
		if(reset)begin
			Instr_MW_O <= 32'h0000_0000;
			PC_MW_O    <= 32'h0000_3000;
		end
		else begin
			Instr_MW_O <= Instr_MW_I;
			PC_MW_O    <= PC_MW_I;
			Dst_MW_O   <= Dst_MW_I;
			RD_MW_O    <= RD_MW_I;
			ALURS_MW_O <= ALURS_MW_I;
			Tnew_MW_O  <= (|Tnew_MW_I)? Tnew_MW_I-1 : 0;
			WD_MW_O    <= WD_MW_I;
		end
	 end

endmodule
