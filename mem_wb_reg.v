module mem_wb_reg(
	clk,
	mem_wbsel,
	mem_dmem_out,
	mem_alu_res,
	mem_pcp4,
	mem_rdaddr, 

	wb_wbsel,
	wb_dmem_out,
	wb_alu_res,
	wb_pcp4,
	wb_rdaddr

);
//clock
input wire clk;
//output
output reg [1:0] wb_wbsel;
output reg [31:0] wb_dmem_out;
output reg [31:0] wb_alu_res;
output reg [31:0] wb_pcp4;
output reg [4:0] wb_rdaddr;


//input
input wire [1:0] mem_wbsel;
input wire [31:0] mem_dmem_out;
input wire [31:0] mem_alu_res;
input wire [31:0] mem_pcp4;
input wire [4:0] mem_rdaddr;


always @(posedge clk) begin
	wb_dmem_out <= mem_dmem_out;
	wb_alu_res <= mem_alu_res;
	wb_pcp4 <= mem_pcp4;
	wb_wbsel <= mem_wbsel;
	wb_rdaddr <= mem_rdaddr;
end

endmodule
