`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:40 10/29/2020 
// Design Name: 
// Module Name:    fourcom 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fourcom(
    input [3:0] a,
    input [3:0] b,
    output reg [1:0] out
    );
	 always@(*) begin
		if(a[3]^b[3])begin
			if(a[3] == 1) out = 1;
			else out = 0;
		end
		else if(a[2]^b[2])begin
			if(a[2] == 1) out = 1;
			else out = 0;
		end
		else if(a[1]^b[1])begin
			if(a[1] == 1) out = 1;
			else out = 0;
		end
		else if(a[0]^b[0])begin
			if(a[0] == 1) out = 1;
			else out = 0;
		end
		else out = 2;
	 end
endmodule
