`timescale 1 ps / 1 ps

module testbench;

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
	parameter fullclk = 10;
		
	reg [7:0]address;
	reg clock;
	reg [31:0]data;
	reg wren;
	wire [31:0]q;

	tiny_risc_v DUT(
										address,
										clock,
										data,
										wren,
										q);
	
	initial
	begin
		/* start clk and reset */
		#(simdelay) clock = 1'b0; step_val = 8'd0;
		//#(simdelay) rst = 1'b1; /* go into normal circuit operation */ 
		#(simdelay) address = 8'd0;
		#100; // let simulation finish
	
	end
	
		// this generates a clock
	always
	begin
		#(clock_delay) clock = !clock;
	end
	
	initial
		#1000 $stop; // This stops the simulation ... May need to be greater or less depending on your program
	/* this checks done every clock and when it goes high ends the simulation */
	//always @(clk)
	//begin
		//if (done == 1'b1)
		//begin
			//$write("DONE:"); 
			//$stop;
		//end
	//end
endmodule
