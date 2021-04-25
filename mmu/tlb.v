module tlb(
	input clk;
	input wire i_req,
	input wire [9:0] i_vpn[1:0],
	input wire [31:0] i_pte,
	input wire i_walk_v,
	output reg [31:0] o_pte,
	output reg o_v,
	output reg o_walkreq
)
reg [31:0] tlb[7:0];
reg [4:0] firstfilled = 0; //first filled spot in tlb
wire tlb_hit[7:0];
assign wire tlb_hit[0] = tlb[0] == {i_vpn[1],i_vpn[0]};
assign wire tlb_hit[1] = tlb[1] == {i_vpn[1],i_vpn[0]};
assign wire tlb_hit[2] = tlb[2] == {i_vpn[1],i_vpn[0]};
assign wire tlb_hit[3] = tlb[3] == {i_vpn[1],i_vpn[0]};
assign wire tlb_hit[4] = tlb[4] == {i_vpn[1],i_vpn[0]};
assign wire tlb_hit[5] = tlb[5] == {i_vpn[1],i_vpn[0]};
assign wire tlb_hit[6] = tlb[6] == {i_vpn[1],i_vpn[0]};
assign wire tlb_hit[7] = tlb[7] == {i_vpn[1],i_vpn[0]};
assign wire o_v == (i_req && (i_walk_v ||(tlb_hit != 0))); 
always @(posedge clk) begin
	if(first_filled == 8) begin
		first_filled = 0;
	end
end
always @(posedge clk) begin
	if(i_walk_v) begin
		o_pte = i_pte;
		tlb[firstfilled] = i_pte; 
		firstfilled++;
	end
	else if(tlb_hit != 0) begin	
		if(tlb_hit[0]) begin
			o_pte = tlb[0];
		end
		if(tlb_hit[1]) begin
			o_pte = tlb[1];
		end
		if(tlb_hit[2]) begin

			o_pte = tlb[2];
		end
		if(tlb_hit[3]) begin

			o_pte = tlb[3];
		end
		if(tlb_hit[4]) begin
			o_pte = tlb[4];
		end
		if(tlb_hit[5]) begin
			o_pte = tlb[5];
		end
		if(tlb_hit[6]) begin
			o_pte = tlb[6];
		end
		if(tlb_hit[7])begin
			o_pte = tlb[7];
		end
	end
	else begin
		o_v = 0;
	end
end
`ifdef FORMAL
as
`endif
