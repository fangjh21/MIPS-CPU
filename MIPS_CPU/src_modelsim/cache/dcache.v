module dcache(clk,reset,we,re,addr,wdata,rdata);
  input clk, we,re;
  input reset;
  input[31:0] addr, wdata;
  output[31:0] rdata; 
  
  reg[31:0] RAM[255:0]; 
  assign rdata = re ? RAM[addr[9:2]]:32'b0;
  
  integer i;
	always@(posedge clk or negedge reset)
	 begin
		if (~reset)
		begin
RAM[0]<=32'h3243f6a8;
RAM[1]<=32'h885a308d;
RAM[2]<=32'h313198a2;
RAM[3]<=32'he0370734;
RAM[4]<=32'h2b7e1516;
RAM[5]<=32'h28aed2a6;
RAM[6]<=32'habf71588;
RAM[7]<=32'h09cf4f3c;
RAM[8]<=32'h637c777b;
RAM[9]<=32'hf26b6fc5;
RAM[10]<=32'h3001672b;
RAM[11]<=32'hfed7ab76;
RAM[12]<=32'hca82c97d;
RAM[13]<=32'hfa5947f0;
RAM[14]<=32'hadd4a2af;
RAM[15]<=32'h9ca472c0;
RAM[16]<=32'hb7fd9326;
RAM[17]<=32'h363ff7cc;
RAM[18]<=32'h34a5e5f1;
RAM[19]<=32'h71d83115;
RAM[20]<=32'h04c723c3;
RAM[21]<=32'h1896059a;
RAM[22]<=32'h071280e2;
RAM[23]<=32'heb27b275;
RAM[24]<=32'h09832c1a;
RAM[25]<=32'h1b6e5aa0;
RAM[26]<=32'h523bd6b3;
RAM[27]<=32'h29e32f84;
RAM[28]<=32'h53d100ed;
RAM[29]<=32'h20fcb15b;
RAM[30]<=32'h6acbbe39;
RAM[31]<=32'h4a4c58cf;
RAM[32]<=32'hd0efaafb;
RAM[33]<=32'h434d3385;
RAM[34]<=32'h45f9027f;
RAM[35]<=32'h503c9fa8;
RAM[36]<=32'h51a3408f;
RAM[37]<=32'h929d38f5;
RAM[38]<=32'hbcb6da21;
RAM[39]<=32'h10fff3d2;
RAM[40]<=32'hcd0c13ec;
RAM[41]<=32'h5f974417;
RAM[42]<=32'hc4a77e3d;
RAM[43]<=32'h645d1973;
RAM[44]<=32'h60814fdc;
RAM[45]<=32'h222a9088;
RAM[46]<=32'h46eeb814;
RAM[47]<=32'hde5e0bdb;
RAM[48]<=32'he0323a0a;
RAM[49]<=32'h4906245c;
RAM[50]<=32'hc2d3ac62;
RAM[51]<=32'h9195e479;
RAM[52]<=32'he7c8376d;
RAM[53]<=32'h8dd54ea9;
RAM[54]<=32'h6c56f4ea;
RAM[55]<=32'h657aae08;
RAM[56]<=32'hba78252e;
RAM[57]<=32'h1ca6b4c6;
RAM[58]<=32'he8dd741f;
RAM[59]<=32'h4bbd8b8a;
RAM[60]<=32'h703eb566;
RAM[61]<=32'h4803f60e;
RAM[62]<=32'h613557b9;
RAM[63]<=32'h86c11d9e;
RAM[64]<=32'he1f89811;
RAM[65]<=32'h69d98e94;
RAM[66]<=32'h9b1e87e9;
RAM[67]<=32'hce5528df;
RAM[68]<=32'h8ca1890d;
RAM[69]<=32'hbfe64268;
RAM[70]<=32'h41992d0f;
RAM[71]<=32'hb054bb16;
RAM[72]<=32'h01000000;
RAM[73]<=32'h02000000;
RAM[74]<=32'h04000000;
RAM[75]<=32'h08000000;
RAM[76]<=32'h10000000;
RAM[77]<=32'h20000000;
RAM[78]<=32'h40000000;
RAM[79]<=32'h80000000;
RAM[80]<=32'h1b000000;
RAM[81]<=32'h36000000;
for (i=82;i<256;i=i+1)
RAM[i]<=32'h00000000;
		end
		else begin
			if(we)  
				RAM[addr[9:2]]<= wdata; 
		end
	 end
endmodule
