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
    input [31:0] in_cp0,
    output [31:0] out_data,
	output out_we,
    output [31:0] display,
    output clk
    );

	assign out_we = in_signal[7];
    assign MemtoReg = in_signal[3];
    assign JAL = in_signal[13];
    assign syscall = in_signal[15];
    assign mfc0 = in_signal[16];
    
    assign out_data = mfc0 ? in_cp0 :
                      JAL ? in_pc :
                      MemtoReg ? in_d :
                      in_r;
                      
    assign clk = Clock & ~(syscall & (in_v0 === 32'h0000_000a));
    Register i_Register ( .Data(in_a0), .Enable(syscall & (in_v0 !== 32'h0000_000a)), .Clock(clk), .Output(display));
endmodule
