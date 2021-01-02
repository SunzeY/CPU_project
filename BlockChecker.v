`timescale 1ns / 1ps

module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );
	 reg [3:0] b;
	 reg [3:0] e;
	 reg [31:0] match;
	 reg wrong;
	 reg k;
	assign result = (match == 0)&(~wrong);

	initial begin
		k <= 0;
		wrong <= 0;
		b <= 0;
		e <= 0;
		match <= 0;
	end
	
	always@(posedge clk or posedge reset)begin
		if(reset == 1)begin
		   k <= 0;
			wrong <= 0;
			b <= 0;
			e <= 0;
			match <= 0;
		end
		else if(k == 0)begin
			case(b)
				0: b <= (in==" ")? 1:0;
				1: b <= (in=="b"||in=="B")? 2:(in==" ")? 1:0;
				2: b <= (in=="e"||in=="E")? 3:(in==" ")? 1:0;
				3: b <= (in=="g"||in=="G")? 4:(in==" ")? 1:0;
				4: b <= (in=="i"||in=="I")? 5:(in==" ")? 1:0;
				5: if(in=="n"||in=="N")begin match <= match + 1; b <= 6;end
					else b <= (in==" ")? 1:0;
				6: if(in!=" ")begin match <= match - 1; b <= 0;end
					else b <= 1;
			endcase
			case(e)
				0: e <= (in==" ")? 1:0;
				1: e <= (in=="e"||in=="E")? 2:(in==" ")? 1:0;
				2: e <= (in=="n"||in=="N")? 3:(in==" ")? 1:0;
				3: if(in=="d"||in=="D")begin 
						match <= match - 1; 
						if(match == 0)wrong <= 1;
						e <= 4;
					end
					else e <= (in==" ")? 1:0;
				4: if(in!=" ")begin match = match + 1; if(match == 0)wrong <= 0; e <= 0;end
					else begin e <= 1; if(wrong==1)k <= 1; end
			endcase
		end
	end
endmodule
