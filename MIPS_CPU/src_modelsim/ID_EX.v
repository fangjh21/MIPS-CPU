`timescale 1ns / 1ps
module IDEX(
    input clk,
	 input en,
	 input flush,//flush for stall or start
	 input [31:0] PCPlus_in,
    input [31:0] RegRdout1_in,
	 input [31:0] RegRdout2_in,
	 input [31:0] IMMSignExtended_in,
	 input [31:0] IMMZeroExtended_in,
	 input [31:0] ShamtZeroExtended_in,
	 input [4:0] Rs_in,
	 input [4:0] Rt_in,
	 input [4:0] RegWtaddr_in,
	 output [31:0] PCPlus_out,
    output [31:0] RegRdout1_out,
	 output [31:0] RegRdout2_out,
	 output [31:0] IMMSignExtended_out,
	 output [31:0] IMMZeroExtended_out,
	 output [31:0] ShamtZeroExtended_out,
	 output [4:0] Rs_out,
	 output [4:0] Rt_out,
	 output [4:0] RegWtaddr_out,
	 //control
	 input [1:0] RegDst_in,
	 input ALUSrcASel_in,
	 input [1:0] ALUSrcBSel_in, 
	 input [4:0] ALUControl_in,
	 input DMemRead_in,
	 input DMemWrite_in,
	 input DMemtoReg_in,
	 input RegWrite_in,
	 output [1:0]RegDst_out,
	 output ALUSrcASel_out,
	 output [1:0] ALUSrcBSel_out, 
	 output [4:0] ALUControl_out,
	 output DMemRead_out,
	 output DMemWrite_out,
	 output DMemtoReg_out,
	 output RegWrite_out
    );
	 
	 dff dff1(clk,en,flush,PCPlus_in,PCPlus_out);
	 dff dff2(clk,en,flush,RegRdout1_in,RegRdout1_out);
	 dff dff3(clk,en,flush,RegRdout2_in,RegRdout2_out);
	 dff dff4(clk,en,flush,IMMSignExtended_in,IMMSignExtended_out);
	 dff dff5(clk,en,flush,IMMZeroExtended_in,IMMZeroExtended_out);
	 dff dff6(clk,en,flush,ShamtZeroExtended_in,ShamtZeroExtended_out);
	 dff #(5) dff7(clk,en,flush,Rs_in,Rs_out);
	 dff #(5) dff8(clk,en,flush,Rt_in,Rt_out);
	 dff #(5) dff9(clk,en,flush,RegWtaddr_in,RegWtaddr_out);
	 dff #(2) dff10(clk,en,flush,ALUSrcBSel_in,ALUSrcBSel_out);	 
	 dff #(5) dff11(clk,en,flush,ALUControl_in,ALUControl_out);
	
	 dff #(2) dff20(clk,en,flush,RegDst_in,RegDst_out);
	 dff #(1) dff21(clk,en,flush,DMemWrite_in,DMemWrite_out);
	 dff #(1) dff22(clk,en,flush,DMemtoReg_in,DMemtoReg_out);
	 dff #(1) dff23(clk,en,flush,RegWrite_in,RegWrite_out);	 
	 dff #(1) dff24(clk,en,flush,ALUSrcASel_in,ALUSrcASel_out);
	 dff #(1) dff25(clk,en,flush,DMemRead_in,DMemRead_out);
endmodule
