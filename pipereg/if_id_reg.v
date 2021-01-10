module if_id_reg(
	//clock
	clk,
	//instruction fetch
	if_instrn,
	if_pc_addrout,
	if_pcp4,
	//instruuction decode
	id_instrn,
	id_pc_addrout,
	id_pcp4,
	retire
);
//clock
input wire clk;
//output wires from if
input wire [31:0] if_instrn; // current instruction
input wire [31:0] if_pc_addrout;
input wire [31:0] if_pcp4;
//stall input wire
input wire retire;

//output registers to id 
output reg [31:0] id_instrn;
output reg [31:0] id_pc_addrout;
output reg [31:0] id_pcp4;
always @(posedge clk) begin
	if(retire) begin 
	id_instrn <= 32'h00000033; //nop add x0, x0, x0 
	end
       	else begin
	id_instrn <= if_instrn;
	end
	id_pc_addrout <= if_pc_addrout;
	id_pcp4 <= if_pcp4;
end


endmodule
