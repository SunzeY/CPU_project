`timescale 1ns / 1ps
`include "head.v"
module DM(clk, reset, Instr, pc, scr, addr, din, dout);
   input clk;
   input reset;
	input [31:0] Instr; 
	input [31:0] pc;
   input scr;
   input [31:0] addr;
   input [31:0] din;
   output [31:0] dout;
	
	reg [31:0] data_memory [0:1023];

	assign dout = data_memory[addr[11:2]];
	
	initial begin: init_mem
		reg[10:0] tempi;
			for(tempi=0;tempi<1024;tempi=tempi+1)
				data_memory[tempi] <= 0;
	end
	
	always @(posedge clk) begin
		if(reset) begin: clr_mem
			reg[11:0] tempi;
				for(tempi=0;tempi<1024;tempi=tempi+1)
					data_memory[tempi] <= 0;
		end
		
		else if(scr) begin
			data_memory[addr[11:2]] <= din;
			$display("%d@%h: *%h <= %h", $time, pc, {20'b0, addr[11:2], 2'b0}, din);
		end
	end

endmodule
