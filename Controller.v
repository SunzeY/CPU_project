`timescale 1ns / 1ps
`include "head.v"

module Controller(
   input Zero,
   input [31:0] Instr,
	output reg [3:0] ALUOp,
	output reg [2:0] BSetOp,
   output reg [1:0] NPCOp,
   output reg [1:0] WDSel,
   output reg [1:0] WRSel,
   output reg RFWr,
	output reg DMWr,
   output reg [1:0] ExtOp,
	output reg ALUSrc,
	output reg [1:0] Mem_type,
	output reg Load_type,
	output reg [1:0] REOp,
	output reg [1:0] HiLoWr,
	output reg Start
	);
	
	always @(*)begin
	
		//ALUOp //norc has
		if(`add||`addu||`addi||`addiu) ALUOp = 4'b0000;
		else if(`sub||`subu) ALUOp = 4'b0001;
		else if(`andu||`andi) ALUOp = 4'b0010;
		else if(`oru||`ori) ALUOp = 4'b0011;
		else if(`noru) ALUOp = 4'b0100;
		else if(`xoru||`xori) ALUOp = 4'b0101;
		else if(`sll||`sllv) ALUOp = 4'b0110;
		else if(`sra||`srav) ALUOp = 4'b0111;
		else if(`srl||`srlv) ALUOp = 4'b1000;
		else if(`slt||`slti) ALUOp = 4'b1001;
		else if(`sltu||`sltiu) ALUOp = 4'b1010;
		else if(`lui) ALUOp = 4'b1011;
		else ALUOp = 4'b0000;
		
		//BSetOp
		if(`beq) BSetOp = 3'b000;
		else if(`bgez) BSetOp = 3'b001;
		else if(`bgtz) BSetOp = 3'b010;
		else if(`blez) BSetOp = 3'b011;
		else if(`bltz) BSetOp = 3'b100;
		else if(`bne)  BSetOp = 3'b101;
		else BSetOp = 3'b110;
		
		//WDSel
		if(`lb||`lbu||`lhu||`lw||`lh) WDSel = 2'b01;
		else if(`jal||`jalr) WDSel = 2'b10;
		else WDSel = 2'b00;
		
		//WRSel
		if(`add||`addu||`sub||`subu||`oru||`noru||`xoru
		   ||`andu||`slt||`sltu||`sllv||`srav||`srlv
			||`sll||`sra||`srl||`mfhi||`mflo||`jalr) WRSel = 2'b01;
		else if(`jal) WRSel = 2'b10;
		else WRSel = 2'b00;
		
		//RFWr
		if(`add||`addu||`sub||`subu||`oru||`noru||`xoru||`andu||`slt||`sltu||`jalr
			||`sllv||`srav||`srlv||`sll||`sra||`srl||`addi||`addiu||`andi||`mfhi||`jal||`lh
			||`lui||`ori||`slti||`sltiu||`xori||`lb||`lbu||`lhu||`lw||`mflo) RFWr = 1;
		else RFWr = 0;
		
		//DFWr
		if(`sb||`sh||`sw) DMWr = 1;
		else DMWr = 0;
		
		//ExtOp
		if(`xori||`ori||`andi) ExtOp = 2'b01;
		else if(`lui) ExtOp = 2'b10;
		else ExtOp = 2'b00;
		
		//ALUSrc
		if(`addi||`addiu||`andi||`lui||`ori||`slti||`sltiu
			||`xori||`lb||`lbu||`lh||`lhu||`lw||`sb||`sh||`sw) ALUSrc = 1;
		else ALUSrc = 0;
		
		//NPCOp
		if((`beq||`bgez||`bgtz||`blez||`bltz||`bne)&&Zero) NPCOp = 2'b01;
		else if(`j||`jal) NPCOp = 2'b10;
		else if(`jr||`jalr) NPCOp = 2'b11;
		else NPCOp = 2'b00;
		
		//Mem_type
		if(`sb||`lb||`lbu) Mem_type = 2'b01;
		else if(`sh||`lhu||`lh) Mem_type = 2'b10;
		else if(`sw||`lw)Mem_type = 2'b11;
		else Mem_type = 2'b0;
		
		//Load_type
		if(`lbu||`lhu) Load_type = 1;
		else Load_type = 0;
		
		//REOp
		if(`mfhi) REOp = 2'b01;
		else if(`mflo) REOp = 2'b10;
		else if(`jal||`jalr) REOp = 2'b11;
		else REOp = 2'b00;
		
		//HiLoWr
		if(`mthi) HiLoWr = 2'b01;
		else if(`mtlo) HiLoWr = 2'b10;
		else HiLoWr = 2'b00;
		
		//Start
		if(`mult||`multu||`div||`divu||`msub) Start = 1;
		else Start = 0;
	end

endmodule
