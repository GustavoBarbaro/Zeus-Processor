// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// separate read/write clocks

module Memoria_de_Dados
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, endereco_escrita,
	input Mem_Write, Mem_Read, read_clock, write_clock,
	output reg [(DATA_WIDTH-1):0] lendo_dados
);
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	always @ (posedge write_clock)
	begin
		// Write
		if (Mem_Write) //exemplo : sw (store word)
			ram[endereco_escrita] <= data;
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		if (Mem_Read) //exemplo : lw (load word)
			lendo_dados <= ram[read_addr];
	end
	
endmodule
