`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/20 08:37:03
// Design Name: 
// Module Name: main
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


module main(

    );
    Register PC (.Data(new_pc), .Enable(~lu), .Clock(clk), .Output(if_pc));
    wire [31:0] pc_4;
    assign pc_4 = if_pc + 4;
    ROM Rom (.addr(if_pc[11:2]), .sel(1), .data(if_ir));

    buffer IF_ID (clk(clk), .en(~lu), .clr(JB), .PC(if_pc), .IR(if_ir), .signal(32'h80000000), .dst(0), .R1_pos(0), .R2_pos(0),
        .D(0), .R1(0), .R2(0), .ALU_R(0), .ext(0), .v0(0), .a0(0),
        .out_PC(id_pc), .out_IR(id_ir), .out_signal(ir_signal0), .out_dst(), .out_R1_pos(), .out_R2_pos(),
        .out_D(), .out_R1(), .out_R2(), .out_ALU_R(), .out_ext(), .out_v0(), .out_a0());
        
    buffer ID_EX (clk(clk), .en(), .clr(), .PC(if_pc), .IR(if_ir), .signal(32'h80000000), .dst(0), .R1_pos(0), .R2_pos(0),
        .D(0), .R1(0), .R2(0), .ALU_R(0), .ext(0), .v0(0), .a0(0),
        .out_PC(id_pc), .out_IR(id_ir), .out_signal(ir_signal0), .out_dst(), .out_R1_pos(), .out_R2_pos(),
        .out_D(), .out_R1(), .out_R2(), .out_ALU_R(), .out_ext(), .out_v0(), .out_a0());
        
    buffer EX_MEM (clk(clk), .en(), .clr(), .PC(if_pc), .IR(if_ir), .signal(32'h80000000), .dst(0), .R1_pos(0), .R2_pos(0),
            .D(0), .R1(0), .R2(0), .ALU_R(0), .ext(0), .v0(0), .a0(0),
            .out_PC(id_pc), .out_IR(id_ir), .out_signal(ir_signal0), .out_dst(), .out_R1_pos(), .out_R2_pos(),
            .out_D(), .out_R1(), .out_R2(), .out_ALU_R(), .out_ext(), .out_v0(), .out_a0());
            
            
    buffer MEM_WB (clk(clk), .en(), .clr(), .PC(if_pc), .IR(if_ir), .signal(32'h80000000), .dst(0), .R1_pos(0), .R2_pos(0),
                .D(0), .R1(0), .R2(0), .ALU_R(0), .ext(0), .v0(0), .a0(0),
                .out_PC(id_pc), .out_IR(id_ir), .out_signal(ir_signal0), .out_dst(), .out_R1_pos(), .out_R2_pos(),
                .out_D(), .out_R1(), .out_R2(), .out_ALU_R(), .out_ext(), .out_v0(), .out_a0());
endmodule
