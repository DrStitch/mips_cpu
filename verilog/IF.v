`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/22 15:36:23
// Design Name: 
// Module Name: IF
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


module IF(
    input lu,
    input clk,
    input [31:0] new_pc,
    output [31:0] pc_4,
    output [31:0] ir,
    output [31:0] signal
    );
    wire [31:0] pc;
    Register PC (.Data(new_pc), .Enable(~lu), .Clock(clk), .Output(pc));
    ROM Rom (.addr(pc[11:2]), .sel(1), .data(ir));
    assign pc_4 = pc + 4;
    assign signal = 32'h80000000;
endmodule
