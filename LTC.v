`timescale 1ns / 1ps
module LTC(
	 input [31:0] addr,
    input [31:0] Din,
    input [1:0] M_type,
    output reg [31:0] Dout
    );
	 
	 always @(*)begin
		if((~addr[0])&&(~addr[1]))begin
			Dout = (M_type==2'b01) ? {{24{Din[7]}}, Din[7:0]}:
					 (M_type==2'b10) ? {{16{Din[15]}}, Din[15:0]}:
					 (M_type==2'b11) ? Din[31:0]:0;
		end
		else if((addr[0])&&(~addr[1]))begin
			Dout = (M_type==2'b01) ? {{24{Din[15]}}, Din[15:8]}:0;
		end
		else if((~addr[0])&&(addr[1]))begin
			Dout = (M_type==2'b01) ? {{24{Din[23]}}, Din[23:16]}:
					 (M_type==2'b10) ? {{16{Din[31]}}, Din[31:16]}:0;
		end
		else if((addr[0])&&(addr[1]))begin
			Dout = (M_type==2'b01) ? {{24{Din[31]}}, Din[31:24]}:0;
		end
	 end
	 
endmodule
