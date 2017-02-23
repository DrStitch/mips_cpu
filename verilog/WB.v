`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/22 16:59:35
// Design Name: 
// Module Name: WB
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


module WB(
    input Clock,
    input [31:0] in_pc,
    input [31:0] in_signal,
    input [31:0] in_d,
    input [31:0] in_r,
    input [31:0] in_v0,
    input [31:0] in_a0,
    output [31:0] out_data,
    output [31:0] display,
    output clk
    );
    assign MemtoReg = signal[3]
    assign JAL = signal[13];
    assign syscall = signal[15];
    
    assign out_data = JAL ? in_pc :
                      MemtoReg ? in_d :
                      in_r;
                      
    assign clk = Clock & ~(syscall & (in_v0 === 32'h0000_000a));
    Register ( .Data(in_a0), .Enable(syscall & (in_v0 !== 32'h0000_000a), .Clock(clk), .Output(display));
endmodule
