module Zeus_Processor (
	input clock,
	output [31:0] PC,
	output [31:0] instrucao,
	output [31:0] ALu_out,
	output [31:0] escrever_dados,
	output [31:0] Rs,
	output [31:0] Rt,
	output [31:0] Rd
);



//=============    WIRES     =====================================

//wire [31:0] instrucao;
//wire [31:0] escrever_dados;
wire [4:0] B_R_escrita;
//wire [31:0] Rs;
//wire [31:0] Rt;
//wire [31:0] Rd;
wire [31:0] extendido_32b;
wire [31:0] MUX_to_ALU;
wire [5:0] controle_alu; //passa pra ULA qual operacao fazer
wire zero;
//wire [31:0] ALu_out;
wire [31:0] mem_dados_out;
wire [31:0] PC_mais_1;
//wire [31:0] PC;
wire [31:0] PC_somado_com_extendido;
wire [31:0] real_next_PC;
wire [5:0] Sinal;
wire chave_do_desvio;



//=============    FIM WIRES     =====================================



//=============    FLAGS     =====================================

	wire RegDst;
	wire RegWrite;
	wire ALUSrc;
	wire ALUOp;
	wire PCSrc;
	wire MemWrite;
	wire MemRead;
	wire MemToReg;


//=============    FIM FLAGS     =====================================






// ====================        fazendo PC + 1===================================

Program_Counter Program_counter_0 (.clock (clock), .PC_in(real_next_PC), .PC(PC), .PC_mais_1(PC_mais_1));





// ====================        FIM fazendo PC + 1===================================



Memoria_de_instrucoes mem_instru (.PC(PC[7:0]), .clk(clock), .Instruction(instrucao));



// ====================        UNIDADE DE CONTROLE===================================

Unidade_de_Controle control_unit (.Op_Code (instrucao [31:26]), .RegDst (RegDst), .RegWrite (RegWrite), .AluSrc (ALUSrc), .ALUOp (ALUOp), .PCSrc (PCSrc), .MemWrite (MemWrite), .MemRead (MemRead), .MemToReg (MemToReg), .Sinal_da_Conta (Sinal));

// ====================        FIM UNIDADE DE CONTROLE===================================



Mux_5b mux5 (.in_0 (instrucao [20:16]), .in_1 (instrucao[15:11]), .key(RegDst), .out (B_R_escrita));

Banco_Registradores banco_registers (.endereco_leitura_1 (instrucao [25:21]), .endereco_leitura_2 (instrucao [20:16]), .endereco_escrita(B_R_escrita), .escrever_dados(escrever_dados), .Reg_Write(RegWrite), .clock(clock), .Rs(Rs), .Rt(Rt), .Rd(Rd));

Extensor extend (.in (instrucao [15:0]), .out(extendido_32b));

Mux_32b mux_ULA (.in_0 (Rt), .in_1 (extendido_32b), .key(ALUSrc), .out (MUX_to_ALU));

// ====================        ALU CONTROL===================================

Alu_Control alu_controle (.Funct(instrucao [5:0]), .ALUOp (ALUOp), .Sinal (Sinal), .Controle (controle_alu));

// ====================        FIM ALU CONTROL===================================


ALU ALU_0 (.alu_control (controle_alu), .A (Rs), .B(MUX_to_ALU), .zero(zero), .resp (ALu_out));

Memoria_de_Dados Mem_dados (.data(Rt), .read_addr(ALu_out), .endereco_escrita(ALu_out), .Mem_Write(MemWrite), .Mem_Read(MemRead), .read_clock(clock), .write_clock(clock), .lendo_dados(mem_dados_out));

Mux_32b mux_mem_dados (.in_0 (ALu_out), .in_1 (mem_dados_out), .key (MemToReg), .out (escrever_dados));



// ======================     TRATANDO O CALCULO DO PROXIMO PC ====================

//PC_somado_com_extendido = PC_somado + extendido_32b;

ALU somador (.alu_control(00000), .A(PC_mais_1), .B(extendido_32b), .resp(PC_somado_com_extendido));


assign chave_do_desvio = PCSrc & zero;


Mux_32b mux_PC_ou_Desvio (.in_0(PC_mais_1), .in_1(PC_somado_com_extendido), .key(chave_do_desvio), .out(real_next_PC));



endmodule 