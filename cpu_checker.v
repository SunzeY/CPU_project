`timescale 1ns / 1ps
`define S0 5'b00001
`define S1 5'b00010
`define S2 5'b00011
`define S3 5'b00100
`define S4 5'b00101
`define S5 5'b00110
`define S6 5'b00111
`define S7 5'b01000
`define S8 5'b01001
`define S9 5'b01010
`define S10 5'b01011
`define S11 5'b01100
`define S12 5'b01101
`define S13 5'b01110
`define S14 5'b01111
`define S15 5'b10000
`define S16 5'b10001
`define S17 5'b10010
`define S18 5'b10011
`define S19 5'b10100
`define dec 47<char&&char<58
`define hex ((47<char&&char<58)||(96<char&&char<103))
module cpu_checker(
    input clk,
    input reset,
    input [7:0] char,
    output [1:0] format_type
	 /*output reg [15:0] tim,
	 output reg [15:0] fre,
	 output reg [31:0] pc,
	 output reg [31:0] addr,
	 output reg [4:0] grf,
	 output reg [4:0] S*/
    );
	 reg [4:0] S;
	 reg [3:0] cnt;
	 wire timex;
	 wire pcex;
	 wire addrex;
	 wire grfex;
	 reg [3:0] error;
	 assign format_type = (S == `S11)? 1:
								 (S == `S18)? 2:
												  0;
		assign timex = o;
		assign grfex = (|grf[15:5]);
		assign error_code = error;
		assign pcex = ~(32'h00003000<=pc)||~(pc<=32'h00004fff)||(|pc[1:0]);
		assign addrex = ~(32'h00000000<=addr)||~(addr<=32'h00002fff)||(|addr[1:0]);
    initial begin
        S <= `S0;
        cnt <= 0;
		  tim <= 0;
		  fre = freq;
		  pc <= 0;
		  addr <= 0;
		  grf <= 0;
		  o <= 0;
		  error <= 0;
    end
    always@(posedge clk)begin
		if (reset == 1) S <=`S0;
	else begin
        if(S == `S0)begin
			  cnt <= 0;
			  tim <= 0;
			  fre <= freq;
			  pc <= 0;
			  addr <= 0;
			  grf <= 0;
			  o <= 0;
			  error <= 0;
           if(char == "^") S <= `S1;
           else S <= `S0;
    end
        else if(S == `S1)begin
				  cnt <= 0;
				  tim <= 0;
				  fre <= freq;
				  pc <= 0;
				  addr <= 0;
				  grf <= 0;
				  o <= 0;
				  error <= 0;
            if(`dec) begin tim <= (tim<<3)+(tim<<1)+(char-48); cnt<= cnt+1;end
            else if(char == "@"& 0<cnt & cnt<=4) begin S <= `S2; cnt <= 0;end
				else if(char == "^") S <= `S1;
				else begin S <= `S0; cnt <= 0;end
	 end
        else if(S == `S2)begin
            if(`hex) begin cnt <= cnt+1; pc <= pc<<4 + (char>58? char-87:char-48);end
            else if(cnt==8 & char == ":") begin S <= `S3; cnt <= 0; end
				else if(char == "^") S <= `S1;
            else begin S <= `S0; cnt <= 0; end
    end
        else if(S == `S3)begin
            if(char==" ") S <= `S3;
            else if(char =="$") S <= `S4;
            else if(char =="*") S <= `S12;
				else if(char == "^") S <= `S1;
            else S <= `S0;
    end
        else if(S == `S4)begin
            if(`dec) begin S <= `S5; grf <= (grf<<3)+(grf<<1)+(char-48); cnt <= cnt+1;end
				else if(char == "^") S <= `S1;
            else begin S <= `S0; cnt <= 0;end
    end
        else if(S == `S5)begin
            if(`dec) begin S <= `S5; grf <= (grf<<3)+(grf<<1)+(char-48); cnt <= cnt+1;end
            else if(0<cnt & cnt<5 & char == "<") begin S <= `S7; cnt <= 0;end
            else if(0<cnt & cnt<5 & char == " ") begin S <= `S6; cnt <= 0;end
				else if(char == "^") S <= `S1;
            else begin S <= `S0; cnt <= 0;end
    end
        else if(S == `S6)begin
            if(char == " ") S <= `S6;
            else if(char == "<") S <= `S7;
				else if(char == "^") S <= `S1;
            else S <= `S0;
    end
        else if(S == `S7)begin
            if(char == "=") S <= `S8;
				else if(char == "^") S <= `S1;
            else S <= `S0;
    end
        else if(S == `S8)begin
				if(char == " ") S <= `S8;
				else if(char == "^") S <= `S1;
            else if(`hex) begin S <= `S9; cnt <= cnt + 1;end
            else begin S <= `S0; cnt <= 0;end
    end
        else if(S == `S9)begin
            if(`hex) cnt = cnt + 1;
				else if(cnt==8&&char=="#")begin  S = `S11;cnt <= 0;end
				else if(char == "^") S <= `S1;
            else begin S <= `S0; cnt <= 0;end
    end
        else if(S == `S11)begin
				fre <= fre>>1;
				while(fre!=1)begin
					fre <= fre >>1;
					o <= o|tim [0]; 
					tim <= tim >>1;
				error[0]<=timex;
				error[1]<=pcex;
				error[3]<=grfex;
				end
				
				if(char == "^") S <= `S1;
				else S <= `S0;
    end
        else if(S == `S12)begin
            if(`hex) begin S <= `S13; addr <= addr<<4 + (char>58? char-87:char-48);cnt <= cnt + 1;end
				else if(char == "^") S <= `S1;
            else begin S <= `S0; cnt <= 0;end
    end
        else if(S == `S13)begin
            if(`hex) begin addr <= addr<<4+(char>58? char-87:char-48);cnt <=cnt+1;if (cnt == 8) begin S <= `S14; cnt <=0;end end
				else if(char == "^") S <= `S1;
            else begin S <= `S0; cnt <= 0; end
    end
        else if(S == `S14)begin
            if(char == " ") S <= `S14;
            else if(char == "<") S <= `S15;
				else if(char == "^") S <= `S1;
            else S <= `S0;
    end
        else if(S == `S15)begin
            if(char == "=") S <= `S16;
				else if(char == "^") S <= `S1;
            else S <= `S0;
    end
        else if(S == `S16)begin
				if(char == " ")S <=`S16;
            else if(`hex) begin S <= `S17; cnt <= cnt + 1;end
				else if(char == "^") S <= `S1;
            else begin S <= `S0; cnt <= 0;end
    end
        else if(S == `S17)begin
            if(`hex) cnt <= cnt + 1;
            else if(cnt == 8&&char == "#") begin S <= `S18; cnt <=0;end
				else if(char == "^") S <= `S1;
				else begin S <= `S0; cnt <= 0;end
    end
        else if(S == `S18)begin
				fre <= fre>>1;
				while(fre!=1)begin
					fre <= fre >>1;
					o <= o|tim [0]; 
					tim <= tim >>1;
				end
				error[0]<=timex;
				error[1]<=pcex;
				error[2]<=addrex;
            if(char=="^")S <= `S1;
				else S <= `S0;
				
    end
	end
end
endmodule
