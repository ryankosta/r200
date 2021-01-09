`include "cpu.vh"
module r200ex(
	op1,
	op2,
	alu_cont,
	func3,
	jump_imm,
	jump_addimm,
	pc_jumptarg,
	alu_res
);
//----------Input
input wire [31:0] op1;
input wire [31:0] op2;
input wire alu_cont;
input wire [2:0] func3; //instrn [14:12]
input wire [31:0] jump_imm; 
input wire [31:0] jump_addimm; 
//----------Output
output wire [31:0] alu_res;
output wire [31:0] pc_jumptarg;
//----------Intermediates
//comparitor wires
wire comp_eq;
wire comp_ne;
wire comp_lt;
wire comp_ge;
wire comp_ltu;
//alu wires
wire alu_0;
wire alu_neg;




alu aluinst(
	.a(op1),
	.b(op2),
	.operation(func3), //func3
	.control(alu_cont),
	.result(alu_res),
	.lt(comp_lt),
	.ltu(comp_ltu),
	.zero(alu_0),
	.neg(alu_neg)
);
jumptarggen_ex jumptarggenerator(
	.jumptarg(pc_jumptarg),
	.immediate(jump_imm),
	.addtoimm(jump_addimm)
);
condgen comparitor(
	.a(op1),
	.b(op2),
	.eq(comp_eq),
	.ne(comp_ne),
	.lt(comp_lt),
	.ge(comp_ge),
	.ltu(comp_ltu),
	.geu(comp_geu)
);
condsel branchsel(
	.eq(comp_eq),
	.ne(comp_ne),
	.lt(comp_lt),
	.ge(comp_ge),
	.ltu(comp_ltu),
	.geu(comp_geu),
	.sel(func3),
	.out(branchif)
);

endmodule
