//Copyright MMXXI Lam Ha haln@miamioh.edu
module instruction_parser(
	output wire [6:0] opcode,
	output reg [4:0] s1,
	output reg [4:0] s2,
	output reg [4:0] de,
	output reg [4:0] i5,
	output reg [6:0] funct7,
	output reg [6:0] i7,
	output wire [2:0] funct3,
	output reg [11:0] i12,
	output reg [19:0] address,
	input [31:0] instruction
);
	assign opcode = instruction[6:0];
	assign funct3 = instruction[14:12];
	always @(*)
	begin
		// OP
		if(opcode == 7'b0110011) begin
			funct7 = instruction[31:25];
			s2 = instruction[24:20];
			s1 = instruction[19:15];
			de = instruction[11:7];
			i5 = 5'd0;
			i7 = 7'd0;
			i12 = 12'd0;
			address = 20'd0;
		end
		// OP-IMM : SLLI, SRLI, SRAI
		else if(opcode == 7'b0010011 & (funct3 == 3'b001 | funct3 == 3'b101)) begin
			i7 = instruction[31:25];
			i5 = instruction[24:20];
			s1 = instruction[19:15];
			de = instruction[11:7];
			s2 = 5'd0;
			funct7 = 7'd0;
			i12 = 12'd0;
			address = 20'd0;
		end
		// Rest of OP-IMM and JALR or lw
		else if (opcode == 7'b0010011 | opcode == 7'b1100111 || opcode == 7'b0000011) begin 
			i12 = instruction[31:20];
			s1 = instruction[19:15];
			de = instruction[11:7];
			s2 = 5'd0;
			i5 = 5'd0;
			funct7 = 7'd0;
			i7 = 7'd0;
			address = 20'd0;
		end
		//  Branch or sw
		else if(opcode == 7'b1100011 || opcode == 7'b0100011) begin
			i7 = instruction[31:25];
			s2 = instruction[24:20];
			s1 = instruction[19:15];
			i5 = instruction[11:7];
			de = 5'd0;
			funct7 = 7'd0;
			i12 = 12'd0;
			address = 20'd0;
		end
		// LUI or AUIPC or JAL
		else if((opcode == 7'b0110111)|(opcode == 7'b0010111)|(opcode == 7'b1101111)) begin
			address = instruction[31:12];
			de = instruction[11:7];
			s2 = 5'd0;
			s1 = 5'd0;
			i5 = 5'd0;
			funct7 = 7'd0;
			i7 = 7'd0;
			i12 = 12'd0;
		end
		else
		begin
			address = 20'd0;
			de = 5'd0;
			s2 = 5'd0;
			s1 = 5'd0;
			i5 = 5'd0;
			funct7 = 7'd0;
			i7 = 7'd0;
			i12 = 12'd0;
		end
	end	
endmodule
