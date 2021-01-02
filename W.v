`timescale 1ns / 1ps
module W(
    input [31:0] Instr,
    input [31:0] PC_W_I,
	 input [31:0] RD_W_I,
	 input [31:0] ALURS_W_I,
	 input [31:0] WD_W_I,
	 input [4:0] Dst_W_I,
    output [31:0] WD_W_O,
	 output RFWr_W_O,
	 output [4:0] Dst_W_O
    );
	 wire [1:0] Mem_type;
	 wire [1:0] WDSel;
	 wire [31:0] Dout;
	 wire Load_type;
	 
	 assign Dst_W_O = Dst_W_I;
	 
	 assign WD_W_O = (WDSel==2'b00)? ALURS_W_I:
	                 (WDSel==2'b01)? Dout:
						  (WDSel==2'b10)? PC_W_I + 8 : 32'h0000_3000;
						  
	 Controller Controller_W (
    .Instr(Instr),
    .WDSel(WDSel), 
    .RFWr(RFWr_W_O), 
    .Mem_type(Mem_type),
	 .Load_type(Load_type)
    );
	 
	 LTC LTC_W (
    .addr(ALURS_W_I), 
    .Din(RD_W_I), 
	 .RD(WD_W_I),
    .M_type(Mem_type), 
	 .Load_type(Load_type),
    .Dout(Dout)
    );
	 
endmodule
