`timescale 1ns / 1ps
module cpu(
    input clk,
    input reset,
	 input [31:0] PrRD,
	 input [7:2] HWInt,
	 output [31:0] addr,
	 output [31:2] PrAddr,
	 output [31:0] PrWD, 
	 output PrWe
    );

	 // Exctrl wire declare
	 wire [31:0] EPC;
	 wire [31:0] EPC_I;
	 wire [8:2] ExCode_FD_O;
	 wire [8:2] ExCode_F_O;
	 wire [8:2] ExCode_D_O;
	 wire [8:2] ExCode_DE_O;
	 wire [8:2] ExCode_E_O;
	 wire [8:2] ExCode_EM_O;
	 wire [8:2] ExCode_M_O;
	 
	 // RiskCtrl wire declare
	 wire [31:0] InstrD_R_I;
	 wire stallE_R_I;
	 wire RFWrE_R_I;
	 wire RFWrM_R_I;
	 wire RFWrW_R_I;
	 wire DMWrM_R_I;
	 wire [5:0] Tuse_R_I;
	 wire [2:0] TE_R_I;
	 wire [2:0] TM_R_I;
	 wire [2:0] TW_R_I;
	 wire [4:0] DstE_R_I;
	 wire [4:0] DstM_R_I; 
	 wire [4:0] DstW_R_I;
	 wire [4:0] RsD_R_I;
	 wire [4:0] RtD_R_I;
	 wire [4:0] RsE_R_I;
	 wire [4:0] RtE_R_I;
	 wire PCEnD_R_O;
	 wire EnD_R_O;
	 wire FlushE_R_O;
	 wire ForwardRsD_R_O;
	 wire ForwardRtD_R_O;
	 wire [1:0] ForwardRtE_R_O;
	 wire [1:0] ForwardRsE_R_O;
	 wire ForwardM_R_O;
	 
	 // F wire declare
	 wire PCE_F_I;
	 wire [25:0] IMM_F_I;
	 wire [31:0] RA_F_I;
	 wire [1:0] NPCOp_F_I;
	 wire [31:0] Instr_F_O;
	 wire [31:0] PC_F_O;
	 
	 //FDReg wire declare
	 wire FDEn_FD_I;
	 wire [31:0] Instr_FD_I;
	 wire [31:0] PC_FD_I;
	 wire [31:0] Instr_FD_O;
	 wire [31:0] PC_FD_O;
	 
	 //D wire declare
	 wire [31:0] Instr_D_I;
	 wire [31:0] PC_D_I;
	 wire [4:0] WR_D_I;
	 wire [31:0] WD_D_I;
	 wire ForwardRs_D_I;
	 wire ForwardRt_D_I;
	 wire [31:0] TMF_D_I;
	 wire [1:0] NPCOp_D_O;
	 wire [5:0] Tuse_D_O;
	 wire [2:0] Tnew_D_O;
	 wire [31:0] RD1_D_O;
	 wire [31:0] RD2_D_O;
	 wire [31:0] Ext_D_O;
	 
	 //DEReg wire declare
	 wire Flush_DE_I;
	 wire [31:0] Instr_DE_I;
	 wire [31:0] PC_DE_I;
	 wire [31:0] RD1_DE_I;
	 wire [31:0] RD2_DE_I;
	 wire [2:0] Tnew_DE_I;
	 wire [31:0] Ext_DE_I;
	 wire [31:0] Instr_DE_O;
	 wire [31:0] PC_DE_O;
	 wire [31:0] RD1_DE_O;
	 wire [31:0] RD2_DE_O;
	 wire [2:0] Tnew_DE_O;
	 wire [31:0] Ext_DE_O;
	 
	 //E wire declare
	 wire [31:0] Instr_E_I;
	 wire [31:0] PC_E_I;
	 wire [31:0] RD1_E_I;
	 wire [31:0] RD2_E_I;
	 wire [31:0] Ext_E_I;
	 wire [1:0] ForwardRsE_E_I;
	 wire [1:0] ForwardRtE_E_I;
	 wire [31:0] TMF_E_I;
	 wire [31:0] TWF_E_I;
	 wire [31:0] ALURS_E_O;
	 wire RFWr_E_O;
	 wire [4:0] Dst_E_O;
	 wire [31:0] WD_E_O;
	 wire Stall_E_O;
	 
	 //EM wire declare
	 wire [31:0] Instr_EM_I;
	 wire [31:0] PC_EM_I;
	 wire [31:0] ALURS_EM_I;
	 wire [31:0] WD_EM_I;
	 wire [4:0] Dst_EM_I;
	 wire [2:0] Tnew_EM_I;
	 wire [31:0] Instr_EM_O;
	 wire [31:0] PC_EM_O;
	 wire [31:0] ALURS_EM_O;
	 wire [31:0] WD_EM_O;
	 wire [4:0] Dst_EM_O;
	 wire [2:0] Tnew_EM_O;
	 
	 // M wire declare
	 wire [31:0] Instr_M_I;
	 wire [31:0] PC_M_I;
	 wire [31:0] ALURS_M_I;
	 wire [31:0] WD_M_I;
	 wire Forward_M_I;
	 wire [31:0] TFW_M_I;
	 wire RFWr_M_O;
	 wire DMWr_M_O;
	 wire [31:0] RD_M_O;
	 
	 //MWReg wire declare
	 wire [31:0] Instr_MW_I;
	 wire [31:0] PC_MW_I;
	 wire [4:0] Dst_MW_I;
	 wire [31:0] RD_MW_I;
	 wire [31:0] ALURS_MW_I;
	 wire [2:0] Tnew_MW_I;
	 wire [31:0] Instr_MW_O;
	 wire [31:0] PC_MW_O;
	 wire [4:0] Dst_MW_O;
	 wire [31:0] RD_MW_O;
	 wire [31:0] ALURS_MW_O;
	 wire [2:0] Tnew_MW_O;
	 wire [31:0] WD_MW_O;
	 
	 //W wire declare
	 wire [31:0] Instr_W_I;
	 wire [31:0] PC_W_I;
	 wire [31:0] RD_W_I;
	 wire [31:0] ALURS_W_I;
	 wire [31:0] WD_W_O;
	 wire RFWr_W_O;
	 
	 assign PrWe = DMWr_M_O;
	 
	 //data path wire assign
	 assign Instr_FD_I = Instr_F_O;
	 assign Instr_D_I = Instr_FD_O;
	 assign InstrD_R_I = Instr_FD_O;
	 assign Instr_DE_I = Instr_FD_O;
	 assign Instr_E_I = Instr_DE_O;
	 assign Instr_EM_I = Instr_DE_O;
	 assign Instr_M_I = Instr_EM_O;
	 assign Instr_MW_I = Instr_EM_O;
	 assign Instr_W_I = Instr_MW_O;
	 
	 assign PC_FD_I = PC_F_O;
	 assign PC_D_I = PC_MW_O;
	 assign PC_DE_I = PC_FD_O;
	 assign PC_EM_I = PC_DE_O;
	 assign PC_E_I = PC_DE_O;
	 assign PC_M_I = PC_EM_O;
	 assign PC_MW_I = PC_EM_O;
	 assign PC_W_I = PC_MW_O;
	 
	 assign RD1_DE_I = RD1_D_O;
	 assign RD1_E_I = RD1_DE_O;
	 assign RD2_DE_I = RD2_D_O;
	 assign RD2_E_I = RD2_DE_O;
	 assign Ext_DE_I = Ext_D_O;
	 assign Ext_E_I = Ext_DE_O;
	 
	 assign ALURS_EM_I = ALURS_E_O;
	 assign ALURS_M_I = ALURS_EM_O;
	 assign ALURS_MW_I = ALURS_EM_O;
	 assign ALURS_W_I = ALURS_MW_O;
	 
	 assign WD_EM_I = WD_E_O;
	 assign WD_M_I = WD_EM_O;
	 assign RD_MW_I = RD_M_O;
	 assign RD_W_I = RD_MW_O;
	 assign WD_D_I = WD_W_O;
	 
	 assign Dst_EM_I = Dst_E_O;
	 assign Dst_MW_I = Dst_EM_O;
	 assign WR_D_I = Dst_MW_O;
	 
	 assign TMF_D_I = ALURS_EM_O;
	 assign TMF_E_I = ALURS_EM_O;
	 assign TWF_E_I = WD_W_O;
	 assign TFW_M_I = WD_W_O;
	 
	 //ctrl wire assign
	 assign RFWr_D_I = RFWr_W_O;
	 assign NPCOp_F_I = NPCOp_D_O;
	 assign RA_F_I = RD1_D_O;
	 assign IMM_F_I = Instr_FD_O[25:0];
	 
	 //risk ctrl wire asign
	 assign RFWrE_R_I = RFWr_E_O;
	 assign RFWrM_R_I = RFWr_M_O;
	 assign RFWrW_R_I = RFWr_W_O;
	 assign DMWrM_R_I = DMWr_M_O;
	 assign Tuse_R_I = Tuse_D_O;
	 assign Tnew_DE_I = Tnew_D_O;
	 assign TE_R_I = Tnew_DE_O;
	 assign Tnew_EM_I = Tnew_DE_O;
	 assign TM_R_I = Tnew_EM_O;
	 assign Tnew_MW_I = Tnew_EM_O;
	 assign TW_R_I = Tnew_MW_O;
	 assign DstE_R_I = Dst_E_O;
	 assign DstM_R_I = Dst_EM_O;
	 assign DstW_R_I = Dst_MW_O;
	 assign RsD_R_I = Instr_FD_O[25:21];
	 assign RtD_R_I = Instr_FD_O[20:16];
	 assign RsE_R_I = Instr_DE_O[25:21];
	 assign RtE_R_I = Instr_DE_O[20:16];
	 assign PCE_F_I = PCEnD_R_O;
	 assign FDEn_FD_I = EnD_R_O;
	 assign Flush_DE_I = FlushE_R_O;
	 assign ForwardRs_D_I = ForwardRsD_R_O;
	 assign ForwardRt_D_I = ForwardRtD_R_O;
	 assign ForwardRsE_E_I = ForwardRsE_R_O;
	 assign ForwardRtE_E_I = ForwardRtE_R_O;
	 assign Forward_M_I = ForwardM_R_O;
	 assign stallE_R_I = Stall_E_O;
	 
	 Marco Marco (
    .PC_M(PC_EM_O), 
    .PC_E(PC_DE_O), 
    .PC_D(PC_FD_O), 
    .PC_F(PC_F_O), 
    .Exc_M(ExCode_M_O), 
    .Exc_E(ExCode_E_O), 
    .Exc_D(ExCode_D_O), 
    .Exc_F(ExCode_F_O), 
    .MacroPC(addr), 
    .MacroBD(MacroBD)
    );

	 Exctrl Exctrl (
    .InReq(IntReq), 
	 .EPC_I(EPC_I),
	 .eret_I(eret_M_O),
	 .ClrEXC_I(ClrEXC_F_O),
	 .EPC(EPC),
    .FlushFD(FlushFD), 
    .FlushDE(FlushDE), 
    .FlushEM(FlushEM), 
    .FlushMW(FlushMW),
	 .EXLSet(EXLSet),
	 .EXLClr(EXLClr),
	 .PCtoIn(PCtoIn),
	 .PCBack(PCBack)
    );

	 RiskCtrl RiskCtrl0 (
    .clk(clk), 
    .reset(reset), 
	 .Instr(InstrD_R_I),
	 .stallE_R_I(stallE_R_I),
    .RFWrE_R_I(RFWrE_R_I), 
    .RFWrM_R_I(RFWrM_R_I), 
    .RFWrW_R_I(RFWrW_R_I),
	 .DMWrM_R_I(DMWrM_R_I),
    .Tuse_R_I(Tuse_R_I), 
    .TE_R_I(TE_R_I), 
    .TM_R_I(TM_R_I), 
    .TW_R_I(TW_R_I), 
    .DstE_R_I(DstE_R_I), 
    .DstM_R_I(DstM_R_I), 
    .DstW_R_I(DstW_R_I), 
    .RsD_R_I(RsD_R_I), 
    .RtD_R_I(RtD_R_I), 
    .RsE_R_I(RsE_R_I), 
    .RtE_R_I(RtE_R_I), 
    .PCEnD_R_O(PCEnD_R_O), 
    .EnD_R_O(EnD_R_O), 
    .ForwardRsD_R_O(ForwardRsD_R_O), 
    .ForwardRtD_R_O(ForwardRtD_R_O), 
    .FlushE_R_O(FlushE_R_O), 
    .ForwardRtE_R_O(ForwardRtE_R_O), 
    .ForwardRsE_R_O(ForwardRsE_R_O),
	 .ForwardM_R_O(ForwardM_R_O)
    );
	 
	 F F0S (
    .clk_F(clk), 
    .reset_F(reset),
	 .EPC_F_I(EPC),
	 .PCtoIn(PCtoIn),
	 .PCBack(PCBack),
	 .mtEPC_D_I(mtEPC_D_O),
	 .mtEPC_E_I(mtEPC_E_O),
	 .mtEPC_M_I(mtEPC_M_O),
    .PCE_F(PCE_F_I), 
    .IMM_F(IMM_F_I), 
    .RA_F(RA_F_I), 
    .NpcOp_F(NPCOp_F_I), 
    .Instr_F(Instr_F_O), 
    .PC_F(PC_F_O),
	 .ExCode_F_O(ExCode_F_O),
	 .isBranch(isBranch)
    );
	 

	 FDReg FDReg0 (
    .clk(clk), 
    .reset(reset), 
    .FDEn_FD_I(FDEn_FD_I|FlushFD),
	 .eret(eret_M_O),
	 .EPC(EPC_I),
	 .ExCode_FD_I(ExCode_F_O),
	 .Flush_FD_I(FlushFD),	 
    .Instr_FD_I(Instr_FD_I), 
    .PC_FD_I(PC_FD_I), 
    .Instr_FD_O(Instr_FD_O), 
    .PC_FD_O(PC_FD_O),
	 .ExCode_FD_O(ExCode_FD_O)
    );

	 D D0 (
    .clk(clk), 
    .reset(reset), 
    .Instr(Instr_D_I), 
	 .ExCode_D_I(ExCode_FD_O),
    .PC_D_I(PC_D_I), 
    .WR_D_I(WR_D_I), 
    .WD_D_I(WD_D_I), 
	 .RFWr_D_I(RFWr_D_I),
    .ForwardRs_D_I(ForwardRs_D_I), 
    .ForwardRt_D_I(ForwardRt_D_I), 
    .EMF_D_I(TMF_D_I), 
    .NPCOp_D_O(NPCOp_D_O), 
    .Tuse_D_O(Tuse_D_O), 
    .Tnew_D_O(Tnew_D_O), 
    .RD1_D_O(RD1_D_O), 
    .RD2_D_O(RD2_D_O), 
    .Ext_D_O(Ext_D_O),
	 .ExCode_D_O(ExCode_D_O),
	 .mtEPC_D_O(mtEPC_D_O),
	 .isBranch(isBranch)
    );

	 DEReg DEReg0 (
    .clk(clk), 
    .reset(reset), 
	 .ExCode_DE_I(ExCode_D_O),
	 .eret(eret_M_O),
	 .EPC(EPC_I),
	 .Flush_DE_I(Flush_DE_I|FlushDE),
    .Instr_DE_I(Instr_DE_I), 
    .PC_DE_I(PC_DE_I), 
    .RD1_DE_I(RD1_DE_I), 
    .RD2_DE_I(RD2_DE_I), 
    .Tnew_DE_I(Tnew_DE_I), 
	 .Ext_DE_I(Ext_DE_I),
    .Instr_DE_O(Instr_DE_O), 
    .PC_DE_O(PC_DE_O), 
    .RD1_DE_O(RD1_DE_O), 
    .RD2_DE_O(RD2_DE_O), 
    .Tnew_DE_O(Tnew_DE_O),
	 .Ext_DE_O(Ext_DE_O),
	 .ExCode_DE_O(ExCode_DE_O)
    );
	 
	 
	 E E0 (
	 .clk(clk),
	 .reset(reset),
    .Instr(Instr_E_I), 
	 .InReq_E_I(IntReq),
	 .ExCode_E_I(ExCode_DE_O),
	 .PC_E_I(PC_E_I),
    .RD1_E_I(RD1_E_I), 
    .RD2_E_I(RD2_E_I), 
    .Ext_E_I(Ext_E_I), 
    .ForwardRsE_E_I(ForwardRsE_E_I), 
    .ForwardRtE_E_I(ForwardRtE_E_I), 
    .TMF_E_I(TMF_E_I), 
    .TWF_E_I(TWF_E_I), 
    .ALURS_E_O(ALURS_E_O), 
    .WD_E_O(WD_E_O), 
	 .RFWr_E_O(RFWr_E_O),
    .DstE_E_O(Dst_E_O),
	 .Stall_E_O(Stall_E_O),
	 .ExCode_E_O(ExCode_E_O),
	 .mtEPC_E_O(mtEPC_E_O),
	 .eret_E_I(eret_M_O)
    );
	 
	 EMReg EMReg0 (
    .clk(clk), 
    .reset(reset), 
	 .ExCode_EM_I(ExCode_E_O),
	 .eret(eret_M_O),
	 .EPC(EPC_I),
	 .Flush_EM_I(FlushDE),
    .Instr_EM_I(Instr_EM_I), 
    .PC_EM_I(PC_EM_I), 
    .ALURS_EM_I(ALURS_EM_I), 
    .WD_EM_I(WD_EM_I), 
    .Dst_EM_I(Dst_EM_I), 
    .Tnew_EM_I(Tnew_EM_I), 
    .Instr_EM_O(Instr_EM_O), 
    .PC_EM_O(PC_EM_O), 
    .ALURS_EM_O(ALURS_EM_O), 
    .WD_EM_O(WD_EM_O), 
    .Dst_EM_O(Dst_EM_O), 
    .Tnew_EM_O(Tnew_EM_O),
	 .ExCode_EM_O(ExCode_EM_O)
    );
	 
	 M M0 (
    .clk(clk), 
    .reset(reset),
	 .PrRD_M_I(PrRD),
	 .PrWD_M_O(PrWD),
	 .MacroPC(addr),
	 .PrAddr_M_O(PrAddr),
    .Instr(Instr_M_I),
	 .MacroBD(MacroBD),
    .ExCode_M_I(ExCode_EM_O),
	 .HWInt(HWInt),
	 .EXLSet(EXLSet),
	 .EXLClr(EXLClr),
    .PC(PC_M_I), 
    .ALURS_M_I(ALURS_M_I), 
    .WD_M_I(WD_M_I), 
    .Forward_M_I(Forward_M_I), 
    .TFW_M_I(TFW_M_I), 
	 .RFWr_M_O(RFWr_M_O),
	 .DMWr_M_O(DMWr_M_O),
    .RD_M_O(RD_M_O),
	 .IntReq_M_O(IntReq),
	 .EPC_M_O(EPC_I),
	 .mtEPC_M_O(mtEPC_M_O),
	 .eret_M_O(eret_M_O),
	 .ExCode_M_O(ExCode_M_O)
    );
	
	 MWReg MWReg0(
    .clk(clk), 
    .reset(reset), 
	 .Flush_MW_I(FlushMW),
    .Instr_MW_I(Instr_MW_I), 
    .PC_MW_I(PC_MW_I), 
    .Dst_MW_I(Dst_MW_I), 
    .RD_MW_I(RD_MW_I), 
    .ALURS_MW_I(ALURS_MW_I), 
	 .Tnew_MW_I(Tnew_MW_I),
	 .WD_MW_I(WD_EM_O),
    .Instr_MW_O(Instr_MW_O), 
    .PC_MW_O(PC_MW_O), 
    .Dst_MW_O(Dst_MW_O), 
    .RD_MW_O(RD_MW_O), 
    .ALURS_MW_O(ALURS_MW_O),
	 .Tnew_MW_O(Tnew_MW_O),
	 .WD_MW_O(WD_MW_O)
    );
    
	 W W0 (
    .Instr(Instr_W_I), 
    .PC_W_I(PC_W_I), 
    .RD_W_I(RD_W_I), 
    .ALURS_W_I(ALURS_W_I),
	 .WD_W_I(WD_MW_O),
    .WD_W_O(WD_W_O), 
    .RFWr_W_O(RFWr_W_O)
    );
	 
endmodule
