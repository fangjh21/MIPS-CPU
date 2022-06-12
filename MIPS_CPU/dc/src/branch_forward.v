module branch_forward (//for branch alu jump judgement at EX stage
    input isBranch,
    input RegWrite_WB,
    input RegWrite_MEM,
    input [4:0] RegRdaddr1_ID,
	input [4:0] RegRdaddr2_ID,
    input [4:0] RegWtaddr_MEM,
	input [4:0] RegWtaddr_WB,
    output [1:0] RegRdout2Sel_Forward_ID,
	output [1:0] RegRdout1Sel_Forward_ID
);

assign 	RegRdout1Sel_Forward_ID[0] =isBranch? RegWrite_WB && (RegWtaddr_WB != 0) && (RegWtaddr_MEM != RegRdaddr1_ID) && (RegWtaddr_WB == RegRdaddr1_ID):0;
assign 	RegRdout1Sel_Forward_ID[1] =isBranch? RegWrite_MEM && (RegWtaddr_MEM != 0) && (RegWtaddr_MEM == RegRdaddr1_ID):0;
assign	RegRdout2Sel_Forward_ID[0] =isBranch? RegWrite_WB && (RegWtaddr_WB != 0) && (RegWtaddr_MEM != RegRdaddr2_ID) && (RegWtaddr_WB == RegRdaddr2_ID):0;
assign	RegRdout2Sel_Forward_ID[1] = isBranch? RegWrite_MEM && (RegWtaddr_MEM != 0) && (RegWtaddr_MEM == RegRdaddr2_ID):0;	 
endmodule