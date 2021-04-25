module comp1b(
gt,
eq,
a,
b
);
//inputs
input wire a;
input wire b;
output wire gt;
//outputs
output wire eq;
//intermediates
wire xab;
wire ge; //greater than or equal to

xor(xab,a,b);
not(eq,xab);
and(gt,xab,a);
or(ge,gt,eq);
endmodule


