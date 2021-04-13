module tiny_risc_v(
input clk, 
input rst, 
input start,
output reg done,
output reg [2:0]S,
output reg [2:0]NS,
output reg [4:0]rr1, rr2, wr,
output wire [31:0]rd1, rd2,
output reg [31:0]wd
);

/* FSM signals and parameters */
//reg [2:0] S;
//reg [2:0] NS;
parameter START = 3'd0;
parameter FETCH = 3'd1;
parameter EXECUTE = 3'd2;
parameter WRITEBACK = 3'd3;
parameter DONE = 3'd4;

// parser signals
reg [31:0]instruction;
//wire [6:0] opcode;
wire [4:0] s1, s2, de, i5;
wire [6:0] funct7, i7;
wire [2:0] funct3;
wire [11:0] i12;
wire [19:0] address;

//memory signal
reg double;
wire [31:0]mem_out;
reg [7:0]PC;

//alu signal
reg [31:0]r1, r2;
reg [7:0]alu_control;
wire [31:0]result;

//register signal
reg we;
//reg [4:0]rr1, rr2, wr;
//reg [31:0] wd;
//wire [31:0]rd1, rd2;

//address change
reg [7:0] sext;

instructions instruction_from_memory(PC,
	clk,
	1'b0,
	1'b0,
	mem_out);
	
instruction_parser iparse (opcode, s1, s2, de, i5, funct7, i7, funct3, i12, address, instruction);

alu my_alu(
r1,
r2,
alu_control,
result);

register_file register(
 clk, rst, we,
 rr1, rr2, wr,
 wd,
 rd1, rd2
);

/* S update always block */
always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
		S <= START;
	else
		S <= NS;
end

/* NS transitions always block */
always @(*)
begin
	case (S)
		START: begin
		 if(start == 1'b1)
					NS = FETCH;
				 else
					NS = START;
					end
		FETCH: begin
			if(double == 1'b0) NS = FETCH;
			else NS = EXECUTE;
		end
		EXECUTE: begin
			NS = WRITEBACK;
		end
		WRITEBACK:
		begin
			//if(PC == 4'd32)
			if(PC == 4'd4)
				NS = DONE;
			else
				NS = FETCH;
		end
		//DONE: NS = START;
	endcase		
end

/* clocked control signals always block */
always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
	begin
		done <= 1'b0;
		instruction <= 31'd0;
		r1 <= 32'd0;
		r2 <= 32'd0;
		alu_control <= 8'd0;
		we <= 1'b0;
		rr1 <= 5'd0;
		rr2 <= 5'd0;
		wr <= 5'd0;
		wd <= 32'd0;
		double <= 1'b0;
		PC <= 8'd0;
	end
	else
	begin
		case (S)
			START: begin
			done <= 1'b0;
			instruction <= 31'd0;
			r1 <= 32'd0;
			r2 <= 32'd0;
			alu_control <= 8'd0;
			we <= 1'b0;
			rr1 <= 5'd0;
			rr2 <= 5'd0;
			wr <= 5'd0;
			wd <= 32'd0;
			double <= 1'b0;
			PC <= 8'd0;
			end
			FETCH: begin
			instruction <= mem_out;
			//instruction <= 32'h00300513;
			double<=double+1;
			end
			EXECUTE: begin
				case (opcode)
				7'b0110011: //OP
				begin
					rr1 <= s1;
					rr2 <= s2;
					wr <= de;
					we <= 1'b1;
					r1 <= rd1;
					r2 <= rd2;
					case (funct3)
						3'b000: //ADD SUB
						begin
						if (funct7 == 7'b0000000)
							alu_control <= 8'd0;
						else
							alu_control <= 8'd1;
						end
						3'b001: //SLL
						begin
							alu_control <= 8'd9;
						end
						3'b010: // SLT
						begin
							alu_control <= 8'd5;
						end
						3'b011: // SLTU
						begin
							alu_control <= 8'd6;
						end
						3'b100: // XOR
						begin
							alu_control <= 8'd4;
						end
						3'b101: // SRL or SRA
						begin
							if (funct7 == 7'b0000000) //SRL
								alu_control <= 8'd8;
							else // SRA
								alu_control <= 8'd7;
						end
						3'b110: // OR
						begin
							alu_control <= 8'd3;
						end
						3'b111: // AND
						begin
							alu_control <= 8'd2;
						end
					endcase
					wd <= result;
				end
				7'b0010011: //OP-IMM
				begin
					rr1 <=s1;
					wr <=de;
					we <=1'b1;
					r1 <=rd1;
					case (funct3)
						3'b000: //ADDI
						begin
							r2 <= {20'd0, i12};
							alu_control <= 8'd0;
						end
						3'b001: //SLLI
						begin
							r2 <= {27'd0, i5};
							alu_control <= 8'd9;
						end
						3'b010: // SLTI
						begin
							r2 <= {20'd0, i12};
							alu_control <= 8'd5;
						end
						3'b011: // SLTIU
						begin
							r2 <= {20'd0, i12};
							alu_control <= 8'd6;
						end
						3'b100: // XORI
						begin
							r2 <= {20'd0, i12};
							alu_control <= 8'd4;
						end
						3'b101: // SRLI or SRAI
						begin
							if (funct7 == 7'b0000000) //SRLI
							begin
								r2 <= {27'd0, i5};
								alu_control <= 8'd8;
							end
							else // SRAI
							begin
								r2 <= {27'd0, i5};
								alu_control <= 8'd7;
							end
						end
						3'b110: // ORI
						begin
							r2 <= {20'd0, i12};
							alu_control <= 8'd3;
						end
						3'b111: // ANDI
						begin
							r2 <= {20'd0, i12};
							alu_control <= 8'd2;
						end
					endcase
					wd <= result;
				end
				//7'b1100011: //BRANCH
				//begin	
				//end
				endcase
			end
			WRITEBACK:
			begin
				//if(funct7 != 7'b1100011 & funct7 != 7'b1101111 & funct7 != 7'b1100111)
					PC <= PC + 8'd1; 
			end
			DONE: done <= 1'b1;
		endcase
	end
end

endmodule
