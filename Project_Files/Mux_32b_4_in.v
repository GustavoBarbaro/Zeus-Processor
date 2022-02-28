module Mux_32b_4_in (input [31:0] in_0, input [31:0] in_1, input [31:0] in_2, input [31:0] in_3, 
							
							input [1:0] key, output reg [31:0] out);

	
	always @ (key or in_0 or in_1 or in_2 or in_3)
	begin
		case (key)
		
			0: out <= in_0;
			1: out <= in_1;
			2: out <= in_2;
			3: out <= in_3;
		
		endcase
	end



endmodule 