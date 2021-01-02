`timescale 1ns / 1ps
module test;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	tim uut (
		.clk(clk), 
		.reset(reset), 
		.in(in), 
		.out(out)
	);
   reg [0£º1023] flo = "2020.11.10";
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		in = 0;
	#5;
	while(flow[0:7]==0)begin
		flow = flow << 8;
	end
	while(flow[0:7]!="@")begin
		#10 in = flow;
		flow = flow << 8;
	end
   end
	always #5 clk = ~clk;
endmodule

