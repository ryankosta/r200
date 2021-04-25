module jumptarggen_ex(
jumptarg,
immediate,
addtoimm
);
//output
output wire [31:0] jumptarg;
//input
input wire [31:0] immediate;
input wire [31:0] addtoimm;
// warning disabled due to unused oflow and cout signals
/* verilator lint_off PINMISSING */
adder32 adder(
	.result(jumptarg),
	.cin(1'b0),
	.a(addtoimm),
	.b(immediate)
);
/* verilator lint_on PINMISSING */
endmodule
