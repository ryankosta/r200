module pccont(
	id_jmp,
	id_isbr,
	ex_jmp,
	ex_isbr,
	ex_willbr,
	pcsel,
	pcp4_hold,
	pcp4,
	if_id_stall

);
input wire [31:0] pcp4;
output reg [1:0] pcsel;
output reg [31:0] pcp4_hold;
output reg if_id_stall; //retire instruction passed into if/id reg at next posedge clk
always @(*) begin
	if(id_jmp) begin
		if_id_retr <= 1;
	end
	else if(id_isbr) begin
		if_id_retr <= 1;
		pcsel <= 1; //specutively branch
		pcp4_hold <= pcp4; //hold pcp4 incase code doesnt branch 
	end
	else if(ex_isbr) begin
		if(ex_willbr) begin
			if_id_retr <= 0; //since specutively branched current instruction in IF is valid
			pcsel <= 0; //since branch addr already set in previous stage
		end	
		else begin
			if_id_retr <= 1;
			pcsel <= 3; //pc = pchold
		end	
	end
	else if(ex_isjmp) begin
		if_id_retr <= 1;
		pcsel <= 2;
	end
	else begin
		if_id_retr <= 0;
		pcsel <= 0;
	end
end
endmodule

