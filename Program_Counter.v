module Program_Counter (input clock, input [31:0] PC_in, output reg [31:0] PC, output reg [31:0] PC_mais_1);

always @ (posedge clock)
begin

	PC = PC_in;
	PC_mais_1 = PC + 1;
	
end


endmodule 