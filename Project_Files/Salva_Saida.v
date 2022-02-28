module Salva_Saida (input [31:0] Rs, input print_out, output [31:0] print_dados);

	reg [31:0] registrador_saida = 32'd0;


	always @(*)
	begin
		if (print_out == 1) begin
			registrador_saida = Rs;
		end
	end


	assign print_dados = registrador_saida;	


endmodule 