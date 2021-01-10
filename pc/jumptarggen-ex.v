`include "cpu.vh"
module jumptarggen_ex(
jumptarg,
immediate,
addtoimm,
);
//output
output wire [31:0] jumptarg;
//input
input wire [31:0] immediate;
input wire [31:0] addtoimm;
adder32 adder(
	.result(jumptarg),
	.cin(1'b0),
	.a(addtoimm),
	.b(immediate)
);
endmodule
