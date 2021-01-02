`timescale 1ns / 1ps

`define Timer1 (32'h0000_7f00<=addr && addr<=32'h0000_7f0b)
`define Timer2 (32'h0000_7f10<=addr && addr<=32'h0000_7f1b)
`define DMad   (0<=addr && addr<=32'h0000_2ffff)

module Bridge(
    input [31:2] PrAddr,
    input [31:0] PrWD,
	 input PrWe,
	 input interrupt,
	 input IRQ1,
	 input IRQ2,
	 output We1,
	 output We2,
    output [7:2] HWInt,
	 input [31:0] PrRD1,
	 input [31:0] PrRD2, 
    output [31:0] PrRD
    );
	 
	 wire [31:0] addr;
	 
	 assign addr = {PrAddr, 2'b0};
	 
	 assign HWInt = {1'b0, 1'b0, 1'b0, interrupt, IRQ2, IRQ1};
	 
	 assign PrRD = `Timer1 ? PrRD1 :
						`Timer2 ? PrRD2 : 0;
						
	 assign We1 = (`Timer1 && PrWe) ? 1 : 0;
	 assign We2 = (`Timer2 && PrWe) ? 1 : 0;
						

endmodule
