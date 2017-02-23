`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/20 16:09:25
// Design Name: 
// Module Name: regfile
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


module regfile(
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] Din,
    input we,
    input clk,
    output [31:0] reg1,
    output [31:0] reg2,
    output [31:0] v0,
    output [31:0] a0
    );
    reg [31:0] registers [0:31];
    always @(negedge clk)
        if (we)
            registers[writeReg] = Din;
            
    assign reg1 = |readReg1 ? registers[readReg1] : 0;
    assign reg2 = |readReg2 ? registers[readReg2] : 0;
    assign v0 = registers[2];
    assign a0 = registers[4];
endmodule
