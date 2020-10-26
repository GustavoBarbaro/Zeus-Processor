module ALU (alu_control, A, B, zero, resp);

	input [5:0] alu_control;
	input [31:0] A, B;
	
	output reg [31:0] resp;
	output zero;
	
	
	always @ (alu_control, A, B) begin 
	
		case (alu_control[5:0])
			6'b000000 : resp = A + B; //ADICAO
			6'b000001 : resp = A & B; //AND
			6'b000010 : resp = A / B; //DIVISAO
			6'b000011 : resp = A * B; //MULTIPLICACAO
			6'b000100 : resp = A - B; //SUBTRACAO
			6'b000101 : resp = A | B; //OR
			6'b000110 : resp = ~(A | B); //NOR
			6'b000111 : resp = A ^ B; //XOR
			6'b001000 : begin //slt
				if (A < B)
				begin
					resp = 1;
				end
				else
				begin
					resp = 0;
				end
			end
			
			default resp = 0;
		endcase
	end
	assign zero = (resp == 0); //zero eh vdd se resp tiver zero
endmodule 