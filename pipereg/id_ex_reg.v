module id_ex_reg(
	//clk
	clk,
	rst,
	//id
	id_memwr,
	id_regwr,
	id_wbsel,
	id_isbr,
	id_willjmp,
	id_op1,
	id_op2,
	id_alu_cont,
	id_rs1o,
	id_rs2o,
	id_rdaddr,
	id_instrn,
	id_jmp_imm,
	id_jmp_addimm,
	//ex
	ex_memwr,
	ex_regwr,
	ex_wbsel,
	ex_isbr,
	ex_willjmp,
	ex_op1,
	ex_op2,
	ex_alu_cont,
	ex_rs1o,
	ex_rs2o,
	ex_rdaddr,
	ex_func3,
	ex_jmp_imm,
	ex_jmp_addimm,
	//stall
	stall

);
//----------Output
//decoder wires
output reg ex_memwr;
output reg ex_regwr;
output reg [1:0] ex_wbsel;
//op wires
output reg [31:0] ex_op1;
output reg [31:0] ex_op2;
//alu wires
output reg ex_alu_cont;
//Register file wires
output reg [31:0] ex_rs1o; //rs1 out
output reg [31:0] ex_rs2o; //rs2 out
output reg [4:0] ex_rdaddr; //rs2 addr 
//data memory wires
//func3
output reg [2:0] ex_func3;
//Jump target generation
output reg [31:0] ex_jmp_imm;
output reg [31:0] ex_jmp_addimm;
//pc wires
output reg ex_isbr;
output reg ex_willjmp;
//----------Input
//clock
input wire clk;
//pc wires
input wire [31:0] id_instrn;
//decoder wires
input wire id_memwr;
input wire id_regwr;
input wire [1:0] id_wbsel;
//op wires
input wire [31:0] id_op1;
input wire [31:0] id_op2;
//alu wires
input wire id_alu_cont;
//Register file wires
input wire [31:0] id_rs1o; //rs1 out
input wire [31:0] id_rs2o; //rs2 out
//data memory wires
input wire [4:0] id_rdaddr; //rs2 addr 
//Jump target generation
input wire [31:0] id_jmp_imm;
input wire [31:0] id_jmp_addimm;
//pc wires
input wire id_isbr;
input wire id_willjmp;


//stall logic
input wire stall;
input wire rst;
reg stalldata; //if stalldata is valid
//---stall data
reg [31:0] stall_rs2o; //rs2 out
reg [31:0] stall_op1; //rs2 out
reg [31:0] stall_op2; //rs2 out
reg [4:0] stall_rdaddr; //rdaddr
reg stall_alu_cont;
reg stall_memwr;
reg stall_regwr;
reg [2:0] stall_func3;
//pc control
reg stall_isbr;
reg stall_willjmp;
//jump target generation 
reg [31:0] stall_jmp_imm;
reg [31:0] stall_jmp_addimm;
always @(posedge clk) begin
	if (rst) begin
		stalldata <= 0;
	end
	else if(!stall & !stalldata) begin
	ex_isbr <= id_isbr;
	ex_willjmp <= id_willjmp;
	ex_memwr <= id_memwr;
	ex_regwr <= id_regwr;
	ex_wbsel <= id_wbsel;
	ex_rdaddr <= id_rdaddr;
	ex_op1 <= id_op1;
	ex_op2 <= id_op2;
	ex_alu_cont <= id_alu_cont;
	ex_rs1o <= id_rs1o;
	ex_rs2o <= id_rs2o;
	ex_func3 <= id_instrn[14:12]; //id's rdaddr_out
	ex_jmp_imm <= id_jmp_imm;
	ex_jmp_addimm <= id_jmp_addimm;
	end
	else if(stall & !stalldata) begin
		stall_isbr <= id_isbr;
		stall_willjmp <= id_willjmp;
		stall_jmp_imm <= id_jmp_imm;
		stall_jmp_addimm <= id_jmp_imm;
		stall_memwr <= id_memwr;
		stall_regwr <= id_regwr;
		stall_op1 <= id_op1;
		stall_op2 <= id_op2;
		stall_alu_cont <= id_alu_cont;
		stall_rs2o <= id_rs2o;
		stall_rdaddr <= id_rdaddr; 
		stall_func3 <= id_instrn[14:12]; //id's rdaddr_out
		stalldata <= 1;
	end
	else if(!stall & stalldata) begin
		ex_memwr <= stall_memwr;
		ex_regwr <= stall_regwr;
		ex_op1 <= stall_op1;
		ex_op2 <= stall_op2;
		ex_alu_cont <= stall_alu_cont;
		ex_rs2o <= stall_rs2o;
		ex_func3 <= stall_func3;
		ex_isbr <= stall_isbr;
		ex_rdaddr <= stall_rdaddr;
		ex_willjmp <= stall_willjmp;
		ex_jmp_imm <= stall_jmp_imm;
		ex_jmp_addimm <= stall_jmp_addimm;
		stalldata <= 0;
	end
	if(stall) begin
		ex_memwr <= 0;
		ex_regwr <= 1;
		ex_op1 <= 0;
		ex_op2 <= 0;
		ex_alu_cont <= 0;
		ex_func3 <= 0;
		ex_rs2o <= 0;
	end


end




endmodule
