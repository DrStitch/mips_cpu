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
    output reg clk2
    );
    integer n=0;
    always @(posedge CLK)
    begin
        if(n<99999)//�仯1000000��
        begin
            n<=n+1;
            clk2<=1'b0;
        end
        else//CLKÿ�仯1000000�Σ�clk2�ű仯һ��
        begin
            n<=0;
            clk2<=1'b1;
        end
    end
endmodule

module div10hz(
    input CLK,
    output reg clk1
    );
    integer m=0;
    always @(posedge CLK)
    begin
        if(m<999999)
            begin
                m<=m+1;
                clk1<=1'b0;
            end
        else
            begin
                m<=0;
                clk1<=1'b1;
            end
    end
endmodule