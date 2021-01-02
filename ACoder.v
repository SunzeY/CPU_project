`timescale 1ns / 1ps
`include "head.v"
module ACoder(
	 input [31:0] Instr,
    output reg [2:0] TUsers,
	 output reg [2:0] TUsert,
    output reg [2:0] TNew
    );
	 
	 always @(*)begin
		if(`jr) begin
			TUsers = 0;
			TUsert = 4;
			TNew = 0;
		end
		else if(`xoru)begin
		   TUsers = 1;
			TUsert = 1;
			TNew = 2;
		end
		else if(`bgezall)begin
			TUsers = 0;
			TUsert = 4;
			TNew = 2;
		end
		else if(`bltzal)begin
			TUsers = 0;
			TUsert = 4;
			TNew = 2;
		end
		else if(`jalr)begin
		   TUsers = 0;
			TUsert = 4;
			TNew = 2;
		end
		else if(`andu)begin
		   TUsers = 1;
			TUsert = 1;
			TNew = 2;
		end
		else if(`sll)begin
		   TUsers = 1;
			TUsert = 0;
			TNew = 2;
		end
		else if(`addu||`subu)begin
		   TUsers = 1;
			TUsert = 1;
			TNew = 2;
		end
		else if(`lui)begin
			TUsers = 4;
			TUsert = 4;
			TNew = 2;
		end
		else if(`ori||`addi)begin
			TUsers = 1;
			TUsert = 4;
			TNew = 2;
		end
		else if(`beq)begin
			TUsers = 0;
			TUsert = 0;
			TNew = 0;
		end
		else if(`jal)begin
			TUsers = 4;
			TUsert = 4;
			TNew = 2;
		end
		else if(`lw||`lwso||`lwld||`lrm)begin
			TUsers = 1;
			TUsert = 4;
			TNew = 3;
		end
		else if(`sw)begin
			TUsers = 1;
			TUsert = 2;
			TNew = 0;
		end
		else if(`j)begin
			TUsers = 4;
			TUsert = 4;
			TNew = 0;
		end	
	 end
endmodule
