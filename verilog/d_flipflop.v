`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2017 07:28:04 PM
// Design Name: 
// Module Name: d_flipflop
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


module d_flipflop(
    input clk,
    input data,
    input clr,
    output reg Q = 0
    );
    always @(posedge clr, posedge clk) begin
        if (clr)
            Q <= 0;
        else if (clk)
            Q <= data;
    end
endmodule
