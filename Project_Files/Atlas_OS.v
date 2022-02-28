module Atlas_OS (
	input fpga_clock,
	input [15:0] entradas,
	output [13:0] display_7s,
	output [31:0] print_zeus
	);



//wire [31:0] print_zeus;


Zeus_Processor Zeus (.clock_FPGA (fpga_clock), .entrada(entradas), .print_dados (print_zeus[7:0]));

Gerenciador_Saidas (.entrada(print_zeus), .saida(display_7s));






endmodule 