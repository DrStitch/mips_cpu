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
    output [31:0] signal
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
    assign AluSrc = (op[1] + op[3] + op[4] & op[2] + op[5] & ~op[4] & op[0] + op[5] & op[2]) | X_src_R2;
    
    wire [2:0] aluop;
    assign aluop[2] = ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] + ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[0] + op[3] & op[1] & ~op[0];
    assign aluop[1] = op[3] & op[2];
    assign aluop[0] = ~op[4] & ~op[3] & op[2] & ~op[1] + ~op[4] & ~op[3] & op[2] & ~op[0] + op[3] & ~op[2] & ~op[1] + op[3] & op[0] + op[5];
    
    wire [3:0] AluOp;
    assign AluOp[3] = ~aluop[1] & ~aluop[0] & ~func[5] & ~func[4] & func[2] & ~func[1] + ~aluop[1] & ~aluop[0] & func[2] & func[0] + ~aluop[1] & ~aluop[0] & func[3] + aluop[1] & aluop[0] + aluop[2];
    assign AluOp[2] = ~aluop[2] & ~aluop[1] & func[2] & ~func[0] + ~aluop[2] & ~aluop[1] & ~func[5] & ~func[4] & ~func[3] & func[2] & func[1] + ~aluop[2] & ~aluop[1] & func[5] & ~func[3] & ~func[2] + ~aluop[2] & ~aluop[1] & func[5] & ~func[4] & ~func[2] & func[1] & func[0] + ~aluop[1] & aluop[0] + aluop[1] & ~aluop[0];
    assign AluOp[1] = ~aluop[0] & func[1] & ~func[0] + ~aluop[0] & func[2] & func[1] + ~aluop[0] & func[3] & func[2] & ~func[0] + ~aluop[0] & func[4] & func[2] & ~func[0] + ~aluop[0] & func[5] & func[2] & ~func[0] + aluop[1] & ~aluop[0] + aluop[2];
    assign AluOp[0] = ~aluop[1] & ~func[3] & ~func[2] & func[0] + ~aluop[1] & ~func[4] & func[2] & ~func[1] & ~func[0] + ~aluop[1] & ~func[5] & func[3] + ~aluop[1] & func[3] & ~func[1] + ~aluop[1] & func[3] & ~func[0] + ~aluop[1] & func[3] & func[2] + ~aluop[1] & func[4] & func[3] + ~aluop[1] & func[5] & ~func[1] & ~func[0] + ~aluop[1] & aluop[0] + aluop[1] & ~aluop[0] + aluop[2];
    assign X_src_R2 = ~aluop[2] & ~aluop[1] & ~aluop[0] & ~func[5] & ~func[4] & ~func[3] & ~func[2] & (func[1] + ~func[0]);
    
    assign jal = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
    assign jr = &{~op, ~func[5], ~func[4], func[3], ~func[2], ~func[1], ~func[0]};
    assign syscall = &{~op, ~func[5], ~func[4], func[3], func[2], ~func[1], ~func[0]};
    
    assign mfc0 = ~ir[31] & ir[30] & ~ir[25] & ~ir[23];
    assign mtc0 = ~ir[31] & ir[30] & ~ir[25] & ir[23];
    assign eret = ~ir[31] & ir[30] & ir[25] & ~ir[23];
    
    wire [1:0] Branch_sel;
    assign Branch_sel = ir[27:26];
    assign lh = ir[27];
    
    assign signal[0] = RegDst;
    assign signal[1] = Branch;
    assign signal[2] = Jmp;
    assign signal[3] = MemToReg;
    assign signal[4] = MemRead;
    assign signal[5] = MemWrite;
    assign signal[6] = AluSrc;
    assign signal[7] = RegWrite;
    assign signal[11:8] = AluOp;
    assign signal[12] = X_src_R2;
    assign signal[13] = jal;
    assign signal[14] = jr;
    assign signal[15] = syscall;
    assign signal[16] = mfc0;
    assign signal[17] = mtc0;
    assign signal[18] = eret;
    assign signal[20:19] = Branch_sel;
    assign signal[21] = lh;
    assign signal[31:22] = 0;
    
endmodule
