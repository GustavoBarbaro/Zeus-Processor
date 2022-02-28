module Program_Counter (input clock, input [31:0] PC_in, input reset_geral, input modo_preemptivo, 
								input reset_cont_preempcao, input [4:0] quantum, input halt, input [1:0] jump_prog,

								output reg [31:0] PC, output reg [31:0] PC_mais_1, output reg [31:0] cont_preempcao,
								output reg flag_faz_preempcao, output reg [31:0] salva_PC);

	

	
	
	initial begin
	
		PC = 0;
		PC_mais_1 = 1;
		cont_preempcao = 0;
		flag_faz_preempcao = 0;
	
	end
	
	
	

	always @ (posedge clock)
	begin
		
		if (halt == 1) begin
			
			salva_PC = PC; //salvando para saber onde voltar dps da preemp
			flag_faz_preempcao = 1; //ativa a flag
			
			PC = 3; //PC = numero da linha que eu desejo voltar para o SO
			cont_preempcao = 0;
			
		end
		
		if (reset_geral == 1)begin
						
			PC = 0;
			PC_mais_1 = 1;
			cont_preempcao = 0;
			
		end
		else begin
		
			if (modo_preemptivo == 0)begin //modo sequencial SEM preempcao
			
				PC = PC_in;
				PC_mais_1 = PC + 1;
				
			end
			
			else begin //modo COM preempcao 
			
				PC = PC_in;
				PC_mais_1 = PC + 1;
				cont_preempcao = cont_preempcao + 1;
				
				//apenas faca a preempcao se nao for o SO que estiver executando
				if (cont_preempcao == quantum && (jump_prog == 1 || jump_prog == 2))begin //bateu o quantum
					
					salva_PC = PC; //salvando para saber onde voltar dps da preemp
					flag_faz_preempcao = 1; //ativa a flag
					
					PC = 3; //PC = numero da linha que eu desejo voltar para o SO
					cont_preempcao = 0;
					
					
				
				end
				else begin
					flag_faz_preempcao = 0;
				end
				
			end
			
			if (reset_cont_preempcao == 1) begin //nao irei mais usar isso, gastaria uma instrucao a mais
			
				cont_preempcao = 0;
			
			end
		
		end
			
		
	end


endmodule 