module Alu_Control (Funct, ALUOp, Sinal, Controle);
	input [5:0] Funct;
	input ALUOp;
	input [5:0] Sinal;
	
	output reg [5:0] Controle;
	
	
	always @ (Funct, ALUOp, Sinal)
	begin
	
		if (ALUOp == 1) //abrir para cada caso de funct
		begin
			
			case (Funct)

				6'b000000 : begin //add
					Controle = 6'b000000;
				end
				
				6'b000001 : begin //addu
					Controle = 6'b000000;
				end
				
				6'b000010 : begin //AND
					Controle = 6'b000001;
				end
				
				6'b000011 : begin //div
					Controle = 6'b000010;
				end
				
				6'b000100 : begin //divu
					Controle = 6'b000010;
				end
				
				6'b000101 : begin //mult
					Controle = 6'b000011;
				end
				
				6'b000110 : begin //nor
					Controle = 6'b000110;
				end
				
				6'b000111 : begin //xor
					Controle = 6'b000111;
				end
				
				6'b001000 : begin //or
					Controle = 6'b000101;
				end
				
				6'b001001 : begin //slt
					Controle = 6'b001000;
				end
				
				6'b001010 : begin //sub
					Controle = 6'b000100;
				end
				
				6'b001011 : begin //subu
					Controle = 6'b000100;
				end
				
				
				default: begin
					Controle = 6'b000000;
				end
			endcase
		
		end
		
		if (ALUOp == 0)
		begin
			Controle = Sinal;
		end
	
	end
	
	
endmodule 