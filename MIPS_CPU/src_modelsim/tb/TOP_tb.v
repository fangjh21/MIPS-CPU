`timescale 1ns / 1ps
module test;
// Inputs
reg clk;
reg rst;
wire [31:0] IMemout;
wire [31:0] DMemout_MEM;
wire [31:0] IMemaddr;
wire DMemWrite_MEM;
wire [31:0] DMemaddr_MEM;
wire [31:0] DMemin_MEM;

top uut (
	.clk(clk), 
	.rst(rst),
	.IMemout(IMemout),
	.DMemout_MEM(DMemout_MEM),
	.IMemaddr(IMemaddr),
	.DMemWrite_MEM(DMemWrite_MEM),
	.DMemaddr_MEM(DMemaddr_MEM),
	.DMemin_MEM(DMemin_MEM)
	);	
icache icache(IMemaddr[8:0],clk,IMemout);
dcache dcache(clk,!rst,DMemWrite_MEM,1'b1,DMemaddr_MEM,DMemin_MEM,DMemout_MEM);



//always #10 clk=~clk;
initial begin
	// Initialize Inputs
	clk = 1;
	rst = 0;
	#100;
	rst = 1;
	#100;
	clk=~clk;
	#10;
	clk=~clk;
	rst = 0;
	
	forever begin
		#5;
		clk=~clk;
	end
end
initial begin
	#1600000 $stop;
end   
endmodule

