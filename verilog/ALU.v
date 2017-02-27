`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//// Company:
//// Engineer:
////
//// Create Date: 2017/02/20 08:42:47
//// Design Name:
//// Module Name: ALU
//// Project Name:
//// Target Devices:
//// Tool Versions:
//// Description:
////
//// Dependencies:
////
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
////
////////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [31:0] X,
    input [31:0] Y,
    input [3:0] S,
    output reg [31:0] Result = 0,
    output reg [31:0] Result2 = 0,
    output reg OF = 0,
    output reg CF = 0,
    output reg Equal = 0
);
    always @(*) begin
        case (S)
            0: begin Result = X << Y[4:0]; Result2 = 0; OF = 0; CF = 0; end
            1: begin Result = $signed(X) >>> Y[4:0]; Result2 = 0; OF = 0; CF = 0; end
            2: begin Result = X >> Y[4:0]; Result2 = 0; OF = 0; CF = 0; end
            3: begin {Result2, Result} = X * Y; OF = 0; CF = 0; end
            4: begin Result = X / Y; Result2 = X % Y; OF = 0; CF = 0; end
            5: begin {CF, Result} = X + Y; Result2 = 0; OF = (X[31] & Y[31] & ~Result[31]) | (~X[31] & ~Y[31] & Result[31]); end
            6: begin Result = X - Y; Result2 = 0; OF = (~X[31] & Y[31] & Result[31]) | (X[31] & ~Y[31] & ~Result[31]); CF = X > Y; end
            7: begin Result = X & Y; Result2 = 0; OF = 0; CF = 0; end
            8: begin Result = X | Y; Result2 = 0; OF = 0; CF = 0; end
            9: begin Result = X ^ Y; Result2 = 0; OF = 0; CF = 0; end
            10: begin Result = ~(X | Y); Result2 = 0; OF = 0; CF = 0; end
            11: begin Result = $signed(X) < $signed(Y); Result2 = 0; OF = 0; CF = 0; end
            12: begin Result = X < Y; Result2 = 0; OF = 0; CF = 0; end
            13: begin Result = Y << X[4:0]; Result2 = 0; OF = 0; CF = 0; end
            14: begin Result = $signed(Y) >>> X[4:0]; Result2 = 0; OF = 0; CF = 0; end
            15: begin Result = $signed(X) <= 0; Result2 = 0; OF = 0; CF = 0; end
        endcase
        Equal = X === Y;
    end
endmodule

