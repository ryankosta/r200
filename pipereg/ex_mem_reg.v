`include "cpu.vh"
module ex_mem_reg(
	clk,
	//ex
	ex_alu_res,
	ex_rs2o,
	ex_memwr,
	ex_wbsel,
	ex_pcp4,
	ex_rdaddr,

	//mem
	mem_alu_res,
	mem_rs2o,
	mem_memwr,
	mem_wbsel,
	mem_pcp4,
	mem_rdaddr

);
input wire clk;
//input wires
input wire [31:0] ex_rs2o; 
input wire [31:0] ex_alu_res;
input wire ex_memwr;
input wire [1:0] ex_wbsel;
input wire [31:0] ex_pcp4;
input wire [4:0] ex_rdaddr;
//output registers

output reg [31:0] mem_rs2o; 
output reg [31:0] mem_alu_res;
output reg mem_memwr;
output reg [1:0] mem_wbsel;
output reg [31:0] mem_pcp4;
output reg [4:0] mem_rdaddr;


always @(posedge clk) begin
	mem_rs2o <= ex_rs2o;
	mem_alu_res <= ex_alu_res;
	mem_memwr <= ex_memwr;
	mem_wbsel <= ex_wbsel;
	mem_pcp4 <= ex_pcp4;
	mem_rdaddr <= ex_rdaddr;
end



endmodule
