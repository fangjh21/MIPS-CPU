`timescale 1ns / 1ps
module compare(
	 input signed [31:0] a,
	 input signed [31:0] b,
	 output reg [1:0] res
    );
	 always @(*)
		if(a == b) res = 2'b01;
		else if(a < b) res = 2'b00;
		else if(a > b) res = 2'b10;
endmodule
