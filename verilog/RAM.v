`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/21 10:58:18
// Design Name: 
// Module Name: RAM
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


module RAM(
    input [9:0] addr,
    input [31:0] D_in,
    input str,
    input sel,
    input clk,
    input ld,
    input clr,
    output [31:0] D_out
    );
    reg [31:0] ram
    always @(posedge clk) begin
        if (str)
            
endmodule
