`timescale 1ns / 1ps
`define A_NOP 5'd00 //nop
`define A_ADD 5'd01 //signed_add
`define A_SUB 5'd02 //signed_sub
`define A_AND 5'd03 //and
`define A_OR  5'd04 //or
`define A_XOR 5'd05 //xor
`define A_NOR 5'd06 //nor
`define A_ADDU 5'd07 //unsigned_add
`define A_SUBU 5'd08 //unsigned_sub
`define A_SLT 5'd09 //slt
`define A_SLTU 5'd10 //unsigned_slt
`define A_SLL 5'd11 //sll
`define A_SRL 5'd12 //srl
`define A_SRA 5'd13 //sra
`define A_MOV 5'd14 //movz,movn
`define A_LUI 5'd15 //lui
`define LESS 2'b00
`define EQUAL 2'b01
`define GREATER 2'b10
module control(
	input clk,rst,
	input [5:0] Op, //instr[31:26]
	input [4:0] Rt, //instr[20:16]

	input [5:0] Funct,//instr[5:0]
	input [1:0] RsCMPRt,
	input [1:0] RsCMPZero,
	output reg [1:0] PCSrc, //0:+4,1:Branch,2:J,3:JR
	output reg isBranch,
	//ID
	output reg[1:0] RegDst,//0:RegWtaddr=rt,1:RegWtaddr=rd
	//EX
	output reg ALUSrcASel,//0:RegRdout1,1:ShamtZeroExtended
	output reg [1:0] ALUSrcBSel, //0:RegRdout2,1:IMMSignExtended,2:IMMZeroExtended
	output reg [4:0] ALUControl,
	//MEM
	output reg DMemRead,//1:En
	output reg DMemWrite,//1:En
	//WB
	output reg DMemtoReg,//0:Aluout,1:DMemout
	output reg RegWrite//1:En
    );

	reg [1:0] tmpsrc;

	always @(*)
	begin
	if(rst) 
		begin
			isBranch=0;
			{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_00_0_00},{`A_NOP},{4'b0001}};
		end
	else
		//case(nstate)
			//4'd0://normal 
				case(Op)
					6'b000000: //R-Type
					begin
					    isBranch=0;
						case(Funct)
							//
							6'b000000: //SLL
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_1_00},{`A_SLL},{4'b0001}};
							//6'b000001: //MOVCI
							6'b000010: //SRL
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_1_00},{`A_SRL},{4'b0001}};
							6'b000011: //SRA
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_1_00},{`A_SRA},{4'b0001}};
							6'b000100: //SLLV
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_SLL},{4'b0001}};
							//6'b000101: //*
							6'b000110: //SRLV
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_SRL},{4'b0001}};
							6'b000111: //SRAV
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_SRA},{4'b0001}};
							6'b001000: //JR
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b11_11_0_00},{`A_NOP},{4'b0000}};
							//6'b001001: //JALR
							
							6'b001010: //MOVZ
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_MOV},{3'b000},{RsCMPZero[0]}};
							6'b001011: //MOVN
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_MOV},{3'b000},{~RsCMPZero[0]}};
							//6'b001100: //SYSCALL
							//6'b001101: //BREAK
							//6'b001110: //*
							//6'b001111: //SYNC
							//6'b010000: //MFHI
							//6'b010001: //MTHI
							//6'b010010: //MFLO
							//6'b010011: //MTLO
							//6'b010100: //DSLLV
							//6'b010101: //*
							//6'b010110: //DSRLV
							//6'b010111: //DSRAV
							//6'b011000: //MULT
							//6'b011001: //MULTU
							//6'b011010: //DIV
							//6'b011011: //DIVU
							//6'b011100: //DMULT
							//6'b011101: //DMULTU
							//6'b011110: //DDIV
							//6'b011111: //DDIVU
							6'b100000: //ADD
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_ADD},{4'b0001}};
							6'b100001: //ADDU
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_ADDU},{4'b0001}};
							6'b100010: //SUB
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_SUB},{4'b0001}};
							6'b100011: //SUBU0
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_SUB},{4'b0001}};
							6'b100100: //AND
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_AND},{4'b0001}};
							6'b100101: //OR
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_OR},{4'b0001}};
							6'b100110: //XOR
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_XOR},{4'b0001}};
							6'b100111: //NOR
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_NOR},{4'b0001}};
							//6'b101000: //*
							//6'b101001: //*
							6'b101010: //SLT
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_SLT},{4'b0001}};
							6'b101011: //SLTU
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_01_0_00},{`A_SLTU},{4'b0001}};
							//6'b101100: //DADD
							//6'b101101: //DADDU
							//6'b101110: //DSUB
							//6'b101111: //DSUBU
							//6'b110000: //TGE
							//6'b110001: //TGEU
							//6'b110010: //TLT
							//6'b110011: //TLTU
							//6'b110100: //TEQ
							//6'b110101: //*
							//6'b110110: //TNE
							//6'b110111: //*
							//6'b111000: //DSLL
							//6'b111001: //*
							//6'b111010: //DSRL
							//6'b111011: //DSRA
							//6'b111100: //DSLL32
							//6'b111101: //*
							//6'b111110: //DSRL32
							//6'b111111: //DSRA32
							default:{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_00_0_00},{`A_NOP},{4'b0000}} ;
						endcase
					end
					6'b000001: begin
						case(Rt)
							6'b00000: //BLTZ
							begin
								isBranch=1;
								if(RsCMPZero == `LESS) tmpsrc = 2'b01; else tmpsrc = 2'b00;
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{tmpsrc},{5'b11_0_00},{`A_NOP},{4'b0000}};
							end
							6'b00001: //BGEZ
							begin
								isBranch=1;
								if(RsCMPZero == `GREATER || RsCMPZero == `EQUAL) tmpsrc = 2'b01; else tmpsrc = 2'b00;
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{tmpsrc},{5'b11_0_00},{`A_NOP},{4'b0000}};
							end
							//6'b00010: //BLTZL
							//6'b00011: //BGEZL
							//6'b10000: //BLTZAL
							//6'b10001: //BGEZAL
							//6'b10010: //BLTZALL
							//6'b10011: //BGEZALL
							default:begin
								isBranch=0;
							{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_00_0_00},{`A_NOP},{4'b0000}} ;
							end
						endcase
						end
					6'b000010: begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b10_11_0_00},{`A_NOP},{4'b0000}};
					end
					//6'b000011: //JAL
					6'b000100:begin
						isBranch=1;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{{1'b0},{RsCMPRt[0]}},{5'b11_0_00},{`A_NOP},{4'b0000}};
					end //BEQ
						
					6'b000101:begin
						isBranch=1;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{{1'b0},{~RsCMPRt[0]}},{5'b11_0_00},{`A_NOP},{4'b0000}};
					end //BNE,
						
					6'b000110: //BLEZ
						begin
						isBranch=1;
						if(RsCMPZero == `LESS || RsCMPZero == `EQUAL) tmpsrc = 2'b01; else tmpsrc = 2'b00;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{tmpsrc},{5'b11_0_00},{`A_NOP},{4'b0000}};
						end
					6'b000111: //BGTZ
						begin
						isBranch=1;
						if(RsCMPZero == `GREATER) tmpsrc = 2'b01; else tmpsrc = 2'b00;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{tmpsrc},{5'b11_0_00},{`A_NOP},{4'b0000}};
						end
					6'b001000: //ADDI
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_0_0_01},{`A_ADD},{4'b0001}};
					end
					6'b001001: //ADDIU
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_0_0_01},{`A_ADDU},{4'b0001}};
					end
					6'b001010: //SLTI
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_0_0_01},{`A_SLT},{4'b0001}};
					end
					6'b001011: //SLTIU
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_0_0_01},{`A_SLTU},{4'b0001}};
					end
					6'b001100: //ANDI
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_0_0_10},{`A_AND},{4'b0001}};
					end
					6'b001101: //ORI
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_0_0_10},{`A_OR},{4'b0001}};
					end
					6'b001110: //XORI
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_0_0_10},{`A_XOR},{4'b0001}};
					end
					6'b001111: //LUI
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_0_0_10},{`A_LUI},{4'b0001}};
					end
					//6'b010000: //COP0
					//6'b010001: //COP1
					//6'b010010: //COP2
					//6'b010011: //COP1X
					//6'b010100: //BEQL
					//6'b010101: //BNEL
					//6'b010110: //BLEZL
					//6'b010111: //BGTZL
					//6'b011000: //DADDI
					//6'b011001: //DADDIU
					//6'b011010: //LDL
					//6'b011011: //LDR
					//6'b011100: //?
					//6'b011101: //*
					//6'b011110: //*
					//6'b011111: //*
					//6'b100000: //LB
					//6'b100001: //LH
					//6'b100010: //LWL
					6'b100011: //LW
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_00_0_01},{`A_ADD},{4'b1011}};
					end
					//6'b100100: //LBU
					//6'b100101: //LHU
					//6'b100110: //LWR
					//6'b100111: //LWU
					//6'b101000: //SB
					//6'b101001: //SH
					//6'b101010: //SWL
					6'b101011: //SW
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_11_0_01},{`A_ADD},{4'b0100}};
					end
					//6'b101100: //SDL
					//6'b101101: //SDR
					//6'b101110: //SWR
					//6'b101111: //?
					//6'b110000: //LL
					//6'b110001: //LWC1
					//6'b110010: //LWC2
					//6'b110011: //PREF
					//6'b110100: //LLD
					//6'b110101: //LDC1
					//6'b110110: //LDC2
					//6'b110111: //LD
					//6'b111000: //SC
					//6'b111001: //SWC1
					//6'b111010: //SWC2
					//6'b111011: //?
					//6'b111100: //SCD
					//6'b111101: //SDC1
					//6'b111110: //SDC2
					//6'b111111: //SD
					default:
					begin
						isBranch=0;
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{7'b00_00_0_00},{`A_NOP},{4'b0000}} ;
					end
				endcase		
		//endcase
	end
endmodule
