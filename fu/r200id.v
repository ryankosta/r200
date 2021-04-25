module r200id(
	clk,
	pc_addrout,
	pc_brtarg,
	pcp4,
	instrn,
	memwr,
	regwr_out,
	regwr_in,
	wbsel,
	op1,
	op2,
	alu_cont,
	rs1o,
	rs2o,
	rs2addr,
	rdaddr_in,
	rdaddr_out,
	reg_win,
	isbr,
	willjmp,
	jump_imm,
	jump_addimm
);
//clock
input wire clk;


//-----------Input
//pc wires
input wire [31:0] pc_addrout;
//instruction memory wires
input wire [31:0] instrn; // current instruction

//Reg writeback
input wire [31:0] reg_win; //write in
input wire regwr_in;
input wire [4:0] rdaddr_in;
//pcp4
input wire [31:0] pcp4;
//jumpimm

//----------Output
//pc wires
output wire [31:0] pc_brtarg;
//decoder wires
output wire memwr;
output wire regwr_out;
output wire [1:0] wbsel;
output wire isbr;
output wire willjmp;
//op wires
output wire [31:0] op1;
output wire [31:0] op2;
//alu wires
output wire alu_cont;
//Register file wires
output wire [31:0] rs1o; //rs1 out
output wire [31:0] rs2o; //rs2 out
output wire [4:0] rs2addr; //rs2 addr 
output wire [4:0] rdaddr_out;
//Jump wires
output wire [31:0] jump_imm;
output wire [31:0] jump_addimm; 


//---------Intermediate wires
//decoder intermediate wires
wire [1:0] op2sel;
wire op1sel;
//immediate wires
wire [31:0] imm_stype;
wire [31:0] imm_itype;
wire [31:0] imm_utype;
//write addr select
wire wasel;
//rs2 address selection
wire rs2addrsel;


decoder decoderinst(
	.opcode(instrn[6:0]),
	.ra2sel(rs2addrsel),
	.op1sel(op1sel),
	.op2sel(op2sel),
	.memwr(memwr),
	.regwr(regwr_out),
	.wasel(wasel),
	.wbsel(wbsel),
	.isbr(isbr),
	.willjmp(willjmp)
);	
alucont alucontroller(
	.instrn30(instrn[30]),
	.instrn5(instrn[5]),
	.control(alu_cont)
);
regfile gpr(
	.rs1addr(instrn[19:15]), //rs1 address
	.rs2addr(rs2addr), //rs2 address
	.rdaddr(rdaddr_in), //rd address
	.rs1o(rs1o),
	.rs2o(rs2o),
	.win(reg_win),
	.clk(clk),
	.regwr(regwr_in)
);
isignex isignextender(
	.instrn31_20(instrn[31:20]),
	.itype(imm_itype)
);

ssignex ssignextender(
	.instrn11_7(instrn[11:7]),
	.instrn31_25(instrn[31:25]),
	.stypeimm(imm_stype)
);

jumptarggen_id jumptarggenerator(
	.immediate(jump_imm),
	.addtoimm(jump_addimm),
	.rs1(rs1o),
	.pc(pcp4), //TODO: check if this should be pcp4 or just pc
	.instrn(instrn)
);
branchtarggen brtarggenerator(
	.instrn11_7(instrn[11:7]),
	.instrn31_25(instrn[31:25]),
	.pc(pc_addrout),
	.br(pc_brtarg)
);
utypeimm utypeimmhandle(
	.instrn31_12(instrn[31:12]),
	.imm(imm_utype)
);
mux2w32 op1selector(
	.a(rs1o),
	.b(imm_utype),
	.sel(op1sel),
	.out(op1)
);
mux4w32 op2selector(
	.a(rs2o),
	.b(imm_itype),
	.c(imm_stype),
	.d(pcp4),
	.sel(op2sel),
	.out(op2)
);
mux2w5 rs2addrselector(
	.a(instrn[24:20]), //rs2 address
	.b(instrn[11:7]), //rd address
	.out(rs2addr),
	.sel(rs2addrsel)
);
mux2w5 waselector( //reg addr to write to
	.a(instrn[11:7]), //rd normal address
	.b(5'h1), //x1 00001
	.sel(wasel),
	.out(rdaddr_out)
);


endmodule
