`timescale 1ns / 1ps
module mips(
    input clk,
    input reset,
    input interrupt,
    output [31:0] addr
    );
	 
	 //Timer1
	 wire [31:0] Dout1;
	 
	 //Timer2
	 wire [31:0] Dout2;
	 
	 //Bridge
	 wire [7:2] HWInt;
	 wire [31:0] PrWD;
	 wire [31:2] PrAddr;
	 wire [31:0] PrRD;
	 
	 cpu cpu (
    .clk(clk), 
    .reset(reset), 
    .PrRD(PrRD), 
    .HWInt(HWInt), 
	 .addr(addr),
	 .PrAddr(PrAddr),  
    .PrWD(PrWD), 
    .PrWe(PrWe)
    );

	 
	 Bridge Bridge (
	 .interrupt(interrupt),
	 .IRQ1(IRQ1),
	 .IRQ2(IRQ2),
	 .We1(We1),
	 .We2(We2),
	 .PrRD1(Dout1),
	 .PrRD2(Dout2),
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
    .PrWe(PrWe), 
    .HWInt(HWInt),
	 .PrRD(PrRD)
    );
	 
	 TC TC1 (
    .clk(clk), 
    .reset(reset),
    .Addr(PrAddr), 
    .WE(We1), 
    .Din(PrWD), 
    .Dout(Dout1), 
    .IRQ(IRQ1)
    );
	 
	 TC TC2 (
    .clk(clk), 
    .reset(reset), 
    .Addr(PrAddr), 
    .WE(We2), 
    .Din(PrWD), 
    .Dout(Dout2), 
    .IRQ(IRQ2)
    );
	 
endmodule
