module alu(
input [31:0]s1,
input [31:0]s2,
input [7:0]alu_control,
output reg[31:0]result);

reg [15:0]      SRFILL;
reg [31:0]      SRL_1;
reg [31:0]      SRL_2;
reg [31:0]      SRL_4;
reg [31:0]      SRL_8;

reg [31:0]      SLL_1;
reg [31:0]      SLL_2;
reg [31:0]      SLL_4;
reg [31:0]      SLL_8;

reg [31:0]		 AUIPCim;

parameter ADD = 8'd0;
parameter SUB = 8'd1;
parameter AND = 8'd2;
parameter OR = 8'd3;
parameter XOR = 8'd4;
parameter SLT = 8'd5;
parameter SLTU = 8'd6;
parameter SRA = 8'd7;
parameter SRL = 8'd8;
parameter SLL = 8'd9;
parameter MUL = 8'd10;
parameter LUI = 8'd11;
parameter AUIPC = 8'd12;

always @(*)
begin
		SRFILL = 16'd0;
		SRL_1 = 32'd0;
		SRL_2 = 32'd0;
		SRL_4 = 32'd0;
		SRL_8 = 32'd0;
		
		SLL_1 = 32'd0;
		SLL_2 = 32'd0;
		SLL_4 = 32'd0;
		SLL_8 = 32'd0;
		
	case (alu_control)
		ADD: //ADD or ADDI
		begin
			result = s1+s2;
		end
		SUB: //SUB
		begin
			result = s1-s2;
		end
		AND: //AND or ANDI
		begin
			result = s1&s2;
		end	
		OR: //OR or ORI
		begin
			result = s1|s2;
		end
		XOR: //XOR or XORI
		begin
			result = s1^s2;
		end
		SLT: //SLT or SLTI
		begin
			result = {31'd0, ($signed(s1) < $signed(s2))};
		end
		SLTU: //SLTU or SLTIU
		begin
			result = (s1 < s2)? 32'b1 : 32'b0;
		end
		SRA: //SRA or SRAI
		begin
			if (s1[31])
				SRFILL = 16'b1111111111111111;
			else
				SRFILL = 16'b0000000000000000;
				
			if (s2[0])
             SRL_1 = {SRFILL[0], s1[31:1]};
			else
				 SRL_1 = s1;
			if (s2[1])
				 SRL_2 = {SRFILL[1:0], SRL_1[31:2]};
			else
				 SRL_2 = SRL_1;
			if (s2[2])
				 SRL_4 = {SRFILL[3:0], SRL_2[31:4]};
			else
				 SRL_4 = SRL_2;
			if (s2[3])
				 SRL_8 = {SRFILL[7:0], SRL_4[31:8]};
			else
				 SRL_8 = SRL_4;
			if (s2[4])
				 result = {SRFILL[15:0], SRL_8[31:16]};
			else
				 result = SRL_8;
		end
		SRL: //SRL or SRLI
		begin
			if (s2[0])
             SRL_1 = {1'b0, s1[31:1]};
			else
				 SRL_1 = s1;
			if (s2[1])
				 SRL_2 = {2'b00, SRL_1[31:2]};
			else
				 SRL_2 = SRL_1;
			if (s2[2])
				 SRL_4 = {4'b0000, SRL_2[31:4]};
			else
				 SRL_4 = SRL_2;
			if (s2[3])
				 SRL_8 = {8'b00000000, SRL_4[31:8]};
			else
				 SRL_8 = SRL_4;
			if (s2[4])
				 result = {16'b0000000000000000, SRL_8[31:16]};
			else
				 result = SRL_8;
		end
		SLL: //SLL or SLLI
		begin
			if (s2[0])
             SLL_1 = {s1[30:0],1'b0};
			else
				 SLL_1 = s1;
			if (s2[1])
				 SLL_2 = {SLL_1[29:0],2'b00};
			else
				 SLL_2 = SLL_1;

			if (s2[2])
				 SLL_4 = {SLL_2[27:0],4'b0000};
			else
				 SLL_4 = SLL_2;

			if (s2[3])
				 SLL_8 = {SLL_4[23:0],8'b00000000};
			else
				 SLL_8 = SLL_4;

			if (s2[4])
				 result = {SLL_8[15:0],16'b0000000000000000};
			else
				 result = SLL_8;
		end
		MUL: //MUL
		begin
			result = s1 * s2;
		end
		LUI: //LUI
		begin
			result[31:12] = s2[19:0];
			result[11:0] = 12'd0;
		end
		AUIPC: //AUIPC
		begin
			AUIPCim[31:12] = s2[19:0];
			AUIPCim[11:0] = 12'd0;
			result = s1 + AUIPCim;
		end
	endcase
end
	
endmodule
