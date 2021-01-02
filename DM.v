`timescale 1ns / 1ps

module DM(clk, reset, pc, scr, M_type, addr, din, dout);
   input clk;
   input reset;
	input [31:0] pc;
   input scr;
	input [1:0] M_type;
   input [31:0] addr;
   input [31:0] din;
   output [31:0] dout;
	
	reg [31:0] data_memory [0:4095];

	wire [3:0] BE;
	//mask_signal
	assign BE[0] = (~addr[0])&&(~addr[1])&&(M_type==2'b01)||(~addr[1])&&(M_type==2'b10)||(M_type==2'b11);
	assign BE[1] =   addr[0] &&(~addr[1])&&(M_type==2'b01)||(~addr[1])&&(M_type==2'b10)||(M_type==2'b11);
	assign BE[2] = (~addr[0])&&  addr[1] &&(M_type==2'b01)||( addr[1])&&(M_type==2'b10)||(M_type==2'b11);
	assign BE[3] =   addr[0] &&  addr[1] &&(M_type==2'b01)||( addr[1])&&(M_type==2'b10)||(M_type==2'b11);
	
	assign dout = data_memory[addr[13:2]];
	
	wire [7:0] byte1;
	wire [7:0] byte2;
	wire [7:0] byte3;
	wire [7:0] byte4;
	
	assign byte1 = (BE==4'b0001||BE==4'b0011||BE==4'b1111)? din[7:0] : dout[7:0];
	
	assign byte2 = (BE==4'b0010)? din[7:0] :
					   (BE==4'b0011)? din[15:8]:
						(BE==4'b1111)? din[15:8]: dout[15:8];
						
	assign byte3 = (BE==4'b0100||BE==4'b1100)? din[7:0]:
						(BE==4'b1111)? din[23:16] : dout[23:16];
						
	assign byte4 = (BE==4'b1000)? din[7:0] :
				      (BE==4'b1100)? din[15:8]:
						(BE==4'b1111)? din[31:24]: dout[31:24];
	
	initial begin: init_mem
		reg[12:0] tempi;
			for(tempi=0;tempi<4096;tempi=tempi+1)
				data_memory[tempi] = 0;
	end
	
	always @(posedge clk) begin
		if(reset) begin: clr_mem
			reg[12:0] tempi;
				for(tempi=0;tempi<4096;tempi=tempi+1)
					data_memory[tempi] = 0;
		end
		
		else if(scr) begin
			data_memory[addr[13:2]] <= {byte4, byte3, byte2, byte1};
			$display("%d@%h: *%h <= %h", $time, pc, {18'b0, addr[13:2], 2'b0}, {byte4, byte3, byte2, byte1});
		end
	end

endmodule
