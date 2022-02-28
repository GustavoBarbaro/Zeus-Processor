module Gerenciador_de_Preempcao (input flag_faz_preempcao, input [1:0] jump_prog, output reg tem_desloc_PC, output reg tem_desloc_MD,

											output reg [31:0] base_to_desloc_PC, output reg [31:0] base_to_desloc_MD,
											
											output reg reset_geral, output reg [4:0] quantum);

											
	//para a Mem de instrucoes
	
	reg [31:0] base_P1_MI;
	reg [31:0] base_P2_MI;
	

	//para a Mem de Dados
	
	reg [31:0] base_P1_MD;
	reg [31:0] base_P2_MD;
	
		
	
	initial begin
	
		//porque assim as chaves do mux vao selecionar apenas pro primeiro bloco de codigo (SO)
		tem_desloc_PC = 0;
		tem_desloc_MD = 0;
		
		//slots da memoria de dados para os processos 1 e 2
		base_P1_MD = 84;
		base_P2_MD = 164;
		
		//limites dentro da memoria de instrucoes
		base_P1_MI = 147;
		base_P2_MI = 184;
		
		//definindo o quantum
		quantum = 30;
	
	end
	
	
	
	
	always @ (*) begin
	
		if (flag_faz_preempcao == 1) begin //volte para o SO (teve preemp ou viu um HALT)
		
			tem_desloc_PC = 0;
			tem_desloc_MD = 0;
			
			//reset_geral = 1; //por enquanto nao estou mais usando
		
		end
		
		if (jump_prog == 1) begin //pule para o programa 1
		
			
			base_to_desloc_PC = base_P1_MI;
			base_to_desloc_MD = base_P1_MD;
			
			tem_desloc_PC = 1;
			tem_desloc_MD = 1;
			
			reset_geral = 1;
			
		
		end
		
		if (jump_prog == 2) begin //pule para o programa 2
		
			base_to_desloc_PC = base_P2_MI;
			base_to_desloc_MD = base_P2_MD;
			
			tem_desloc_PC = 1;
			tem_desloc_MD = 1;
			
			reset_geral = 1;
			
		
		end
		
	end
	

endmodule 