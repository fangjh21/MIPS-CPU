`timescale 1ns / 1ps
module Registers(
	input	clk,
	input rst_n,
	input [4:0] rAddr1,//
	output [31:0] rDout1,//
	input [4:0] rAddr2,//
	output [31:0] rDout2,//
	input [4:0] wAddr,//
	input [31:0] wDin,//
	input wEna//
	
);
	reg [31:0] data [0:31];
	integer i;
	assign rDout1=data[rAddr1];//
	assign rDout2=data[rAddr2];//
	always@(posedge clk or negedge rst_n)//
		if(~rst_n)
		begin
			for(i=0; i<32; i=i+1) data[i]<=0;
		end
		else
		begin
			if(wEna)
				data[wAddr]<=wDin;
		end
endmodule
