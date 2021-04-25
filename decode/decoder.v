//decodes operations
module decoder(
	opcode,
	op1sel, //0 = reg 1 = upperimm
	op2sel, //0 = reg 1 = itypeimm 2 =stypeimm 3 = pc+4
	memwr,
	regwr,
	ra2sel, // rs1 = 0 rd = 1
	wasel, // rd = 0 x1 = 1
	wbsel, // alu = 0 mem = 1 pc+4 = 2
	isbr,
	willjmp
);
input wire [6:0] opcode;
output reg op1sel;
output reg [1:0] op2sel;
output reg ra2sel;
output reg memwr;
output reg regwr;
output reg wasel;
output reg [1:0] wbsel;
output reg isbr;
output reg willjmp;
always @* begin
	case(opcode)
		7'b0110011: //ALU
			begin
			ra2sel = 0; //rs2 addr = rs2 addr	
			op1sel = 0; //op1 = rs1		
			op2sel = 0; //op2 = rs2
			memwr = 0;
			regwr = 1;
			wbsel = 0; //write reg from alu 
			wasel = 0; //write to rd
			isbr = 0;
			willjmp = 0;
			end
		7'b0010011: //ALUi	
			begin
			ra2sel = 0; //rs2 addr = rs2 addr	
			op1sel = 0; //op1 = rs1
			op2sel = 1; //op2 = ity[e o,, 
			memwr = 0;
			regwr = 1;
			wbsel = 0; //write reg from alu 
			wasel = 0; //write to rd
			isbr = 0;
			willjmp = 0;
			end
		7'b1100011: //Branch
			begin
			ra2sel = 0; //rs2 addr = rs2 addr	
			memwr = 0;	
			regwr = 0;
			willjmp = 0;
			isbr = 1;
			end
		7'b0000011: //Load
			begin
			ra2sel = 0; //rs2 addr = rs2 addr	
			op1sel = 0; //op1 = rs1
			op2sel = 1; //op2 = itype imm
			memwr = 0;
			regwr = 1; 
			wbsel = 1; //write from mem to reg
			wasel = 0; //write to rd
			willjmp = 0;
			isbr = 0;
			end	
		7'b0100011: //Store
			begin
			ra2sel = 0; //rs2 addr = rs2 addr	
			op1sel = 0;
			op2sel = 2; //op2 = stype imm
			memwr = 1;
			regwr = 0;
			wbsel = 0; //write from alu to reg 
			wasel = 0; //write to rd
			willjmp = 0;
			isbr = 0;
			end	
		7'b1100111: //Jump and link relative (jalr)
			begin
			ra2sel = 0; //rs2 addr = rs2 addr	
			op1sel = 0;
			memwr = 0;
			regwr = 1;
			wbsel = 2; //write pc+4 to reg
			wasel = 0; //write to rd
			willjmp = 1;
			isbr = 0;
			end
		7'b1101111: //Jump and link (jal)
			begin
			ra2sel = 0; //rs2 addr = rs2 addr	
			op1sel = 0;
			memwr = 0;	
			regwr = 0;	
			wbsel = 2; //write pc+4 to reg
			wasel = 1; //write to x1 reg
			willjmp = 1;
			isbr = 0;
			end
		7'b0110111: //load upper immediate
			begin
			ra2sel = 1; //rs2 addr = rd addr
			op1sel = 1; //upper immediate
			op2sel = 0; //register
			regwr = 1;	
			memwr = 0;	
			wasel = 0; //write to rd reg
			wbsel = 0; //write to reg from alu
			willjmp = 0;
			isbr = 0;
			end
		7'b0010111: //add upper immediate program counter
			begin
			op1sel = 1; //upper immediate
			op2sel = 3; //pc
			regwr = 1;	
			memwr = 0;	
			wasel = 0; //write to rd reg
			wbsel = 0; //write to reg from alu
			willjmp = 0;
			isbr = 0;
			end
		default: //no-op: alu without reg commit
			begin
			ra2sel = 0; //rs2 addr = rs2 addr	
			op1sel = 0; //op1 = rs1		
			op2sel = 0; //op2 = rs2
			memwr = 0;
			regwr = 0;
			wbsel = 0; //write reg from alu 
			wasel = 0; //write to rd
			isbr = 0;
			willjmp = 0;

			end
		
	endcase
end
endmodule
