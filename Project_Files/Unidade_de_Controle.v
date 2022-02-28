module Unidade_de_Controle 

(input [5:0] Op_Code,
	output reg RegDst,
	output reg RegWrite,
	output reg AluSrc,
	output reg ALUOp,
	output reg PCSrc,
	output reg MemWrite,
	output reg MemRead,
	output reg MemToReg,
	output reg print,
	output reg ler_da_entrada,
	output reg [1:0] confirma_entrada,
	//output reg reset_geral,
	output reg reset_cont_preempcao,
	output reg [1:0] jump_prog,
	output reg jump_register,
	output reg halt,
	output reg [5:0] Sinal_da_Conta);

	always @ (Op_Code) // nao esquecer de fazer o caso default
	begin
		case (Op_Code)
		
			6'b000000: begin //TODAS INSTRUCOES TIPO R
				RegDst = 1;
				RegWrite = 1;
				AluSrc = 0;
				ALUOp = 1; //ler func pra saber qual operacao R fazer 
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			//TIPO I (IMMEDIATE)
			
			6'b000001: begin //addi
				RegDst = 0;
				RegWrite = 1;
				AluSrc = 1;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;//adicao
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b000010: begin // beq
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 1;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000100; //subtração
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b000011: begin //blez
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 1;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000100; //subtração
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b000100: begin //bne
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0; // pq se nao foi igual o zero da alu nao vai ligar e eh isso que queremos
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000100; //subtração
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b000101: begin //bgtz
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000; //adição
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b000110: begin //lw
				RegDst = 0;
				RegWrite = 1;
				AluSrc = 1;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 1;
				MemToReg = 1;
				Sinal_da_Conta = 6'b000000; //adição
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b000111: begin // sw
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 1;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 1;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;// adição
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b001000: begin // j
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 1;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b001100: begin // OUTPUT
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 1;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b001011: begin // INPUT
				RegDst = 0;
				RegWrite = 1;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 1;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b001101: begin // delay
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 1;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b001110: begin // reset_geral
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 1;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b001111: begin // reset_preemp //descontinuado
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 1;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b010010: begin // recup_PC
				RegDst = 0; //vai mandar para o rt
				RegWrite = 1;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 2;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
			
			6'b010000: begin // jump P1
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 1;
				jump_register = 1;
				halt = 0;
			end
			
			6'b010001: begin // jump P2
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 2;
				jump_register = 1;
				halt = 0;
			end
			
			6'b001010: begin // jump register
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 1;
				halt = 0;
			end
			
			6'b010011: begin // HALT
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 1;
			end
			
			default: begin
				RegDst = 0;
				RegWrite = 0;
				AluSrc = 0;
				ALUOp = 0; //manter zerado
				PCSrc = 0;
				MemWrite = 0;
				MemRead = 0;
				MemToReg = 0;
				Sinal_da_Conta = 6'b000000;
				print = 0;
				ler_da_entrada = 0;
				confirma_entrada = 0;
				//reset_geral = 0;
				reset_cont_preempcao = 0;
				jump_prog = 0;
				jump_register = 0;
				halt = 0;
			end
		
		endcase
	end

endmodule 