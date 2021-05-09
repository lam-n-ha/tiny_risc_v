module register_file(
input clk, rst, we,
input [4:0] rr1, rr2, wr,
input [31:0] wd,
output reg [31:0] rd1, rd2
);
reg [1023:0] reg_storage;

always @(*)
begin
	case (rr1)
		//5'd0: rd1 = reg_storage[31:0];
		5'd0: rd1 = 32'd0;
		5'd1: rd1 = reg_storage[63:32];
		5'd2: rd1 = reg_storage[95:64];
		5'd3: rd1 = reg_storage[127:96];
		5'd4: rd1 = reg_storage[159:128];
		5'd5: rd1 = reg_storage[191:160];
		5'd6: rd1 = reg_storage[223:192];
		5'd7: rd1 = reg_storage[255:224];
		5'd8: rd1 = reg_storage[287:256];
		5'd9: rd1 = reg_storage[319:288];
		5'd10: rd1 = reg_storage[351:320];
		5'd11: rd1 = reg_storage[383:352];
		5'd12: rd1 = reg_storage[415:384];
		5'd13: rd1 = reg_storage[447:416];
		5'd14: rd1 = reg_storage[479:448];
		5'd15: rd1 = reg_storage[511:480];
		5'd16: rd1 = reg_storage[543:512];
		5'd17: rd1 = reg_storage[575:544];
		5'd18: rd1 = reg_storage[607:576];
		5'd19: rd1 = reg_storage[639:608];
		5'd20: rd1 = reg_storage[671:640];
		5'd21: rd1 = reg_storage[703:672];
		5'd22: rd1 = reg_storage[735:704];
		5'd23: rd1 = reg_storage[767:736];
		5'd24: rd1 = reg_storage[799:768];
		5'd25: rd1 = reg_storage[831:800];
		5'd26: rd1 = reg_storage[863:832];
		5'd27: rd1 = reg_storage[895:864];
		5'd28: rd1 = reg_storage[927:896];
		5'd29: rd1 = reg_storage[959:928];
		5'd30: rd1 = reg_storage[991:960];
		5'd31: rd1 = reg_storage[1023:992];
	endcase
		
	case (rr2)
		//5'd0: rd2 = reg_storage[31:0];
		5'd0: rd2 = 32'd0;
		5'd1: rd2 = reg_storage[63:32];
		5'd2: rd2 = reg_storage[95:64];
		5'd3: rd2 = reg_storage[127:96];
		5'd4: rd2 = reg_storage[159:128];
		5'd5: rd2 = reg_storage[191:160];
		5'd6: rd2 = reg_storage[223:192];
		5'd7: rd2 = reg_storage[255:224];
		5'd8: rd2 = reg_storage[287:256];
		5'd9: rd2 = reg_storage[319:288];
		5'd10: rd2 = reg_storage[351:320];
		5'd11: rd2 = reg_storage[383:352];
		5'd12: rd2 = reg_storage[415:384];
		5'd13: rd2 = reg_storage[447:416];
		5'd14: rd2 = reg_storage[479:448];
		5'd15: rd2 = reg_storage[511:480];
		5'd16: rd2 = reg_storage[543:512];
		5'd17: rd2 = reg_storage[575:544];
		5'd18: rd2 = reg_storage[607:576];
		5'd19: rd2 = reg_storage[639:608];
		5'd20: rd2 = reg_storage[671:640];
		5'd21: rd2 = reg_storage[703:672];
		5'd22: rd2 = reg_storage[735:704];
		5'd23: rd2 = reg_storage[767:736];
		5'd24: rd2 = reg_storage[799:768];
		5'd25: rd2 = reg_storage[831:800];
		5'd26: rd2 = reg_storage[863:832];
		5'd27: rd2 = reg_storage[895:864];
		5'd28: rd2 = reg_storage[927:896];
		5'd29: rd2 = reg_storage[959:928];
		5'd30: rd2 = reg_storage[991:960];
		5'd31: rd2 = reg_storage[1023:992];
	endcase
end

always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
		reg_storage <= 1024'd0;
	else if (we == 1'b1)
	begin
		case (wr)
			5'd0: reg_storage[31:0] <= wd;
			5'd1: reg_storage[63:32]<= wd;
			5'd2: reg_storage[95:64]<= wd;
			5'd3: reg_storage[127:96]<= wd;
			5'd4: reg_storage[159:128]<= wd;
			5'd5: reg_storage[191:160]<= wd;
			5'd6: reg_storage[223:192]<= wd;
			5'd7: reg_storage[255:224]<= wd;
			5'd8: reg_storage[287:256]<= wd;
			5'd9: reg_storage[319:288]<= wd;
			5'd10: reg_storage[351:320]<= wd;
			5'd11: reg_storage[383:352]<= wd;
			5'd12: reg_storage[415:384]<= wd;
			5'd13: reg_storage[447:416]<= wd;
			5'd14: reg_storage[479:448]<= wd;
			5'd15: reg_storage[511:480]<= wd;
			5'd16: reg_storage[543:512]<= wd;
			5'd17: reg_storage[575:544]<= wd;
			5'd18: reg_storage[607:576]<= wd;
			5'd19: reg_storage[639:608]<= wd;
			5'd20: reg_storage[671:640]<= wd;
			5'd21: reg_storage[703:672]<= wd;
			5'd22: reg_storage[735:704]<= wd;
			5'd23: reg_storage[767:736]<= wd;
			5'd24: reg_storage[799:768]<= wd;
			5'd25: reg_storage[831:800]<= wd;
			5'd26: reg_storage[863:832]<= wd;
			5'd27: reg_storage[895:864]<= wd;
			5'd28: reg_storage[927:896]<= wd;
			5'd29: reg_storage[959:928]<= wd;
			5'd30: reg_storage[991:960]<= wd;
			5'd31: reg_storage[1023:992]<= wd;
		endcase
	end
end


endmodule
