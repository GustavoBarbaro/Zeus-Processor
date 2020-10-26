module Mux_32b (input [31:0] in_0, input [31:0] in_1, input key, output reg [31:0] out);

always @ (key or in_0 or in_1)
begin
	if (key)
		out <= in_1;
	else
		out <= in_0;
end

endmodule 