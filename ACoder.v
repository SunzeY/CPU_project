`timescale 1ns / 1ps
`include "head.v"
module ACoder(
    input [31:0] Instr,
    output reg [2:0] TUsers,
	 output reg [2:0] TUsert,
    output reg [2:0] TNew
    );
	 always @(*)begin
		//TNew
		if(`addu||`add||`sub||`subu||`oru||`andu||`noru||`xoru||`mflo||`sll
		  ||`sllv||`srav||`srlv||`slt||`sltu||`sra||`srl||`mfhi||`jalr
		  ||`ori||`addiu||`addi||`andi||`xori||`slti||`sltiu||`lui||`jal) TNew = 3'b010;
		else if(`lw||`lb||`lhu||`lbu||`lh) TNew = 3'b011;
		else TNew = 3'b000;
		
		//TUsers
		if(`addu||`add||`sub||`subu||`oru||`andu||`noru||`mthi||`divu
			||`xoru||`sllv||`srav||`srlv||`slt||`sltu||`lw||`mtlo||`lh
			||`lb||`lhu||`lbu||`sw||`sh||`sb||`ori||`addiu||`div
			||`addi||`andi||`xori||`slti||`sltiu||`multu||`mult) TUsers = 3'b001;
		else if(`sll||`sra||`srl||`lui||`jal||`j) TUsers = 3'b101;
		else TUsers = 3'b000;
		
		//TUsert
		if(`addu||`add||`sub||`subu||`oru||`andu||`div
		  ||`noru||`xoru||`sllv||`srav||`srlv||`slt||`divu||`multu
		  ||`sltu||`mult||`mthi) TUsert = 3'b001;
		else if(`lw||`lb||`lhu||`lbu||`ori||`lh
		       ||`addiu||`addi||`andi||`xori||`slti
				 ||`sltiu||`lui||`jal||`jalr||`j) TUsert = 3'b101;
		else if(`sw||`sh||`sb)TUsert = 3'b010;
		else TUsert = 3'b000;
	 end
	 

endmodule
