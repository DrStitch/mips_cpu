`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/24 08:25:06
// Design Name: 
// Module Name: test_ir
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


module test_ir;
    reg [31:0] ir;
    wire [31:0] signal;
    IR_circuit IR (ir, signal);
    initial begin
        #5 ir = 32'h00000820;
        #5 ir = 32'h2002000a;
        #5 ir = 32'h2403000a;
        #5 ir = 32'h00432021;
        #5 ir = 32'h00442824;
        #5 ir = 32'h00023080;
    end
endmodule
