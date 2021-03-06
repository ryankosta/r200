module shifter(
out,
in,
shiftdir, //0 shift right 1 shift left 
shift //0 outputs input 1 shifts 
);
//input
input [31:0] in;
input shift;
input shiftdir;
//output
output [31:0] out;
//intermediate
wire notshiftdir;
wire outleft [31:0];
wire outright [31:0];
wire outshift [31:0];
not(notshiftdir,shiftdir);
buf(outleft[0],0);
and(outleft[1],in[0],shiftdir);
and(outleft[2],in[1],shiftdir);
and(outleft[3],in[2],shiftdir);
and(outleft[4],in[3],shiftdir);
and(outleft[5],in[4],shiftdir);
and(outleft[6],in[5],shiftdir);
and(outleft[7],in[6],shiftdir);
and(outleft[8],in[7],shiftdir);
and(outleft[9],in[8],shiftdir);
and(outleft[10],in[9],shiftdir);
and(outleft[11],in[10],shiftdir);
and(outleft[12],in[11],shiftdir);
and(outleft[13],in[12],shiftdir);
and(outleft[14],in[13],shiftdir);
and(outleft[15],in[14],shiftdir);
and(outleft[16],in[15],shiftdir);
and(outleft[17],in[16],shiftdir);
and(outleft[18],in[17],shiftdir);
and(outleft[19],in[18],shiftdir);
and(outleft[20],in[19],shiftdir);
and(outleft[21],in[20],shiftdir);
and(outleft[22],in[21],shiftdir);
and(outleft[23],in[22],shiftdir);
and(outleft[24],in[23],shiftdir);
and(outleft[25],in[24],shiftdir);
and(outleft[26],in[25],shiftdir);
and(outleft[27],in[26],shiftdir);
and(outleft[28],in[27],shiftdir);
and(outleft[29],in[28],shiftdir);
and(outleft[30],in[29],shiftdir);
and(outleft[31],in[30],shiftdir);

and(outright[0],in[1],notshiftdir);
and(outright[1],in[2],notshiftdir);
and(outright[2],in[3],notshiftdir);
and(outright[3],in[4],notshiftdir);
and(outright[4],in[5],notshiftdir);
and(outright[5],in[6],notshiftdir);
and(outright[6],in[7],notshiftdir);
and(outright[7],in[8],notshiftdir);
and(outright[8],in[9],notshiftdir);
and(outright[9],in[10],notshiftdir);
and(outright[10],in[11],notshiftdir);
and(outright[11],in[12],notshiftdir);
and(outright[12],in[13],notshiftdir);
and(outright[13],in[14],notshiftdir);
and(outright[14],in[15],notshiftdir);
and(outright[15],in[16],notshiftdir);
and(outright[16],in[17],notshiftdir);
and(outright[17],in[18],notshiftdir);
and(outright[18],in[19],notshiftdir);
and(outright[19],in[20],notshiftdir);
and(outright[20],in[21],notshiftdir);
and(outright[21],in[22],notshiftdir);
and(outright[22],in[23],notshiftdir);
and(outright[23],in[24],notshiftdir);
and(outright[24],in[25],notshiftdir);
and(outright[25],in[26],notshiftdir);
and(outright[26],in[27],notshiftdir);
and(outright[27],in[28],notshiftdir);
and(outright[28],in[29],notshiftdir);
and(outright[29],in[30],notshiftdir);
and(outright[30],in[31],notshiftdir);
buf(outright[31],0);
or(outshift[0],outright[0],outleft[0]);
or(outshift[1],outright[1],outleft[1]);
or(outshift[2],outright[2],outleft[2]);
or(outshift[3],outright[3],outleft[3]);
or(outshift[4],outright[4],outleft[4]);
or(outshift[5],outright[5],outleft[5]);
or(outshift[6],outright[6],outleft[6]);
or(outshift[7],outright[7],outleft[7]);
or(outshift[8],outright[8],outleft[8]);
or(outshift[9],outright[9],outleft[9]);
or(outshift[10],outright[10],outleft[10]);
or(outshift[11],outright[11],outleft[11]);
or(outshift[12],outright[12],outleft[12]);
or(outshift[13],outright[13],outleft[13]);
or(outshift[14],outright[14],outleft[14]);
or(outshift[15],outright[15],outleft[15]);
or(outshift[16],outright[16],outleft[16]);
or(outshift[17],outright[17],outleft[17]);
or(outshift[18],outright[18],outleft[18]);
or(outshift[19],outright[19],outleft[19]);
or(outshift[20],outright[20],outleft[20]);
or(outshift[21],outright[21],outleft[21]);
or(outshift[22],outright[22],outleft[22]);
or(outshift[23],outright[23],outleft[23]);
or(outshift[24],outright[24],outleft[24]);
or(outshift[25],outright[25],outleft[25]);
or(outshift[26],outright[26],outleft[26]);
or(outshift[27],outright[27],outleft[27]);
or(outshift[28],outright[28],outleft[28]);
or(outshift[29],outright[29],outleft[29]);
or(outshift[30],outright[30],outleft[30]);
or(outshift[31],outright[31],outleft[31]);

and(out[0],outshift[0],shift);
and(out[1],outshift[1],shift);
and(out[2],outshift[2],shift);
and(out[3],outshift[3],shift);
and(out[4],outshift[4],shift);
and(out[5],outshift[5],shift);
and(out[6],outshift[6],shift);
and(out[7],outshift[7],shift);
and(out[8],outshift[8],shift);
and(out[9],outshift[9],shift);
and(out[10],outshift[10],shift);
and(out[11],outshift[11],shift);
and(out[12],outshift[12],shift);
and(out[13],outshift[13],shift);
and(out[14],outshift[14],shift);
and(out[15],outshift[15],shift);
and(out[16],outshift[16],shift);
and(out[17],outshift[17],shift);
and(out[18],outshift[18],shift);
and(out[19],outshift[19],shift);
and(out[20],outshift[20],shift);
and(out[21],outshift[21],shift);
and(out[22],outshift[22],shift);
and(out[23],outshift[23],shift);
and(out[24],outshift[24],shift);
and(out[25],outshift[25],shift);
and(out[26],outshift[26],shift);
and(out[27],outshift[27],shift);
and(out[28],outshift[28],shift);
and(out[29],outshift[29],shift);
and(out[30],outshift[30],shift);
and(out[31],outshift[31],shift);



endmodule
