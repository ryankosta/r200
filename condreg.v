module condreg(
	//id
	id_rs1addr,
	id_rs2addr,
	id_rdaddr,
	//ex
	ex_rs1addr,
	ex_rs2addr,
	ex_rdaddr,
	//mem
	mem_rs1addr,
	mem_rs2addr,
	mem_rdaddr,
	mem_alures
	//rb
	rb_rs1addr,
	rb_rs2addr,
	rb_rdaddr,

	//control
	id_halt,
	ex_swap_rs1,
	ex_swap_rs2

);
always @(*)
	if (ex_wbsel == 2'h2 && ((ex_rdaddr == id_rs1addr) || (ex_rdaddr == id_rs2addr))) begin
		id_halt = 1;
	else if (id_rs1addr == ex_rdaddr) begin
		ex_swap_rs1 = 1;
		ex_swap_rs2 = 0;
		id_halt = 0;
	end
	else if (id_rs2addr == ex_rdaddr) begin
		ex_swap_rs1 = 0;
		ex_swap_rs2 = 1;
		id_halt = 0;
	end
	else begin
		ex_swap_rs1 = 0;
		ex_swap_rs2 = 0;
		id_halt = 0;
	end

