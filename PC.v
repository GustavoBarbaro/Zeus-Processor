module PC (input [31:0] in_PC , output reg [31:0] Program_Counter);
	always @ (in_PC)
	begin
		Program_Counter = in_PC;
	end
endmodule 