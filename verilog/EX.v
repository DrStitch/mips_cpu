`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/22 16:01:50
// Design Name: 
// Module Name: EX
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


module EX(
    input clk,
    input lu,
    input [31:0] in_pc,
	input [31:0] in_pc_4,
    input [31:0] in_ir,
    input [31:0] in_signal,
    input [4:0] in_dst,
	input [4:0] r1_pos,
	input [4:0] r2_pos,
	input [31:0] in_r1,
	input [31:0] in_r2,
	input [31:0] in_ext,
	input [31:0] in_v0,
	input [31:0] in_a0,
	output reg [31:0] new_pc,
	output [31:0] out_pc,
	output [31:0] out_ir,
	output [31:0] out_signal,
	output [5:0] out_dst,
	output [31:0] out_r2,
	output [31:0] out_r,
	output [31:0] out_v0,
	output [31:0] out_a0,
	output JB
    );
	wire [3:0] AluOp;
	wire [1:0] BranchSel;
	
	assign out_pc = in_pc;
	assign out_ir = in_ir;
	assign out_dst = in_dst;
	assign out_r2 = in_r2;
	assign out_v0 = in_v0;
	assign out_a0 = in_a0;
	assign JB = JR | Jmp | b;
	
	assign Branch = in_signal[1];
	assign Jmp = in_signal[2];
	assign AluSrc = in_signal[6];
	assign AluOp = in_signal[11:8];
	assign XSrcR2 = in_signal[12];
	assign JR = in_signal[14];
	assign BranchSel = in_signal[20:19];
	assign X = XSrcR2 ? in_r2 : in_r1;
	assign Y = AluSrc ? in_ext : in_r2;
	
	ALU (.X(X), .Y(Y), .S(AluOp),
		.Result(out_r), .Result2(), .OF(), .CF(), .Equal(equal));
	
	reg b;
	always begin
		case (BranchSel)
			0: b = equal;
			1: b = ~equal;
			2: b = out_r[0];
			3: b = 0;
		endcase
	end
	
	assign out_signal[27:0] = in_signal[27:0];
	assign out_signal[28] = lu;
	assign out_signal[29] = b;
	assign out_signal[30] = Jmp | JR;
	assign out_signal[31] = in_signal[31];
	
	always begin
		if (JR)
			new_pc = in_r1;
		else if (Jmp) begin
			new_pc[1:0] = 0;
			new_pc[27:2] = in_ir[25:0];
			new_pc[31:28] = in_pc[31:28];
		end else if (b)
			new_pc = in_pc + {{14{in_ir[15]}}, in_ir[15:0], 0, 0};
		else
			new_pc = in_pc_4;
	end
	
endmodule