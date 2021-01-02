`timescale 1ns / 1ps
module Exctrl(
    input InReq,
	 input eret_I,
	 input [31:0] EPC_I,
	 input ClrEXC_I,
    output FlushFD,
    output FlushDE,
    output FlushEM,
    output FlushMW,
	 output [31:0] EPC,
	 output EXLClr,
	 output EXLSet,
	 output PCtoIn,
	 output PCBack
    );
	 
	 assign FlushFD = InReq|eret_I;
	 assign FlushDE = InReq|eret_I;
	 assign FlushEM = InReq|eret_I;
	 assign FlushMW = InReq|eret_I;
	 assign PCtoIn =  InReq;
	 assign PCBack = eret_I;
	 assign EPC = EPC_I;
	 assign EXLClr = eret_I;
	 assign EXLSet = InReq;
	 
endmodule
