`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/21 09:56:27
// Design Name: 
// Module Name: load_use
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


module load_use(
    input [4:0] dst,
    input memRead,
    input [4:0] R1,
    input [4:0] R2,
    input syscall,
    output lu
    );
    assign lu = (dst === R1 | dst === R2 | ((dst === 5'd2 | dst === 5'd4) & syscall)) & memRead;
endmodule
