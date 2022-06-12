`timescale 1ns / 1ps
module hazard(
	 input [4:0] Rs_ID,
	 input [4:0] Rt_ID, 
	 input [4:0] RegWtaddr_EX,
	 input [4:0] RegWtaddr_MEM,
	 input isBranch,
	 input DMemRead_EX,
	 input DMemRead_MEM,
	 output PCEn,
	 output IF_ID_En,
	 output ID_EX_Flush
    );
	assign ID_EX_Flush =isBranch?((RegWtaddr_EX == Rs_ID && Rs_ID!=0) || (RegWtaddr_EX == Rt_ID && Rt_ID!=0 )) ||(DMemRead_MEM &&((RegWtaddr_MEM == Rs_ID && Rs_ID!=0) || (RegWtaddr_MEM == Rt_ID && Rt_ID!=0))) :((RegWtaddr_EX == Rs_ID) || (RegWtaddr_EX == Rt_ID)) && DMemRead_EX;//
	assign IF_ID_En = ~ID_EX_Flush;//
	assign PCEn = ~ID_EX_Flush;//

endmodule


