module spi (
	//clk and rst
	rst,
	clk,
	//WB bus
	i_stb,
	i_addr,
	i_we,
	o_data,
	o_ack,
	o_stall,
	//SPI
	cs,
	sck,
	mosi,
	miso
);
//clock and reset
input wire clk;
input wire rst;
//WB bus
input wire i_stb;
input wire [31:0] i_addr;
input wire i_we;
output reg [31:0] o_data;
output reg o_ack;
output reg o_stall;
//SPI
output wire cs;
output wire sck;
output reg mosi;
input wire miso;
//Internal
reg [7:0] ctr;
reg [7:0] cmd;
reg [31:0] addr;

reg isw;
//Assigns
//TODO: split cmd reg into sections to avoid errors
assign sck = clk & !cs;
assign addrhit = i_addr[31:16] == 16'h8000; //address is intended for module
assign cs = !(ctr == 0);

//drives: ctr
always @(posedge clk) begin
	if(rst) begin
		ctr <= 0;
	end
	else if(i_stb) begin
			ctr <= 8'd73; //8 + 32 + 32 + 1
	end
	else if (ctr != 0) begin
		ctr <= ctr - 1;
	end
end
//drives: mosi, lower cmd reg
always @(posedge clk) begin

	if(i_stb) begin
		if((!i_we)& addrhit) begin
			addr <= i_addr;
			cmd <= 8'h03;
			isw = 0;
		end
		mosi <= 1;
	end
	else if(ctr == 73) begin	 
		mosi <= 0;
	end
	else if(ctr > 64) begin
		mosi <= cmd[ctr-65]; 
	end
	else if(ctr > 32) begin

		mosi <= addr[ctr-33];
	end
	else if (ctr > 0) begin 
		if(isw) begin
			mosi <= o_data[ctr-1]; 
		end
		else begin 
			o_data[ctr-1] <= miso;
		end
	end
end
//drives: o_stall, o_ack
always @(posedge clk) begin
	if(i_stb) begin
		o_stall <= 1;
	end
	else if((ctr == 0)) begin
		if(o_stall) begin
			o_stall <= 0;
			o_ack <= 1;
		end
	       	else begin
			o_ack <= 0;
		end
	end
	
end
endmodule
