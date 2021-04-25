`include "cpu.vh"
module r200(
	clk,
	rst
);
input wire clk;
input wire rst;
//---------instruction fetch
//if input
reg rst;
//if output
wire [31:0] if_instrn;
wire [31:0] if_pc_addrout;
wire [31:0] if_pcp4;
//---------instruction decode
//id input
wire [31:0] id_instrn;
wire [31:0] id_pc_addrout;
wire [31:0] id_pcp4;
//id output
wire id_op1sel;
wire [1:0] id_op2sel;
wire id_funcsel;
wire id_memwr;
wire id_regwr;
wire id_wasel;
wire [1:0] id_wbsel;
wire id_alu_cont;
wire [31:0] id_rs1o;
wire [31:0] id_rs2o;
wire [31:0] id_op1;
wire [31:0] id_op2;
wire [4:0] id_rs2addr;
wire [4:0] id_rdaddr;
wire [31:0] id_pc_brtarg;
wire id_isbr;
wire id_willjmp;
//ex input
wire [31:0] ex_dmem_out;
wire [31:0] ex_immsel;
wire [31:0] ex_op1;
wire [31:0] ex_op2;
wire ex_alu_cont;
wire [2:0] ex_func3;
wire ex_funcsel;
wire ex_isbr;
wire ex_willjmp;
wire [31:0] ex_jump_imm;
wire [31:0] ex_jump_addimm;
//ex output
wire [31:0] ex_alu_res;
wire [31:0] ex_rs2o;
wire ex_memwr;
wire ex_regwr;
wire ex_wasel;
wire [1:0] ex_wbsel;
wire [31:0] ex_pcp4;
wire [4:0] ex_rdaddr;
wire [31:0] ex_jumptarg;
wire [31:0] ex_brtarg;
wire ex_willbr;
//mem input 
wire [31:0] mem_rs2o;
wire mem_memwr;
//mem output 
wire [1:0] mem_wbsel;
wire [31:0] mem_dmem_out;
wire mem_regwr;
wire [31:0] mem_alu_res;
wire [31:0] mem_pcp4;
wire [4:0] mem_rdaddr;
//wb input 
wire [1:0] wb_wbsel;
wire [31:0] wb_dmem_out;
wire [31:0] wb_alu_res;
wire [31:0] wb_pcp4;
wire [4:0] wb_rdaddr;
//wb output
wire [31:0] wb_reg_win;
wire wb_regwr;


//hazard control
wire [2:0] rs1val_cont;
wire [2:0] rs2val_cont;
wire if_id_retire;
wire id_ex_stall;
//pc control
wire [31:0] pcp4_hold;
wire [1:0] pcsel;
//id ops muxd
wire [31:0] id_op1_muxed;
wire [31:0] id_op2_muxed;

r200if ifetch(
	.clk(clk),
	.pc_addrout(if_pc_addrout),
	.instrn(if_instrn),
	.pcp4(if_pcp4),
	.pc_rst(rst),

	.pc_brtarg(id_pc_brtarg),
	.pc_jumptarg(ex_jumptarg),
	.pcp4_hold(pcp4_hold),
	.pcsel(pcsel)
);	
if_id_reg if_id_cont(
	.clk(clk),
	.if_instrn(if_instrn),
	.if_pc_addrout(if_pc_addrout),
	.if_pcp4(if_pcp4),
	.id_instrn(id_instrn),
	.id_pc_addrout(id_pc_addrout),
	.id_pcp4(id_pcp4),
	.retire(if_id_retire)
);
r200id idecode(
	.clk(clk),
	.pc_addrout(id_pc_addrout),
	.instrn(id_instrn),
	.pcp4(id_pcp4),
	.pc_brtarg(id_pc_brtarg),
	.funcsel(id_funcsel),
	.memwr(id_memwr),
	.regwr_out(id_regwr),
	.regwr_in(wb_regwr),
	.wbsel(id_wbsel),
	.isbr(id_isbr),
	.willjmp(id_willjmp),
	.op1(id_op1),
	.op2(id_op2),
	.alu_cont(id_alu_cont),
	.rs1o(id_rs1o),
	.rs2o(id_rs2o),
	.rs2addr(id_rs2addr),
	.rdaddr_out(id_rdaddr),
	.rdaddr_in(wb_rdaddr),
	.reg_win(wb_reg_win)
);
id_ex_reg id_ex_cont(
	.clk(clk),
	.id_funcsel(id_funcsel),
	.id_memwr(id_memwr),
	.id_regwr(id_regwr),
	.id_wasel(id_wasel),
	.id_wbsel(id_wbsel),
	.id_isbr(id_isbr),
	.id_willjmp(id_willjmp),
	.id_op1(id_op1_muxed),
	.id_op2(id_op2_muxed),
	.id_alu_cont(id_alu_cont),
	.id_rs1o(id_rs2o),
	.id_rs2o(id_rs2o),
	.id_rdaddr(id_rdaddr),
	.id_instrn(id_instrn),

	.ex_willjmp(ex_willjmp),
	.ex_funcsel(ex_funcsel),
	.ex_memwr(ex_memwr),
	.ex_regwr(ex_regwr),
	.ex_wasel(ex_wasel),
	.ex_wbsel(ex_wbsel),
	.ex_isbr(ex_isbr),
	.ex_op1(ex_op1),
	.ex_op2(ex_op2),
	.ex_alu_cont(ex_alu_cont),
	.ex_rs1o(ex_rs2o),
	.ex_rs2o(ex_rs2o),
	.ex_rdaddr(ex_rdaddr),
	.ex_func3(ex_func3),
	.rst(rst),
	.stall(id_ex_stall)

);
r200ex execute(
	//in
	.op1(ex_op1),
	.op2(ex_op2),
	.alu_cont(ex_alu_cont),
	.func3(ex_func3),
	//out
	.jump_imm(ex_jump_imm),
	.jump_addimm(ex_jump_addimm),
	.alu_res(ex_alu_res),
	.willbr(ex_willbr),
	.pc_jumptarg(ex_jumptarg)

);
ex_mem_reg ex_mem_cont(
	.clk(clk),
	.ex_alu_res(ex_alu_res),
	.ex_rs2o(ex_rs2o),
	.ex_memwr(ex_memwr),
	.ex_regwr(ex_regwr),
	.ex_wbsel(ex_wbsel),
	.ex_pcp4(ex_pcp4),
	.ex_rdaddr(ex_rdaddr),

	.mem_alu_res(mem_alu_res),
	.mem_rs2o(mem_rs2o),
	.mem_regwr(mem_regwr),
	.mem_memwr(mem_memwr),
	.mem_wbsel(mem_wbsel),
	.mem_pcp4(mem_pcp4),
	.mem_rdaddr(mem_rdaddr)
);
r200mem memwrite(
	.clk(clk),
	.alu_res(mem_alu_res),
	.rs2o(mem_rs2o),
	.memwr(mem_memwr),
	.dmem_out(mem_dmem_out)
);

mem_wb_reg mem_wb_cont(
	.clk(clk),
	.mem_dmem_out(mem_dmem_out),
	.mem_alu_res(mem_alu_res),
	.mem_pcp4(mem_pcp4),
	.mem_wbsel(mem_wbsel),
	.mem_rdaddr(mem_rdaddr),
	.mem_regwr(mem_regwr),

	.wb_dmem_out(wb_dmem_out),
	.wb_alu_res(wb_alu_res),
	.wb_pcp4(wb_pcp4),
	.wb_wbsel(wb_wbsel),
	.wb_rdaddr(wb_rdaddr),
	.wb_regwr(wb_regwr)
);


r200wb writeback(
	.wbsel(wb_wbsel),
	.dmem_out(wb_dmem_out),
	.alu_res(wb_alu_res),
	.pcp4(wb_pcp4),
	.reg_win(wb_reg_win)
);

//hazard control
hazard hazard_cont(
	.id_rs1(id_instrn[19:15]),
	.id_rs2(id_rs2addr),
	.rs1val_cont(rs1val_cont),
	.rs2val_cont(rs2val_cont),
	.ex_rd(ex_rdaddr),
	.ex_wbsel(ex_wbsel),
	.ex_regwr(ex_regwr),

	.mem_rd(mem_rdaddr),
	.mem_wbsel(mem_wbsel),
	.mem_regwr(mem_regwr),

	.wb_rd(wb_rdaddr),
	.wb_wbsel(wb_wbsel),
	.wb_regwr(wb_regwr),
	.stall(id_ex_stall)
);
//PC Control: Generates PC Select Signal
pccont pccontrol(
	.id_jmp(id_willjmp),
	.id_isbr(id_isbr),
	.pcp4(id_pcp4),
	.ex_jmp(ex_willjmp),
	.ex_isbr(ex_isbr),
	.ex_willbr(ex_willbr),
	.pcsel(pcsel),
	.pcp4_hold(pcp4_hold),
	.if_id_retire(if_id_retire),
	.rst(rst)
);
mux8w32 rs1mux(
	.a(id_op1),
	.b(32'b0),
	.c(ex_alu_res),
	.d(32'b0),
	.e(mem_alu_res),
	.f(32'b0),
	.g(wb_alu_res),
	.h(wb_dmem_out),
	.out(id_op1_muxed),

	.sel(rs1val_cont)
);
mux8w32 rs2mux(
	.a(id_op2),
	.b(32'b0),
	.c(ex_alu_res),
	.d(32'b0),
	.e(mem_alu_res),
	.f(32'b0),
	.g(wb_alu_res),
	.h(wb_dmem_out),
	.out(id_op2_muxed),
	.sel(rs2val_cont)
);
endmodule
