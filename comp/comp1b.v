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

xor(xab,a,b);
not(eq,xab);
and(gt,xab,a);
endmodule


