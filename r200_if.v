module r200if(
	clk,
	pc_addrin,
	pc_addrout,
	pcp4,
	pc_brtarg,
	pc_jumptarg,
	pc_rst,
	pcsel,
	instrn
);
//input
input wire clk;
input wire [31:0] pc_brtarg;
input wire [31:0] pc_jumptarg;
input wire [31:0] pc_addrin;
input wire [1:0] pcsel;
input wire pc_rst; // TODO: leave as reg or not?
//output
output wire [31:0] instrn; // current instruction
output wire [31:0] pc_addrout;
output wire [31:0] pcp4;

pc pcinst( //program counter
	.clk(clk),
	.ain(pc_addrin),
	.aout(pc_addrout),
	.rst(pc_rst)
);
adder32 pcp4add( //pc+4 adder
	.a(pc_addrout),
	.b(32'h4),
	.cin(1'b0),
	.result(pcp4)
);
mem instrnmem( //instruction memory
	.out(instrn),
	.raddr(pc_addrout),
	.memwr(1'b0),
	.clk(clk)
);
mux4w32 pcselector(
	.a(pcp4),
	.b(pc_brtarg),
	.c(pc_jumptarg),
	.out(pc_addrin),
	.sel(pcsel)
);

endmodule
