`include "r200.v"
module r200_tb;

reg clock;
reg waddr;


initial begin
		$display("time\t       cpu");
		clock = 1;
		waddr = 0;
		
//        	instrn = (32'b0010011); //alui instruction
//        	instrn = instrn | (32'd3 << 7); //rd = x3
//        	instrn = instrn | (32'b110 << 12); // add
//        	instrn = instrn | (32'h0 << 15); //rs = x3
//        	instrn = instrn | (32'd12 << 20); //imm = 12
		$readmemh("/home/rkosta/dev/verilog/r200/asm/curr.8b.hex",cpu.ifetch.instrnmem.ram);
		#9 cpu.if_pc_rst = 1;
		#14 cpu.if_pc_rst = 0;


//		cpu.instrnmem.ram[waddr] <= instrn[7:0];
//		cpu.instrnmem.ram[waddr+1] <= instrn[15:8];
//		cpu.instrnmem.ram[waddr+2] <= instrn[23:16];
//		cpu.instrnmem.ram[waddr+3] <= instrn[31:24];




		#1280 begin 
		$finish;
		end

end
//clock gen
always begin
	#10 begin
	       	clock = ~clock; //toggle clock every 5 ticks
	end
end

r200 cpu(clock);
endmodule
