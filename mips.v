`timescale 1ns / 1ps
module mips(clk, reset);
   input clk;
   input reset;
	
	// Controller
	wire Branch;
	wire Zero_C;
	wire [1:0] NPCOp_C;
	wire [1:0] WRSel_C;
	wire [1:0] WDSel_C;
	wire RFWr_C;
	wire [1:0] ExtOp_C;
	wire ALUSrc_C;
	wire [2:0] ALUControl_C;
	wire MemWrite_C;
	wire [1:0] NpcOp_C;
	wire [5:0] Opcode_C;
	wire [5:0] Function_C;
	wire [1:0] M_type_C;
	
	//LTC wire declare
	 wire [31:0] addr_L;
	 wire [31:0] Din_L;
	 wire [1:0] M_type_L;
	 wire [31:0] Dout_L;
	
	//PC
	wire [31:0] pc_P;
	wire [31:0] Npc_P;
	
	//NPC
	wire [31:0] pc_N;
	wire [25:0] IMM_N;
	wire [31:0] RA_N;
	wire [1:0] NpcOp_N;
	wire [31:0] pc4_N;
	wire [31:0] Npc_N;
	
	//IM
	wire [31:0] Iaddr_I;
	wire [31:0] Instr_I;

	// GRF
	wire [4:0] A1_G;
	wire [4:0] A2_G;
	wire [4:0] Waddr_G;
	wire [31:0] WData_G;
	wire [31:0] RD1_G;
	wire [31:0] RD2_G;

	//Extender
	wire [1:0] ExtControl_E;
	wire [15:0] Src_E;
   wire [31:0] result_E;
	
	// ALU
   wire [2:0] ALUControl_A;
	wire [31:0] Instr_A;
   wire [31:0] SrcA_A;
   wire [31:0] SrcB_A;
   wire Zero_A; 
   wire [31:0] result_A;

	// DM
   wire scr_D;
	wire [1:0] M_type_D;
   wire [31:0] addr_D; 
   wire [31:0] din_D;
   wire [31:0] dout_D;
	
	//Controller_wireinput
	assign Branch = ($signed(RD1_G)<0);
	assign Zero_C = Zero_A;
	assign Opcode_C = Instr_I[31:26];
	assign Function_C = Instr_I[5:0];
	
	//PC_wireinput
	assign Npc_P = Npc_N;
	
	//NPC_wireinput
	assign pc_N = pc_P;
	assign NpcOp_N = NpcOp_C;
	assign IMM_N = Instr_I[25:0];
	assign RA_N = RD1_G;
	
	//IM_wireinput
	assign Iaddr_I = pc_P;
	
	//GRF_wireinput
	assign A1_G = Instr_I[25:21];
	assign A2_G = Instr_I[20:16];
	assign Waddr_G = (WRSel_C==2'b00)?  Instr_I[20:16]:
					     (WRSel_C==2'b01)?  Instr_I[15:11]:
					     (WRSel_C==2'b10)?  5'h1f : 5'b0;
						  
	assign WData_G = (WDSel_C==2'b00)? result_A:
						  (WDSel_C==2'b01)? Dout_L:
						  (WDSel_C==2'b10)? pc4_N: 5'b0;
						  
	assign RegWrite_G = RFWr_C;
	
	//Extender_wireinput
	assign ExtControl_E = ExtOp_C;
	assign Src_E = Instr_I[15:0];
	
	//ALU_wireinput
	assign ALUControl_A = ALUControl_C;
	assign Instr_A = Instr_I;
	assign SrcA_A = RD1_G;
	assign SrcB_A = (ALUSrc_C==0)? RD2_G : result_E;

   //DM_wireinput
	assign scr_D = MemWrite_C;
	assign addr_D = result_A;
	assign M_type_D = M_type_C;
	assign din_D = RD2_G;
	
	//LTC_wireinput
	assign M_type_L = M_type_C;
	assign Din_L = dout_D;
	assign addr_L = result_A;
	
	//modulization
	Controller Controller0 (
	 .Branch(Branch),
    .Zero(Zero_C), 
    .Opcode(Opcode_C), 
    .Funct(Function_C), 
    .NPCOp(NpcOp_C), 
    .WRSel(WRSel_C), 
    .WDSel(WDSel_C), 
    .RFWr(RFWr_C), 
    .ExtOp(ExtOp_C), 
    .ALUSrc(ALUSrc_C), 
    .ALUOp(ALUControl_C), 
    .DMWr(MemWrite_C),
	 .Mem_type(M_type_C)
    );
	 
	PC PC0 (
    .clk(clk), 
    .reset(reset), 
    .Npc(Npc_P), 
    .pc(pc_P)
    );
	 
   NPC NPC0 (
    .pc(pc_N), 
    .IMM(IMM_N), 
    .RA(RA_N), 
    .NPCOp(NpcOp_N), 
    .pc4(pc4_N), 
    .Npc(Npc_N)
    );
	 
   IM IM0 (
    .Iaddr(Iaddr_I), 
    .Instr(Instr_I)
    );
	 
	GRF GRF0 (
    .clk(clk), 
    .reset(reset),
    .PC(pc_P),	 
    .RegWrite(RegWrite_G), 
    .A1(A1_G), 
    .A2(A2_G), 
    .Waddr(Waddr_G), 
    .WData(WData_G), 
    .RD1(RD1_G), 
    .RD2(RD2_G)
    );
	
	Extender Extender0 (
    .ExtControl(ExtControl_E), 
    .Src(Src_E), 
    .result(result_E)
    );
	
	ALU ALU0 (
    .ALUControl(ALUControl_A), 
	 .Instr(Instr_A),
    .SrcA(SrcA_A), 
    .SrcB(SrcB_A), 
    .Zero(Zero_A), 
    .result(result_A)
    );
	
	 DM DM0 (
    .clk(clk), 
    .reset(reset), 
	 .pc(pc_P),
    .scr(scr_D), 
	 .M_type(M_type_D),
    .addr(addr_D), 
    .din(din_D), 
    .dout(dout_D)
    );
	 
	 LTC LTC0 (
    .addr(addr_L), 
    .Din(Din_L), 
    .M_type(M_type_L), 
    .Dout(Dout_L)
    );

endmodule
