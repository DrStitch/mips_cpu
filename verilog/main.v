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
    wire [31:0] new_pc, if_pc, pc_4, if_ir, id_pc, id_ir, id_signal0;


    IF( .lu(lu), .clk(clk), .new_pc(new_pc), .pc_4(if_pc), .ir(if_ir));

    buffer IF_ID (clk(clk), .en(~lu), .clr(JB), .PC(if_pc), .IR(if_ir), .signal(32'h80000000), .dst(0), .R1_pos(0), .R2_pos(0),
        .D(0), .R1(0), .R2(0), .ALU_R(0), .ext(0), .v0(0), .a0(0),
        .out_PC(id_pc), .out_IR(id_ir), .out_signal(id_signal0), .out_dst(), .out_R1_pos(), .out_R2_pos(),
        .out_D(), .out_R1(), .out_R2(), .out_ALU_R(), .out_ext(), .out_v0(), .out_a0());
        
        
    ID( .clk(clk), .in_pc(), .in_ir(), .in_signal(), .rw(), .din(), .we(), 
        .out_pc(), .out_ir(), .out_signal(), .dst(), .r1_pos(), .r2_pos(), .ext(), .r1(), .r2(), .v0(), .a0() );
        
        
    buffer ID_EX (clk(clk), .en(1), .clr(JB|lu), .PC(id_pc), .IR(id_ir), .signal(id_signal0|id_signal1), .dst(id_dst), .R1_pos(id_ir[25:21]), .R2_pos(id_ir[20:16]),
        .D(0), .R1(id_r1), .R2(id_r2), .ALU_R(0), .ext(id_ext), .v0(id_v0), .a0(id_a0),
        .out_PC(ex_pc), .out_IR(ex_ir), .out_signal(ex_signal0), .out_dst(ex_dst), .out_R1_pos(ex_r1_pos), .out_R2_pos(ex_r2_pos),
        .out_D(), .out_R1(ex_r1), .out_R2(ex_r2), .out_ALU_R(), .out_ext(ex_ext), .out_v0(ex_v0), .out_a0(ex_a0));
		
	wire [31:0] ex_signal1, ex_new_r1, ex_new_r2, ex_alu_r, ex_new_v0, ex_new_a0;
	wire [31:0] mem_pc, mem_ir, mem_signal, mem_r2, mem_alu_r, mem_v0, mem_a0;
    wire [4:0] mem_dst;
	redirect (.data(ex_r1), .dst(ex_r1_pos), .wb_data(wb_data), .wb_dst(wb_dst), .wb_we(wb_we), .mem_data(mem_alu_r), .mem_dst(mem_dst), .mem_we(mem_we), .data_out(ex_new_r1));
	redirect (.data(ex_r2), .dst(ex_r2_pos), .wb_data(wb_data), .wb_dst(wb_dst), .wb_we(wb_we), .mem_data(mem_alu_r), .mem_dst(mem_dst), .mem_we(mem_we), .data_out(ex_new_r2));
	redirect (.data(ex_v0), .dst(5'h2), .wb_data(wb_data), .wb_dst(wb_dst), .wb_we(wb_we), .mem_data(mem_alu_r), .mem_dst(mem_dst), .mem_we(mem_we), .data_out(ex_new_v0));
	redirect (.data(ex_a0), .dst(5'h4), .wb_data(wb_data), .wb_dst(wb_dst), .wb_we(wb_we), .mem_data(mem_alu_r), .mem_dst(mem_dst), .mem_we(mem_we), .data_out(ex_new_a0));
    
	assign ex_Branch = ex_signal0[1];
	assign ex_Jmp = ex_signal0[2];
	assign ex_AluSrc = ex_signal0[6];
	assign ex_AluOp = ex_signal0[11:8];
	assign ex_XSrcR2 = ex_signal0[12];
	assign 
	assign X = ex_XSrcR2
        
    buffer EX_MEM (clk(clk), .en(1), .clr(0), .PC(ex_pc), .IR(ex_ir), .signal(ex_signal1), .dst(ex_dst), .R1_pos(0), .R2_pos(0),
        .D(0), .R1(ex_new_r1), .R2(ex_new_r2), .ALU_R(ex_alu_r), .ext(0), .v0(ex_new_v0), .a0(ex_new_a0),
        .out_PC(mem_pc), .out_IR(mem_ir), .out_signal(mem_signal), .out_dst(mem_dst), .out_R1_pos(0), .out_R2_pos(0),
        .out_D(), .out_R1(), .out_R2(mem_r2), .out_ALU_R(mem_alu_r), .out_ext(), .out_v0(mem_v0), .out_a0(mem_a0));
            
            
    buffer MEM_WB (clk(clk), .en(1), .clr(0), .PC(mem_pc), .IR(mem_ir), .signal(mem_signal), .dst(mem_dst), .R1_pos(0), .R2_pos(0),
        .D(), .R1(), .R2(), .ALU_R(mem_alu_r), .ext(0), .v0(mem_v0), .a0(mem_a0),
        .out_PC(wb_pc), .out_IR(wb_ir), .out_signal(wb_signal), .out_dst(wb_dst), .out_R1_pos(0), .out_R2_pos(0),
        .out_D(wb_d), .out_R1(), .out_R2(), .out_ALU_R(wb_alu_r), .out_ext(), .out_v0(wb_v0), .out_a0(wb_a0));
endmodule
