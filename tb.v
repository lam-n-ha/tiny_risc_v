`timescale 1 ps / 1 ps

module tb;

	reg[7:0] step_val;
	
	task sevenSeg(input [6:0] val);
	begin
		case (val)
			7'b1111110: $write("ten:0");
			7'b0110000: $write("ten:1");
			7'b1101101: $write("ten:2");
			7'b1111001: $write("ten:3");
			7'b0110011: $write("ten:4");
			7'b1011011: $write("ten:5");
			7'b1011111: $write("ten:6");
			7'b1110000: $write("ten:7");
			7'b1111111: $write("ten:8");
			7'b1111011: $write("ten:9");
			7'b1110111: $write("ten:A");
			7'b0011111: $write("ten:B");
			7'b1001110: $write("ten:C");
			7'b0111101: $write("ten:D");
			7'b1001111: $write("ten:E");
			7'b1000111: $write("ten:F");
			default: $write("seg:ERROR");
		endcase
	end
	endtask
	task sevenSegNeg		(input [6:0] val);
	begin
		case (val)
			7'b0000001: $write("neg:-");
			7'b0000000: $write("neg:+");
			default: $display("neg:ERROR");
		endcase
	end
	endtask
	task step();
	begin
		$write("%d: ", step_val);
		step_val = step_val + 1;
	end
	endtask

	
	parameter simdelay = 20; // guaranteed 2 clocks
	parameter clock_delay = 5;
	parameter fullclk = 11;
		
	reg clk;
	reg rst;
	reg start;
	wire done;
	wire [3:0]S;
	wire [3:0]NS;
	wire [4:0]rr1;
	wire [4:0]rr2;
	wire [4:0]wr;
	wire we;
	wire [31:0]rd1;
	wire [31:0]rd2;
	wire [31:0]wd;
	wire [31:0]r1, r2;
	wire [7:0]alu_control;
	wire [31:0]result;
	wire [6:0]opcode;
	wire [7:0]mem_lo;
	wire [31:0]mem_in;
	wire mem_en;
	wire [7:0]PC;
	
	
	
	tiny_risc_v DUT(				clk,
										rst,
										start,
										done,
										S,
										NS,
										rr1,
										rr2,
										wr,
										we,
										rd1,
										rd2,
										wd,
										r1, r2,
										alu_control,
										result,
										opcode,
										mem_lo,
										mem_in,
										mem_en,
										PC
										);
	
	initial
	begin
		
		/* start clk and reset */
		#(simdelay) rst = 1'b0; clk = 1'b0; step_val = 8'd0;
		#(simdelay) rst = 1'b1; /* go into normal circuit operation */ 
		#(simdelay) start = 1'b1;
		#100; // let simulation finish
	
	end
	
		// this generates a clock
	always
	begin
		#(clock_delay) clk = !clk;
	end
	
	//initial
		//#1000 $stop; // This stops the simulation ... May need to be greater or less depending on your program
	/* this checks done every clock and when it goes high ends the simulation */
	always @(clk)
	begin
		if (done == 1'b1)
		begin
			$write("DONE:"); 
			$stop;
		end
	end
endmodule
