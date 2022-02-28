module teste_Program_conter_module (input clock, input reset_geral, input modo_preemptivo, 
												input reset_cont_preempcao, input [4:0] quantum, input halt, input [1:0] jump_prog,

												output [31:0] PC, output [31:0] PC_mais_1,
												output flag_faz_preempcao, output [31:0] salva_PC);

												
												
Program_Counter Program_counter_0 (.clock (clock), .PC_in(PC_mais_1), .PC(PC), .PC_mais_1(PC_mais_1), 

		.reset_geral(reset_geral), .reset_cont_preempcao(reset_cont_preempcao), .quantum(quantum), 
		
		.modo_preemptivo(modo_preemptivo), .salva_PC(salva_PC), .flag_faz_preempcao(flag_faz_preempcao), 
		
		.halt(halt), .jump_prog(jump_prog));											
												
												
												
endmodule												