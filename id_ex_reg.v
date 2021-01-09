module id_ex_reg(
	//clk
	clk,
	//id
	id_funcsel,
	id_memwr,
	id_regwr,
	id_wasel,
	id_wbsel,
	id_pcsel,
	id_op1,
	id_op2,
	id_alu_cont,
	id_rs2o,
	id_dmem_out,
	id_rs2addr,
	id_instrn,
	//ex
	ex_funcsel,
	ex_memwr,
	ex_regwr,
	ex_wasel,
	ex_wbsel,
	ex_op1,
	ex_op2,
	ex_alu_cont,
	ex_rs1o,
	ex_rs2o,
	ex_dmem_out,
	ex_rs2addr,
	ex_func3,
	//stall
	stall

);
//----------Output
//decoder wires
output reg ex_funcsel;
output reg ex_memwr;
output reg ex_regwr;
output reg ex_wasel;
output reg [1:0] ex_wbsel;
//op wires
output reg [31:0] ex_op1;
output reg [31:0] ex_op2;
//alu wires
output reg ex_alu_cont;
//Register file wires
output reg [31:0] ex_rs1o; //rs1 out
output reg [31:0] ex_rs2o; //rs2 out
output reg [4:0] ex_rs2addr; //rs2 addr 
//data memory wires
output reg [31:0] ex_dmem_out;
//func3
output reg [2:0] ex_func3;
//----------Input
//clock
input wire clk;
//pc wires
input wire [31:0] id_pc_brtarg;
input wire [31:0] id_instrn;
//decoder wires
input wire id_funcsel;
input wire id_memwr;
input wire id_regwr;
input wire id_wasel;
input wire [1:0] id_wbsel;
input wire [1:0] id_pcsel;
//op wires
input wire [31:0] id_op1;
input wire [31:0] id_op2;
//alu wires
input wire id_alu_cont;
//Register file wires
input wire [31:0] id_rs1o; //rs1 out
input wire [31:0] id_rs2o; //rs2 out
input wire [4:0] id_rdaddr; //rs2 addr 
//data memory wires
input wire [31:0] id_dmem_out;

input wire [4:0] id_rs2addr; //rs2 addr 
//stall logic
input wire stall;
reg stalldata; //if stalldata is valid
//stall data
reg [31:0] stall_rs2o; //rs2 out
reg [31:0] stall_op1; //rs2 out
reg [31:0] stall_op2; //rs2 out
reg [4:0] stall_rdaddr; //rdaddr
reg stall_funcsel;
reg stall_alu_cont;
reg stall_memwr;
reg stall_regwr;
reg stall_func3;

always @(posedge clk) begin
	if(stalldata)
		stalldata <= 0;
	if(!stall & !stalldata) begin
	ex_funcsel <= id_funcsel;
	ex_memwr <= id_memwr;
	ex_regwr <= id_regwr;
	ex_wasel <= id_wasel;
	ex_wbsel <= id_wbsel;
	ex_op1 <= id_op1;
	ex_op2 <= id_op2;
	ex_alu_cont <= id_alu_cont;
	ex_rs1o <= id_rs1o;
	ex_rs2o <= id_rs2o;
	ex_func3 <= id_instrn[14:12]; //id's rdaddr_out
	end
	else if(stall & !stalldata) begin
		stall_funcsel <= id_funcsel;
		stall_memwr <= id_memwr;
		stall_regwr <= id_regwr;
		stall_op1 <= id_op1;
		stall_op2 <= id_op2;
		stall_alu_cont <= id_alu_cont;
		stall_rs2o <= id_rs2o;
		stall_func3 <= id_instrn[14:12]; //id's rdaddr_out
		stalldata <= 1;
	end
	else if(!stall & stalldata) begin
		ex_funcsel <= stall_funcsel;
		ex_memwr <= stall_memwr;
		ex_regwr <= stall_regwr;
		ex_op1 <= stall_op1;
		ex_op2 <= stall_op2;
		ex_alu_cont <= stall_alu_cont;
		ex_rs2o <= stall_rs2o;
		ex_func3 <= stall_func3;
	end
	if(stall) begin
		ex_funcsel <= 0;
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
