module r200wb(
	clk,
	wbsel,
	dmem_out,
	alu_res,
	pcp4,
	reg_win //instrn [11:7]
);
input wire clk;
//input
input wire [1:0] wbsel;
input wire [31:0] dmem_out;
input wire [31:0] alu_res;
input wire [31:0] pcp4;
//output
output wire [31:0] reg_win;


mux4w32 wbselector( //select which data written into register
	.a(alu_res),
	.b(dmem_out),
	.c(pcp4),
	.sel(wbsel),
	.out(reg_win)
);

endmodule
