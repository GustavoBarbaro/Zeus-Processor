module Extensor (input [15:0] in, output reg [31:0] out);
	always @ (in)
	begin
		out = {{15{1'b0}}, in};
	end
	
endmodule 