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
	input Clock
    );
	wire [31:0] if_pc, if_ir;

	wire [31:0] id_pc_1, id_ir_1, id_signal_1;
	wire [31:0] id_pc_2, id_ir_2, id_signal_2, id_r1_2, id_r2_2, id_ext_2, id_v0_2, id_a0_2;
	wire [4:0] id_dst_2, id_r1_pos_2, id_r2_pos_2;
	
	wire [31:0] ex_pc_1, ex_ir_1, ex_signal_1, ex_r1_1, ex_r2_1, ex_ext_1, ex_v0_1, ex_a0_1;
	wire [4:0] ex_dst_1, ex_r1_pos_1, ex_r2_pos_1;
	wire [31:0] ex_pc_2, ex_ir_2, ex_signal_2, ex_r2_2, ex_r_2, ex_v0_2, ex_a0_2;
	wire [4:0] ex_dst_2;
	wire [31:0] ex_new_r1, ex_new_r2, ex_new_v0, ex_new_a0;
	
	wire [31:0] mem_pc_1, mem_ir_1, mem_signal_1, mem_r2_1, mem_r_1, mem_v0_1, mem_a0_1;
	wire [4:0] mem_dst_1;
	wire [31:0] mem_pc_2, mem_ir_2, mem_signal_2, mem_d_2, mem_r_2, mem_v0_2, mem_a0_2;
	wire [4:0] mem_dst_2;
	
	wire [31:0] wb_pc_1, wb_ir_1, wb_signal_1, wb_d_1, wb_r_1, wb_v0_1, wb_a0_1;
	wire [4:0] wb_dst_1;

    wire [31:0] new_pc, wb_data, display;
    
    wire wb_we, mem_we, lu, JB, clk;
	
    IF i_IF ( .lu(lu), .clk(clk), .new_pc(new_pc), .pc_4(if_pc), .ir(if_ir));

    buffer IF_ID (.clk(clk), .en(~lu), .clr(JB), .PC(if_pc), .IR(if_ir), .signal(32'h80000000), .dst(5'b0), .R1_pos(5'b0), .R2_pos(5'b0),
        .D(0), .R1(0), .R2(0), .ALU_R(0), .ext(0), .v0(0), .a0(0),
        .out_PC(id_pc_1), .out_IR(id_ir_1), .out_signal(id_signal_1), .out_dst(), .out_R1_pos(), .out_R2_pos(),
        .out_D(), .out_R1(), .out_R2(), .out_ALU_R(), .out_ext(), .out_v0(), .out_a0());
        
        
    ID i_ID( .clk(clk), .in_pc(id_pc_1), .in_ir(id_ir_1), .in_signal(id_signal_1), .rw(wb_dst_1), .din(wb_data), .we(wb_we), 
        .out_pc(id_pc_2), .out_ir(id_ir_2), .out_signal(id_signal_2), .dst(id_dst_2), .r1_pos(id_r1_pos_2),
		.r2_pos(id_r2_pos_2), .ext(id_ext_2), .r1(id_r1_2), .r2(id_r2_2), .v0(id_v0_2), .a0(id_a0_2) );
        
        
    buffer ID_EX (.clk(clk), .en(1'b1), .clr(JB|lu), .PC(id_pc_2), .IR(id_ir_2), .signal(id_signal_2), .dst(id_dst_2), .R1_pos(id_r1_pos_2), .R2_pos(id_r2_pos_2),
        .D(0), .R1(id_r1_2), .R2(id_r2_2), .ALU_R(0), .ext(id_ext_2), .v0(id_v0_2), .a0(id_a0_2),
        .out_PC(ex_pc_1), .out_IR(ex_ir_1), .out_signal(ex_signal_1), .out_dst(ex_dst_1), .out_R1_pos(ex_r1_pos_1), .out_R2_pos(ex_r2_pos_1),
        .out_D(), .out_R1(ex_r1_1), .out_R2(ex_r2_1), .out_ALU_R(), .out_ext(ex_ext_1), .out_v0(ex_v0_1), .out_a0(ex_a0_1));
		
	redirect rdrctr1 (.data(ex_r1_1), .dst(ex_r1_pos_1), .wb_data(wb_data), .wb_dst(wb_dst_1), .wb_we(wb_we), .mem_data(mem_r_1), .mem_dst(mem_dst_1), .mem_we(mem_we), .data_out(ex_new_r1));
	redirect rdrctr2 (.data(ex_r2_1), .dst(ex_r2_pos_1), .wb_data(wb_data), .wb_dst(wb_dst_1), .wb_we(wb_we), .mem_data(mem_r_1), .mem_dst(mem_dst_1), .mem_we(mem_we), .data_out(ex_new_r2));
	redirect rdrctv0 (.data(ex_v0_1), .dst(5'h2), .wb_data(wb_data), .wb_dst(wb_dst_1), .wb_we(wb_we), .mem_data(mem_r_1), .mem_dst(mem_dst_1), .mem_we(mem_we), .data_out(ex_new_v0));
	redirect rdrcta0 (.data(ex_a0_1), .dst(5'h4), .wb_data(wb_data), .wb_dst(wb_dst_1), .wb_we(wb_we), .mem_data(mem_r_1), .mem_dst(mem_dst_1), .mem_we(mem_we), .data_out(ex_new_a0));
    
	EX i_EX ( .clk(clk), .lu(lu), .in_pc(ex_pc_1), .in_pc_4(if_pc), .in_ir(ex_ir_1), .in_signal(ex_signal_1), .in_dst(ex_dst_1),
		.in_r1(ex_new_r1), .in_r2(ex_new_r2), .in_ext(ex_ext_1), .in_v0(ex_new_v0), .in_a0(ex_new_a0),
		.new_pc(new_pc), .out_pc(ex_pc_2), .out_ir(ex_ir_2), .out_signal(ex_signal_2),
		.out_dst(ex_dst_2), .out_r2(ex_r2_2), .out_r(ex_r_2), .out_v0(ex_v0_2), .out_a0(ex_a0_2), .JB(JB));

	load_use i_load_use ( .dst(ex_r2_pos_1), .memRead(ex_signal_1[4]), .R1(id_r1_pos_2), .R2(id_r2_pos_2), .syscall(id_signal_2[15]), .lu(lu) );
        
    buffer EX_MEM (.clk(clk), .en(1'b1), .clr(0), .PC(ex_pc_2), .IR(ex_ir_2), .signal(ex_signal_2), .dst(ex_dst_2), .R1_pos(5'b0), .R2_pos(5'b0),
        .D(0), .R1(0), .R2(ex_r2_2), .ALU_R(ex_r_2), .ext(0), .v0(ex_v0_2), .a0(ex_a0_2),
        .out_PC(mem_pc_1), .out_IR(mem_ir_1), .out_signal(mem_signal_1), .out_dst(mem_dst_1), .out_R1_pos(), .out_R2_pos(),
        .out_D(), .out_R1(), .out_R2(mem_r2_1), .out_ALU_R(mem_r_1), .out_ext(), .out_v0(mem_v0_1), .out_a0(mem_a0_1));
		
	MEM i_MEM ( .clk(clk), .in_pc(mem_pc_1), .in_ir(mem_ir_1), .in_signal(mem_signal_1), .in_dst(mem_dst_1), .in_r2(mem_r2_1), .in_r(mem_r_1), .in_v0(mem_v0_1), .in_a0(mem_a0_1),
		.out_pc(mem_pc_2), .out_ir(mem_ir_2), .out_signal(mem_signal_2), .out_dst(mem_dst_2), .out_d(mem_d_2), .out_r(mem_r_2), .out_v0(mem_v0_2), .out_a0(mem_a0_2), .mem_we(mem_we) );
            
            
    buffer MEM_WB (.clk(clk), .en(1'b1), .clr(0), .PC(mem_pc_2), .IR(mem_ir_2), .signal(mem_signal_2), .dst(mem_dst_2), .R1_pos(5'b0), .R2_pos(5'b0),
        .D(0), .R1(0), .R2(0), .ALU_R(mem_r_2), .ext(0), .v0(mem_v0_2), .a0(mem_a0_2),
        .out_PC(wb_pc_1), .out_IR(wb_ir_1), .out_signal(wb_signal_1), .out_dst(wb_dst_1), .out_R1_pos(), .out_R2_pos(),
        .out_D(wb_d_1), .out_R1(), .out_R2(), .out_ALU_R(wb_r_1), .out_ext(), .out_v0(wb_v0_1), .out_a0(wb_a0_1));
		
	WB i_WB ( .Clock(Clock), .in_pc(wb_pc_1), .in_signal(wb_signal_1), .in_d(wb_d_1), .in_r(wb_r_1),
		.in_v0(wb_v0_1), .in_a0(wb_a0_1), .out_data(wb_data), .out_we(wb_we), .display(display), .clk(clk) );
		
endmodule
