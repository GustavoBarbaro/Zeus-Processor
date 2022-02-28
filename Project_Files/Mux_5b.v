module Mux_5b (input [4:0] in_0, input [4:0] in_1, input key, output reg [4:0] out);

always @ (key or in_0 or in_1)
begin
	if (key)
		out <= in_1;
	else
		out <= in_0;
end

endmodule 