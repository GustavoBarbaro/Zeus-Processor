module Zeus_Processor (
	input clock_FPGA,
	input [15:0] entrada,
	input confirma_bt,
	input modo_preemptivo,
	output [31:0] PC,
	output [31:0] instrucao,
	output [31:0] ALu_out,
	output [31:0] escrever_dados,
	output [31:0] novo_escrever_dados,
	output [31:0] Rs,
	output [31:0] Rt,
	output [31:0] Rd,
	output [31:0] mem_dados_out,
	output sys_clock,
	output [1:0] jump_prog,


	output RegDst,
	output RegWrite,
	output ALUSrc,
	output ALUOp,
	output PCSrc,
	output MemWrite,
	output MemRead,
	output MemToReg,
	output print_out,
	output ler_da_entrada,
	output [1:0] confirma_entrada,
	output flag_faz_preempcao,
	output jump_register,
	output halt,
	output tem_desloc_PC,
	output tem_desloc_MD,
	output [31:0] PC_IN,
	output [31:0] PC_mais_1,
	
	

	
	output [31:0] print_dados
);



//=============    WIRES     =====================================

// ><><><><><<>><><><><><><><><><><><><><
/*wire [31:0] instrucao;
wire [31:0] novo_escrever_dados;
wire [31:0] escrever_dados;
wire [31:0] Rs;
wire [31:0] Rt;
wire [31:0] Rd;
wire [31:0] ALu_out;
wire [31:0] mem_dados_out;
wire [31:0] PC;
wire sys_clock;
wire [1:0] jump_prog;*/

// ><><><><><<>><><><><><><><><><><><><><


wire [4:0] B_R_escrita;



wire [31:0] extendido_32b;
wire [31:0] MUX_to_ALU;
wire [5:0] controle_alu; //passa pra ULA qual operacao fazer
wire zero;



//wire [31:0] PC_mais_1;


wire [31:0] PC_somado_com_extendido;
wire [31:0] real_next_PC;
wire [5:0] Sinal;
wire chave_do_desvio;
wire [31:0] entrada_lida;
wire clk_temp;

wire [31:0] base_to_desloc_PC;
wire [31:0] base_to_desloc_MD;
wire [31:0] PC_desloc;
wire [31:0] MD_desloc;

wire [31:0] in_Mem_Instrucoes;
wire [31:0] in_Mem_Dados;
//wire tem_desloc_MD;
//wire tem_desloc_PC;
wire [31:0] salva_PC;

//wire [31:0] PC_IN;




//=============    FIM WIRES     =====================================



//=============    FLAGS     =====================================

	/*wire RegDst;
	wire RegWrite;
	wire ALUSrc;
	wire ALUOp;
	wire PCSrc;
	wire MemWrite;
	wire MemRead;
	wire MemToReg;
	wire print_out;
	wire ler_da_entrada;
	wire [1:0] confirma_entrada
	wire modo_preemptivo
	wire flag_faz_preempcao
	wire jump_register;
	wire halt;*/
	
	wire reset_geral;
	wire reset_cont_preempcao;
	wire [4:0] quantum;


//=============    FIM FLAGS     =====================================


//=============    TRATANDO DE ATRASAR O CLOCK DO FPGA     =====================================


Divisor_Frequencia div_freq (.clock_in(clock_FPGA), .clock_out(clk_temp));


//=============    FIM ATRASAR CLOCK FPGA     =====================================




// ====================        fazendo PC + 1===================================



assign sys_clock = clk_temp & (~ler_da_entrada | confirma_bt); //para segurar o clock e ficar esperando pela entrada


Program_Counter Program_counter_0 (.clock (sys_clock), .PC_in(PC_IN), .PC(PC), .PC_mais_1(PC_mais_1), .reset_geral(reset_geral), .reset_cont_preempcao(reset_cont_preempcao), .quantum(quantum), .modo_preemptivo(modo_preemptivo), .salva_PC(salva_PC), .flag_faz_preempcao(flag_faz_preempcao), .halt(halt), .jump_prog(jump_prog));

ALU somador_desloc_pc (.alu_control(00000), .A(PC), .B(base_to_desloc_PC), .resp(PC_desloc));


Mux_32b mux_desloc_PC (.in_0 (PC), .in_1 (PC_desloc), .key (tem_desloc_PC), .out (in_Mem_Instrucoes));



// ====================        FIM fazendo PC + 1===================================



Memoria_de_instrucoes mem_instru (.PC(in_Mem_Instrucoes[7:0]), .clk(sys_clock), .Instruction(instrucao));



// ====================        UNIDADE DE CONTROLE===================================

