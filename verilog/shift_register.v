`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2017 08:44:56 PM
// Design Name: 
// Module Name: shift_register
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


module shift_register(
    input clk,
    input en,
    input left,
    input [1:0] in_data,
    output [1:0] out_data
    );
    reg [7:0] register = 0;
    always @(posedge clk) begin
        if (en) begin
            if (left)
                register = {register[5:0], 2'b0};
            else
                register = {in_data, register[7:2]};
        end
    end
    assign out_data = register[7:6];
endmodule
