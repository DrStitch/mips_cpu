`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/22 16:02:31
// Design Name: 
// Module Name: MEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM(
    input clk,
	input [31:0] in_signal,
	input [31:0] in_r2,
	input [31:0] in_r,
    output [31:0] out_d
    );
    wire [31:0] data;

    assign MemRead = in_signal[4];
    assign MemWrite = in_signal[5];
    assign LH = in_signal[21];
    
    RAM (.addr(in_r[11:2]), .D_in(in_r2), .str(MemWrite), .clk(clk), .ld(MemRead), .D_out(data));
    
    assign out_d = ~LH ? data :
                   in_r[1] ? data >>> 16 :
                   {16{data[15]}, data[15:0]};
    
endmodule
