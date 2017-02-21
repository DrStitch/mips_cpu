`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/21 10:15:18
// Design Name: 
// Module Name: Register
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


module Register
#( parameter width = 32 )
(
    input [width-1:0] Data,
    input Enable,
    input Clock,
    output reg [31:0] Output
    );
    always @(posedge Clock)
        if (Enable)
            Output = Data;
endmodule
