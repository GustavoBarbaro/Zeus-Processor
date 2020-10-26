module testando_cont_pc (input clock, output [31:0] PC);

wire [31:0] PC_mais_1;



Program_Counter test_PC (.clock (clock), .PC_in(PC_mais_1), .PC(PC), .PC_mais_1(PC_mais_1));

endmodule 