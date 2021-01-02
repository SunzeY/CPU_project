`timescale 1ns / 1ps

//Opcode
`define R_type 6'b000000
`define ori    6'b001101
`define lw     6'b100011
`define lh     6'b100001
`define lb     6'b100000
`define sw     6'b101011
`define sh     6'b101001
`define sb     6'b101000
`define beq    6'b000100
`define lui    6'b001111
`define addiu  6'b001001
`define jal    6'b000011
`define j      6'b000010
`define bltzal 6'b000001

//Mem_type
`define M_byte   Mem_type = 2'b01
`define M_half   Mem_type = 2'b10
`define M_word   Mem_type = 2'b11

//func
`define jr     Funct==6'b001000
`define addu   Funct==6'b100001
`define subu   Funct==6'b100011
`define oru    Funct==6'b100101
`define andu   Funct==6'b100100
`define sll    Funct==6'b000000
`define sllv   Funct==6'b000100
`define jalr   Funct==6'b001001

module Controller(
   input Zero,
   input [5:0] Opcode,
   input [5:0] Funct,
	input Branch,
   output reg [1:0] NPCOp,
   output reg [1:0] WDSel,
   output reg [1:0] WRSel,
   output reg RFWr,
   output reg [1:0] ExtOp,
   output reg [2:0] ALUOp,
	output reg ALUSrc,
   output reg DMWr,
	output reg [1:0] Mem_type
	);
	
	wire [2:0] ALUControl;
	
	assign ALUControl = (`addu)? 3'b000:
							  (`subu)? 3'b001:
							  (`andu)? 3'b010:
							  (`oru )? 3'b011:
							  (`sllv)? 3'b100:
							           3'b000;

	always @(*)begin
	case(Opcode)
		`R_type:begin
			if(`jalr)begin
				RFWr = 1;
				WDSel = 2'b10;
				WRSel = 2'b01;
				DMWr = 0;
				ALUOp = 3'b000;
				ALUSrc = 0;
				NPCOp = 2'b11;
				ALUSrc = 0;
				Mem_type = 0;
			end
			else if(`jr)begin
				RFWr = 0;
				WDSel = 2'b00;
				WRSel = 2'b00;
				DMWr = 0;
				ALUOp = 3'b000;
				ALUSrc = 0;
				NPCOp = 2'b11;
				ALUSrc = 0;
				Mem_type = 0;
			end
			else if(`sll)begin
				RFWr = 1;
				WDSel = 2'b00;
				WRSel = 2'b01;
				DMWr = 0;
				ALUOp = 3'b100;
				ALUSrc = 0;
				NPCOp = 2'b00;
				ExtOp = 2'b00;
				Mem_type = 0;
			end
			else begin
				RFWr = 1;
				WRSel = 2'b01;
				WDSel = 2'b00;
				DMWr = 0;
				ALUOp = ALUControl;
				NPCOp = 2'b00;
				ALUSrc = 0;
				ExtOp = 2'b00;
				Mem_type = 0;
			end
		end
		`bltzal:begin
			RFWr = 1;
			WRSel = 2'b10;
			WDSel = 2'b10;
			DMWr = 0;
			ALUOp = 3'b000;
			if(Branch) NPCOp = 2'b01;
			else NPCOp = 2'b00;
			ExtOp = 2'b00;
			ALUSrc = 0;
			Mem_type = 0;
		end
		`ori:begin
			RFWr = 1;
			WRSel = 2'b00;
			WDSel = 2'b00;
			DMWr = 0;
			ALUOp = 3'b011;
			NPCOp = 2'b00;
			ExtOp = 2'b01;
			ALUSrc = 1;
			Mem_type = 0;
		end
		// DM_IN_OUT
		`lw:begin
			RFWr = 1;
			WRSel = 2'b00;
			WDSel = 2'b01;
			DMWr = 0;
			ALUOp = 3'b000;
			NPCOp = 2'b00;
			ALUSrc = 1;
			ExtOp = 2'b00;
			`M_word;
		end
		`lh:begin
			RFWr = 1;
			WRSel = 2'b00;
			WDSel = 2'b01;
			DMWr = 0;
			ALUOp = 3'b000;
			NPCOp = 2'b00;
			ALUSrc = 1;
			ExtOp = 2'b00;
			`M_half;
		end
		`lb:begin
			RFWr = 1;
			WRSel = 2'b00;
			WDSel = 2'b01;
			DMWr = 0;
			ALUOp = 3'b000;
			NPCOp = 2'b00;
			ALUSrc = 1;
			ExtOp = 2'b00;
			`M_byte;
		end
		`sw:begin
			RFWr = 0;
			WRSel = 2'b00;
			WDSel = 2'b00;
			DMWr = 1;
			ALUOp = 3'b000;
			NPCOp = 2'b00;
			ExtOp = 2'b00;
			ALUSrc = 1;
			`M_word;
		end
		`sh:begin
			RFWr = 0;
			WRSel = 2'b00;
			WDSel = 2'b00;
			DMWr = 1;
			ALUOp = 3'b000;
			NPCOp = 2'b00;
			ExtOp = 2'b00;
			ALUSrc = 1;
			`M_half;
		end
		`sb:begin
			RFWr = 0;
			WRSel = 2'b00;
			WDSel = 2'b00;
			DMWr = 1;
			ALUOp = 3'b000;
			NPCOp = 2'b00;
			ExtOp = 2'b00;
			ALUSrc = 1;
			`M_byte;
		end
		`beq:begin
			RFWr = 0;
			WRSel = 2'b00;
			WDSel = 2'b00;
			DMWr = 0;
			ALUSrc = 0;
			ALUOp = 3'b001;
			NPCOp = 2'b00;
			if(Zero) NPCOp = 2'b01;
			Mem_type = 0;
		end
		`lui:begin
			RFWr = 1;
			WRSel = 2'b00;
			WDSel = 2'b00;
			DMWr = 0;
			ALUOp = 3'b000;
			NPCOp = 2'b00;
			ExtOp = 2'b10;
			ALUSrc = 1;
			Mem_type = 0;
		end
		`addiu:begin
			RFWr = 1;
			WRSel = 2'b00;
			WDSel = 2'b00;
			DMWr = 0;
			ALUOp = 3'b000;
			NPCOp = 2'b00;
			ExtOp = 2'b00;
			ALUSrc = 1;
			Mem_type = 0;
		end
		`jal:begin
			RFWr = 1;
			WRSel = 2'b10;
			WDSel = 2'b10;
			DMWr = 0;
			ALUOp = 3'b000;
			NPCOp = 2'b10;
			ALUSrc = 0;
			Mem_type = 0;
		end
		`j:begin
			RFWr = 0;
			WRSel = 2'b00;
			WDSel = 2'b00;
			DMWr = 0;
			ALUOp = 3'b000;
			NPCOp = 2'b10;
			Mem_type = 0;
		end
	endcase
	end

endmodule
