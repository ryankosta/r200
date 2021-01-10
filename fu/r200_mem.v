module r200mem(
	alu_res,
	rs2o,
	memwr,
	dmem_out,
	clk
);
//input wires
input wire clk;
input wire [31:0] rs2o; 
input wire [31:0] alu_res;
input wire memwr;
//output wires
output wire [31:0] dmem_out;



dmemnclk datamem(
	.out(dmem_out),
	.raddr(alu_res),
	.waddr(alu_res),
	.in(rs2o),
	.memwr(memwr),
	.clk(clk)
);

endmodule
