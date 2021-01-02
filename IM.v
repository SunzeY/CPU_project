`timescale 1ns / 1ps

module IM(Iaddr, Instr);
   input [31:0] Iaddr;
	output [31:0] Instr;
	
	
	reg [31:0] im_reg [0:1023];
	
	initial begin: init_IM
		reg[10:0] tempi;
			for(tempi=0;tempi<1024;tempi=tempi+1)
				im_reg[tempi]= 0;
		$readmemh("code.txt", im_reg);
	end
	
	assign Instr = im_reg[Iaddr[15:2] - 14'hc00];
	
endmodule
