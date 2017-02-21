`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/21 08:51:56
// Design Name: 
// Module Name: extender
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


module extender(
    input [31:0] IR,
    output reg [31:0] result
    );
    wire [1:0] sel;
    assign sel[1] = ~IR[31] & ~IR[29] & ~IR[28] & ~IR[27] + ~IR[29] & ~IR[28] & ~IR[27] & ~IR[26] + IR[30] & ~IR[29] & ~IR[28] & ~IR[27];
    assign sel[0] = IR[27] + IR[28] + IR[29] & ~IR[26] + IR[31] & ~IR[30] & ~IR[29] & IR[26];
	
	always begin
		case (sel)
			0: result = {{16{0}}, IR[15:0]};
			1: result = {{16{IR[15]}}, IR[15:0]};
			2: result = {{27{IR[10]}}, IR[10:6]};
			3: result = 0;
		endcase
	end
endmodule
