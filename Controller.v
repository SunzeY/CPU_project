`timescale 1ns / 1ps
`include "head.v"
	module Controller(
   input Zero,
	input [31:0] Instr,
	input overflow,
   output reg [2:0] NPCOp,
	output reg [1:0] BOp,
   output reg [1:0] WDSel,
   output reg [1:0] WRSel,
   output reg RFWr,
   output reg [1:0] ExtOp,
   output reg [2:0] ALUOp,
	output reg ALUSrc,
   output reg DMWr,
	output reg AdOp,
	output reg Clrslot,
	output reg LDOp
	);
	
	always @(*)begin
		if(`jalr)begin
			NPCOp = 3'b011;
			BOp   = 2'b00;
			WDSel = 2'b10;
			WRSel = 2'b01;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 1;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`bgezall)begin
			if(Zero)NPCOp = 3'b001;
			else NPCOp = 3'b000;
			BOp   = 2'b01;
			WRSel = 2'b10;
			WDSel = 2'b10;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 1;
			if(~Zero) Clrslot = 1;
			else Clrslot = 0;
			LDOp = 0;
		end
		else if(`bltzal)begin
			if(Zero)NPCOp = 3'b001;
			else NPCOp = 3'b000;
			BOp   = 2'b10;
			WRSel = 2'b10;
			WDSel = 2'b10;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 1;
			if(Zero)RFWr  = 1;
			else RFWr  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`beq)begin
			if(Zero)NPCOp = 3'b001;
			else NPCOp = 3'b000;
			BOp   = 2'b00;
			WRSel = 2'b00;
			RFWr  = 0;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`lwso)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b01;
			WRSel = 2'b00;
			if(~overflow) RFWr  = 1;
			else RFWr  = 0;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 1;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 1;
		end
		else if(`lwld||`lrm)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b01;
			WRSel = 2'b00;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 1;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`jal)begin
			NPCOp = 3'b010;
			BOp   = 2'b00;
			WDSel = 2'b10;
			WRSel = 2'b10;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 1;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`andu)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b01;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b010;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`beq)begin
			if(Zero)NPCOp = 3'b001;
			else NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b00;
			RFWr  = 0;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`j)begin
			NPCOp = 3'b010;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b00;
			RFWr  = 0;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`jr)begin
			NPCOp = 3'b011;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b00;
			RFWr  = 0;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`sll)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b01;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`lw)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b01;
			WRSel = 2'b00;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 1;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`sw)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b00;
			RFWr  = 0;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 1;
			DMWr  = 1;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`xoru)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b01;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b101;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`addu)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b01;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`subu)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b01;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b001;
			ALUSrc= 0;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`ori)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b00;
			RFWr  = 1;
			ExtOp = 2'b01;
			ALUOp = 3'b100;
			ALUSrc= 1;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`addi)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b00;
			RFWr  = 1;
			ExtOp = 2'b00;
			ALUOp = 3'b000;
			ALUSrc= 1;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
		else if(`lui)begin
			NPCOp = 3'b000;
			BOp   = 2'b00;
			WDSel = 2'b00;
			WRSel = 2'b00;
			RFWr  = 1;
			ExtOp = 2'b10;
			ALUOp = 3'b110;
			ALUSrc= 1;
			DMWr  = 0;
			AdOp  = 0;
			Clrslot = 0;
			LDOp = 0;
		end
	end

endmodule
