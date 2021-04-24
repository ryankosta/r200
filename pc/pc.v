module pc(
clk,
ain,
rst,
aout);
//inputs
input clk;
input rst;
input [31:0] ain;
//outputs
output reg [31:0] aout;



always @(posedge clk) begin
	if(rst)
		aout <= 0;
	else
		aout <= ain;
	
end
endmodule
