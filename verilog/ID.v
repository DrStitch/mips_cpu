`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/22 15:47:18
// Design Name: 
// Module Name: ID
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


module ID(
    input clk,
    input [31:0] in_pc,
    input [31:0] in_ir,
    input [31:0] in_signal,
    input [4:0] rw,
    input [31:0] din,
    input we,
    output [31:0] out_pc,
    output [31:0] out_ir,
    output [31:0] out_signal,
    output [4:0] dst,
    output [4:0] r1_pos,
    output [4:0] r2_pos,
    output [31:0] ext,
    output [31:0] r1,
    output [31:0] r2,
    output [31:0] v0,
    output [31:0] a0
    );
    assign out_pc = in_pc;
    assign out_ir = in_ir;

    IR_circuit (.ir(in_ir), .signal(signal));
    assign out_signal = in_signal | signal;
    
    assign RegDst = signal[0];
    assign jal = signal[13];
    assign syscall = signal[13];
    assign dst = jal ? 5'h1f : RegDst ? in_ir[15:11] : in_ir[20:16];
    assign r1_pos = in_ir[25:21];
    assign r2_pos = in_ir[20:16];
    
    extender (.IR(in_ir), .result(ext));
    regfile (.readReg1(r1_pos), .readReg2(r2_pos), .writeReg(rw), .Din(din), .we(we), .clk(clk),
        .reg1(r1), .reg2(r2), .v0(v0), .a0(a0));
endmodule
