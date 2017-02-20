`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/20 16:43:51
// Design Name: 
// Module Name: IR_circuit
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


module IR_circuit(
    input [31:0] ir,
    RegDst
    MemRead
    MemWrite
    
    Branch
    Jmp
    RegWrite
);
    wire [5:0] op;
    wire [5:0] func;
    assign op = ir[31:26];
    assign func = ir[5:0];
    
    assign RegDst = ~op[4] & ~op[3] & ~op[1] & ~op[0] + ~op[5] & ~op[3] & ~op[1] & op[0] + ~op[3] & op[2] & ~op[1] + op[5] & op[4] & ~op[3] & ~op[1];
    assign MemRead = op[5] & ~op[4] & ~op[3] & ~op[2] & op[0];
    assign MemWrite = op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
    
    assign Branch = ~op[3] & op[2];
    assign Jmp = ~op[5] & ~op[3] & ~op[2] & op[1] + ~op[5] & ~op[3] & op[1] & op[0] + ~op[5] & op[4] & ~op[3] & op[1];
    assign RegWrite = (~op[2] & ~op[1] + ~op[3] & ~op[2] & op[0] + ~op[5] & op[3]) & ~jr & ~mtc0 & ~eret;
    
    assign MemToReg = op[5];
    assign AluSc = (op[1] + op[3] + op[4] & op[2] + op[5] & ~op[4] & op[0] + op[5] & op[2]) | X_src_R2;
    
    assign AluOp[2] = ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] + ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[0] + op[3] & op[1] & ~op[0];
    assign AluOp[1] = op[3] & op[2];
    assign AluOp[0] = ~op[4] & ~op[3] & op[2] & ~op[1] + ~op[4] & ~op[3] & op[2] & ~op[0] + op[3] & ~op[2] & ~op[1] + op[3] & op[0] + op[5];
    
    assign jal = ~op6 ~op5 ~op4 ~op3 op2 op1;
    assign jr = (&~op) & &{~func[5], ~func[4], func[3], ~func[2], ~func[1], ~func[0]};
    assign syscall = (&~op) & &(~func[5], ~func[4], func[3], func[2], ~func[1], ~func[0]};
    
endmodule
