`timescale 1ns / 1ps
module mux #(parameter WIDTH = 32)(
    input sel,
    input [WIDTH-1:0] d0,
    input [WIDTH-1:0] d1,
    output [WIDTH-1:0] out
    );
	assign out = (sel == 1'b1 ? d1 : d0);
endmodule


module mux2 #(parameter WIDTH = 32)(
    input [1:0] sel,
    input [WIDTH-1:0] d0,
    input [WIDTH-1:0] d1,
    input [WIDTH-1:0] d2,
    input [WIDTH-1:0] d3,
    output [WIDTH-1:0] out
    );
    wire [WIDTH-1:0] temp1,temp2;

assign temp1 = (sel[0] == 1'b1 ? d1 : d0);
assign temp2= (sel[0] == 1'b1 ? d3 : d2);
assign out = (sel[1] == 1'b1 ? temp2 : temp1);
endmodule
