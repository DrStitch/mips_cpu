`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2017 07:09:25 PM
// Design Name: 
// Module Name: cp0
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


module CP0(
    input [4:0] pos,
    input [31:0] din,
    input [31:0] pc,
    input we,
    input clk,
    input eret,
    input ir0,
    input ir1,
    input ir2,
    output [31:0] Reg,
    output [31:0] new_pc,
    output is
    );
    wire [1:0] next, cur;
    reg [31:0] reg0 = 32'b1;
    reg [31:0] reg1 = 0;
    always @(posedge clk) begin
        if (eret) begin
            reg0 <= 32'b1;
        end else if (is) begin
            reg0 <= 32'b0;
            reg1 <= pc;
        end else if (we & ~pos[0])
            reg0 <= din;
        else if (we & pos[0])
            reg1 <= din;
    end
    
    assign Reg = pos[0] ? reg1 : reg0;
    
    d_flipflop i_d1 (.clk(ir0), .data(1'b1), .clr(~cur[1] & cur[0]), .Q(t1));
    d_flipflop i_d2 (.clk(ir1), .data(1'b1), .clr(cur[1] & ~cur[0]), .Q(t2));
    d_flipflop i_d3 (.clk(ir2), .data(1'b1), .clr(cur[1] & cur[0]), .Q(t3));
    assign q1 = t1 & ~cur[0] & ~cur[1];
    assign q2 = t2 & ~cur[1];
    assign q3 = t3 & ~&cur;
    

    assign next = q3 ? 3 :
                  q2 ? 2 :
                  q1 ? 1 :
                  0;
    shift_register i_sr (.clk(clk), .en(eret|is), .left(eret),
                         .in_data(next), .out_data(cur));
                         
    assign is = (q1 | q2 | q3) & reg0[0];
    assign new_pc = eret ? reg1 : {22'h3fffff, next, 8'b0};
endmodule
