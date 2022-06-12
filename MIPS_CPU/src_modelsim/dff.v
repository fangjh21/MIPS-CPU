`timescale 1ns / 1ps
module dff #(parameter WIDTH = 32) ( //Data Flip-Flop 
    input clk,
	 input en,
	 input rst,
    input [WIDTH-1:0] datain,
    output reg [WIDTH-1:0] dataout
    );
	always@(posedge clk)
	begin
		if(rst)
			dataout <= 0;
		else if(en)
			dataout <= datain;
		else dataout<=dataout;
	end
endmodule
