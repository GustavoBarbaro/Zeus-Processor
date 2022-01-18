module Gerenciador_Saidas (input [7:0] entrada, output [13:0] saida);

	wire [3:0] tens;
	wire [3:0] ones;


	Split_Digitos split (.value(entrada), .tens(tens), .ones(ones));

	display_7_seg dezenas (.inp(tens), .saida_7s( saida[13:7] ));

	display_7_seg unidades (.inp(ones), .saida_7s( saida[6:0] ));





endmodule 