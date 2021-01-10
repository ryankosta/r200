module hazard(
rs1val_cont,	
rs2val_cont,	
id_rs1,
id_rs2,
ex_rd,
ex_wbsel,
ex_regwr,	
mem_regwr,
mem_wbsel,
mem_rd,
wb_regwr,
wb_wbsel,
wb_rd,
stall
);
output reg stall;
//--register source val control (controls ex in source)
//[2:1] FU source
//[0] alu_res(0) or mem(1)
//000 = normal 
//010 = ex_alu_res 
//100 = mem_alu_res
//110 = wb_alu_res
//111 = wb_mem
output reg [2:0] rs1val_cont;
output reg [2:0] rs2val_cont;
//id
input wire [4:0] id_rs1;
input wire [4:0] id_rs2;
//ex
input wire ex_regwr;
input wire [1:0] ex_wbsel;
input wire [4:0] ex_rd;
//mem
input wire mem_regwr;
input wire [1:0] mem_wbsel;
input wire [4:0] mem_rd;
//wb
input wire wb_regwr;
input wire [1:0] wb_wbsel;
input wire [4:0] wb_rd;

always @(*) begin
	if(ex_regwr) begin
		if((id_rs1 == ex_rd)&&(id_rs1 != 5'h0)) begin
			if(ex_wbsel == 2'h0) begin
				rs1val_cont <= 3'b010;
				stall <= 0;
			end
			if(ex_wbsel == 2'h1) begin
				rs1val_cont <= 3'b000;
				stall <= 1;
			end
		end else begin
			rs2val_cont <= 3'b000;
		end
		if((id_rs2 == ex_rd)&&(id_rs1 != 5'h0)) begin
			if(ex_wbsel == 2'h0) begin
				rs2val_cont <= 3'b010;
				stall <= 0;
			end
			if(ex_wbsel == 2'h1) begin
				rs2val_cont <= 3'b000;
				stall <= 1;
			end
		end else begin
			rs2val_cont <=  3'b000; 
		end
	end
	else if(mem_regwr) begin
		if((id_rs1 == mem_rd)&&(id_rs1 != 5'h0)) begin
			if(mem_wbsel == 2'h0) begin
				rs1val_cont <= 3'b100;
				stall <= 0;
			end
			if(mem_wbsel == 2'h1)begin
				rs1val_cont <= 3'b000;
				stall <= 1;
			end
		end else begin
			rs1val_cont <= 3'b000;
		end
		
		
		if((id_rs2 == mem_rd)&&(id_rs1 != 5'h0)) begin
			if(mem_wbsel == 2'h0) begin
			end
				rs1val_cont <= 3'b100;
				stall <= 0;
			if(mem_wbsel == 2'h1) begin
				rs2val_cont <= 3'b000;
				stall <= 1;
			end
		end else begin
			rs2val_cont <= 3'b000;
		end
	end	
	else if(wb_regwr) begin	
		if(id_rs1 == mem_rd) begin
			if(wb_wbsel == 2'h0)
				rs1val_cont <= 3'b110;
				stall <= 0;
			if(wb_wbsel == 2'h1)
				rs1val_cont <= 3'b111;
				stall <= 0;
		end else begin
			rs1val_cont <= 000;
		end
		if(id_rs2 == mem_rd) begin
			if(wb_wbsel == 2'h0)
				rs2val_cont <= 3'b110;
				stall <= 0;
			if(wb_wbsel == 2'h1)
				rs2val_cont <= 3'b111;
				stall <= 0;
		end else begin
			rs2val_cont <= 000;
		end
	end
	else begin
		rs1val_cont = 3'b000;
		rs2val_cont = 3'b000;
		stall = 0; //proceed
	end
end
endmodule
