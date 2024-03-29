`timescale 1ns / 1ps

module IM(Iaddr, Instr);
   input [31:0] Iaddr;
	output [31:0] Instr;
	
	
	reg [31:0] im_reg [0:4095];
	initial begin: init_instr
		reg[13:0] tempi;
				for(tempi=0;tempi<4096;tempi=tempi+1)
					im_reg[tempi] = 0;
		$readmemh("code.txt", im_reg);
		$readmemh("code_handler.txt", im_reg, 1120, 2047); 
	end
	assign Instr = im_reg[Iaddr[15:2] - 14'hc00];
	
endmodule
