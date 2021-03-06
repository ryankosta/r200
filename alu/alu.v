module alu(
a,
b,
operation, //func3 
control, //instr b30; 0 = add, srl; 1 = sub, sra
result,
lt,
ltu
`ifdef ALUDETECT
,
zero,
neg
`endif
);
//input
input wire [31:0] a;
input wire [31:0] b;
input wire lt;
input wire ltu;
input wire control;
input wire [2:0] operation;
//output
output wire [31:0] result;
`ifdef ALUDETECT
output wire zero;
output wire neg;
`endif
//intermediates
wire shiftdir;
wire [31:0] orab;
wire [31:0] notb;
wire [31:0] badd;
wire [31:0] addab; //also used in sub instructions
wire [31:0] andab;
wire [31:0] xorab;
wire [31:0] sltab;
wire [31:0] sltuab;
wire [31:0] ashiftbyb;

not(shiftdir,operation[2]); // op2 == 0 -> shdir = 1 -> shift left; op2 = 1 -> shdir = 0 ->shift right
//operations
//Set less thans
assign sltab[31:1] = 31'b0;
assign sltab[0] = lt;
assign sltuab[31:1] = 31'b0;
assign sltuab[0] = ltu;

or32 orop(orab,a,b);
and32 andop(andab,a,b);
not32 notbop(notb,b);
xor32 xorop(xorab,a,b);
mux2w32 baddselect(
	.a(b),
	.b(notb),
	.sel(control),
	.out(badd)
);
// warning disabled due to unused cout and oflow pins
/* verilator lint_off PINMISSING */
adder32 adder(
	.result(addab),
	.cin(control),
	.a(a),
	.b(badd)
);
/* verilator lint_on PINMISSING */

mshifter32 shifter(
	.out(ashiftbyb),
	.in(a),
	.shiftdir(shiftdir),
	.shiftby(b[4:0]),
	.shifta(control)
);


mux8w32 mux(
	.a(addab),	//000 add/sub
	.b(ashiftbyb),	//001 shift left logical
	.c(sltab),	//010 set less than
	.d(sltuab),	//011 set less than unsigned
	.e(xorab),	//100 a ^ b
	.f(ashiftbyb),	//101 shift right logical/arethmetic
	.g(orab),	//110 a || b
	.h(andab),	//111 a && b

	
	.out(result),
	.sel(operation)
);

`ifdef ALUDETECT
//checks
and32s zerochk(zero,a);
buf(neg,result[31]);
`endif
endmodule
