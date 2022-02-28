module Banco_Registradores (endereco_leitura_1, endereco_leitura_2, endereco_escrita, Rs, Rt, Rd, escrever_dados, Reg_Write, clock);

	input [4:0] endereco_leitura_1;
	input [4:0] endereco_leitura_2;
	input [4:0] endereco_escrita;
	input [31:0] escrever_dados;
	input Reg_Write;
	input clock;
	
	output [31:0] Rs;
	output [31:0] Rt;
	output [31:0] Rd;
	
	reg [31:0] registers [31:0]; // declarando 32 registradores com 32 bits em cada um
	
	always @ (posedge clock) begin
	
		if (Reg_Write == 1)
	
			registers[endereco_escrita] = escrever_dados;
	
	end
	
	assign Rs = registers[endereco_leitura_1];
	assign Rt = registers[endereco_leitura_2];
	assign Rd = registers[endereco_escrita];
	
	
endmodule 