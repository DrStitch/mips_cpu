`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/21 09:37:38
// Design Name: 
// Module Name: redirect
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


module redirect(
    input [31:0] data,
    input [4:0] dst,
    input [31:0] wb_data,
    input [4:0] wb_dst,
    input wb_we,
    input [31:0] mem_data,
    input [4:0] mem_dst,
    input mem_we,
    output data_out
    );
    assign data_out = ~|dst ? 0 :
                      (dst === mem_dst) & mem_en ? mem_data :
                      (dst === wb_dst) & wb_en ? wb_data :
                      data;
endmodule
