


<img src="https://user-images.githubusercontent.com/48565991/128616026-e10d887b-acda-4ed2-a3bf-fd1c1046c3ba.png" data-canonical-src="https://user-images.githubusercontent.com/48565991/128616026-e10d887b-acda-4ed2-a3bf-fd1c1046c3ba.png" width="600" height="450" />



# About 

* Architecture MIPS - RISC based
* 32 registers with 32 bits each
* Currently has 26 instructions, but is expandable to 64
* Little-Endian
* Unicycle
* Developed using Verilog language 

# How to open

Extract the file `Zeus_Processor_Arquivado.qar` in a software like Intel Quartus Prime


# Instruction Set

## R type

### Bit - Mapping


|  OpCode |   $rs   |   $rt   |   $rd   |  Shamt | Funct | Funct |
|:-------:|:-------:|:-------:|:-------:|:------:|:-----:|:-----:|
| [31:26] | [25:21] | [20:16] | [15:11] | [10:6] | [5:0] | [5:0] |

### Instructions

| Name | Opcode (6b) | Rs (5b) | Rt (5b) | Rd (5b) | Shamt (5b) | Funct (6b) |
|:----:|:-----------:|:-------:|:-------:|:-------:|:----------:|:----------:|
|  add |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   000000   |
| addu |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   000001   |
|  and |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   000010   |
|  div |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   000011   |
| divu |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   000100   |
| mult |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   000101   |
|  nor |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   000110   |
|  xor |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   000111   |
|  or  |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   001000   |
| slt  |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   001001   |
|  sub |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   001010   |
| subu |    000000   |   $rs   |   $rt   |   $rd   |    00000   |   001011   |


## I type

### Bit - Mapping

|  OpCode |   $rs   |   $rt   | Immediate |
|:-------:|:-------:|:-------:|:---------:|
| [31:26] | [25:21] | [20:16] |   [15:0]  |

### Instructions

| Name | Opcode (6b) | Rs (5b) | Rt (5b) |  Immediate (16b) |
|:----:|:-----------:|:-------:|:-------:|:----------------:|
| addi |    000001   |   $rs   |   $rt   | 0000000000000000 |
|  beq |    000010   |   $rs   |   $rt   | 0000000000000000 |
| blez |    000011   |   $rs   |   $rt   | 0000000000000000 |
|  bne |    000100   |   $rs   |   $rt   | 0000000000000000 |
| bgtz |    000101   |   $rs   |   $rt   | 0000000000000000 |
|  lw  |    000110   |   $rs   |   $rt   | 0000000000000000 |
|  sw  |    000111   |   $rs   |   $rt   | 0000000000000000 |

## J type

### Bit - Mapping

|  OpCode | Line Address |
|:-------:|:------------:|
| [31:26] |    [25:0]    |

### Instructions

| Name | Opcode (6b) |     Line Address (26b)     |
|:----:|:-----------:|:--------------------------:|
|   J  |    001000   | 00000000000000000000000000 |

# Data Path

![Data Path completo](https://user-images.githubusercontent.com/48565991/128611558-7bd266d3-d9c0-4691-8e6a-68495e08ea8c.png)

# Videos
(In portuguese)

[Introduction](https://www.youtube.com/watch?v=rC5qsfxLZZ8)

[Running](https://www.youtube.com/watch?v=c4x9lxSHLe8)


<img src="https://user-images.githubusercontent.com/48565991/128615339-788ea439-1558-49c1-8136-a8907c23e12c.png" data-canonical-src="https://user-images.githubusercontent.com/48565991/128615339-788ea439-1558-49c1-8136-a8907c23e12c.png" width="250" height="250" />

	  _____ ____   ____
	 / ____|  _ \ / __ \
	| |  __| |_) | |  | |
	| | |_ |  _ <| |  | |
	| |__| | |_) | |__| |
	 \_____|____/ \____/