Unidade_de_Controle control_unit (.Op_Code (instrucao [31:26]), .RegDst (RegDst), .RegWrite (RegWrite), .AluSrc (ALUSrc), .ALUOp (ALUOp), .PCSrc (PCSrc), .MemWrite (MemWrite), .MemRead (MemRead), .MemToReg (MemToReg), .print(print_out), .ler_da_entrada(ler_da_entrada), .Sinal_da_Conta (Sinal), .confirma_entrada(confirma_entrada), .reset_cont_preempcao(reset_cont_preempcao), .jump_prog(jump_prog), .jump_register(jump_register), .halt(halt));

// ====================        FIM UNIDADE DE CONTROLE===================================



Mux_5b mux5 (.in_0 (instrucao [20:16]), .in_1 (instrucao[15:11]), .key(RegDst), .out (B_R_escrita));

Banco_Registradores banco_registers (.endereco_leitura_1 (instrucao [25:21]), .endereco_leitura_2 (instrucao [20:16]), .endereco_escrita(B_R_escrita), .escrever_dados(novo_escrever_dados), .Reg_Write(RegWrite), .clock(sys_clock), .Rs(Rs), .Rt(Rt), .Rd(Rd));

Extensor extend (.in (instrucao [15:0]), .out(extendido_32b));

Mux_32b mux_ULA (.in_0 (Rt), .in_1 (extendido_32b), .key(ALUSrc), .out (MUX_to_ALU));

// ====================        ALU CONTROL===================================

Alu_Control alu_controle (.Funct(instrucao [5:0]), .ALUOp (ALUOp), .Sinal (Sinal), .Controle (controle_alu));

// ====================        FIM ALU CONTROL===================================


ALU ALU_0 (.alu_control (controle_alu), .A (Rs), .B(MUX_to_ALU), .zero(zero), .resp (ALu_out));

//*****

ALU somador_desloc_MD (.alu_control(00000), .A(ALu_out), .B(base_to_desloc_MD), .resp(MD_desloc));

Mux_32b mux_desloc_MD (.in_0 (ALu_out), .in_1 (MD_desloc), .key (tem_desloc_MD), .out (in_Mem_Dados));

//*****


Memoria_de_Dados Mem_dados (.data(Rt), .read_addr(in_Mem_Dados), .endereco_escrita(in_Mem_Dados), .Mem_Write(MemWrite), .Mem_Read(MemRead), .read_clock(clock_FPGA), .write_clock(sys_clock), .lendo_dados(mem_dados_out));

Mux_32b mux_mem_dados (.in_0 (ALu_out), .in_1 (mem_dados_out), .key (MemToReg), .out (escrever_dados));



// ======================     TRATANDO O CALCULO DO PROXIMO PC ====================

////PC_somado_com_extendido = PC_somado + extendido_32b;

//ALU somador (.alu_control(00000), .A(PC_mais_1), .B(extendido_32b), .resp(PC_somado_com_extendido));


assign chave_do_desvio = PCSrc & zero;


//Mux_32b mux_PC_ou_Desvio (.in_0(PC_mais_1), .in_1(PC_somado_com_extendido), .key(chave_do_desvio), .out(real_next_PC));
Mux_32b mux_PC_ou_Desvio (.in_0(PC_mais_1), .in_1(extendido_32b), .key(chave_do_desvio), .out(real_next_PC));


Mux_32b mux_Jump_register (.in_0(real_next_PC), .in_1(Rs), .key(jump_register), .out(PC_IN));


// ======================     FAZENDO A SAIDA     ====================


//Mux_32b mux_saida (.in_0(0), .in_1(Rs), .key(print_out), .out(print_dados));

Salva_Saida out (.Rs(Rs), .print_out(print_out), .print_dados(print_dados));




// ======================     FAZENDO A ENTRADA     ====================


Extensor lendo_da_entrada (.in(entrada), .out(entrada_lida));

Mux_32b_4_in mux_escrita_Banco_regs (.in_0(escrever_dados), .in_1(entrada_lida), .in_2(salva_PC), .key(confirma_entrada), .out(novo_escrever_dados));




// ======================     GERENCIADOR DE SO     ====================


Gerenciador_de_Preempcao Atlas_OS (.tem_desloc_PC(tem_desloc_PC), .tem_desloc_MD(tem_desloc_MD), .base_to_desloc_PC(base_to_desloc_PC), .base_to_desloc_MD(base_to_desloc_MD), .quantum(quantum), .flag_faz_preempcao(flag_faz_preempcao), .reset_geral(reset_geral), .jump_prog(jump_prog));




endmodule 