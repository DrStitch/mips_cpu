`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/24 09:30:21
// Design Name: 
// Module Name: frequency
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

module div1000hz(
    input CLK,
    output clk2
    );
    reg [9:0] count = 0;
    always @(posedge CLK)
        if (count == 999)
            count = 0;
        else
            count = count + 1;
        
    assign clk2 = count >= 500;
endmodule

module div10hz(
    input CLK,
    output clk1
    );
    reg [3:0] count = 0;
    always @(posedge CLK)
        if (count == 9)
            count = 0;
        else
            count = count + 1;
        
    assign clk1 = count >= 5;
endmodule