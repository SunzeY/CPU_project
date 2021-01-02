`timescale 1ns / 1ps
`define number (47<in && in<58)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:48:49 10/25/2020 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
	reg [2:0] S;
	assign out = S == 1;
	
	initial begin
		S <= 0;
	end
	
	always@(posedge clk or posedge clr)begin
		if(clr==1) S<=0;
		else begin
			case(S)
				0: S <= `number? 1:3;
				1: S <= `number? 3:2;
				2: S <= `number? 1:3;
				3: S <= 3;
			endcase
		end
	end
endmodule