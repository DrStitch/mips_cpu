`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/22 08:30:44
// Design Name: 
// Module Name: Counter
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


module Counter
#(parameter width = 32)
(
    input count,
    input clk,
    output reg [width-1:0] Output = 0
    );
    always @(posedge clk)
        if (count)
            Output = Output + 1;
endmodule
