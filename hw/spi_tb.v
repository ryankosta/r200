`include "spi.v"
module spi_tb();
	reg clk;
	reg rst;
	reg we;
	reg [31:0] i_addr;
	reg istb;
	reg [7:0] ctr;
	spi spcont(	.rst (rst),
			.clk (clk),
			.i_stb (istb),
			.i_we (we),
			.i_addr (i_addr),
			.miso (1'b1)
		);
	initial begin
		//wavefile dump
		$dumpfile("test.vcd");
		$dumpvars(0,spcont);
		//variable instantiation
		clk = 0;
		rst = 1;
		#10 rst = 0;
		we = 0;
		i_addr = 32'h80000400;
		istb = 0;
		#30 istb = 1;
		#40 istb = 0;
		//end
		#1000 $finish;
	end
	always begin
		#5 clk = !clk;
	end
endmodule

