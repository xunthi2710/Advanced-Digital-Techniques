//-------------------------------------------------------------------------------------------------------
module SHIFT_LEFT_SUB_DIV (in_a, in_b, out, divident);
	input [24:0] in_a, in_b;
	output out;
	output [24:0] divident;
	wire b, eq, gt, lt;
	wire [24:0] net1, net2;

SHIFTER_LEFT_25BITS entity_1 (in_a, 5'd1, net1);
COMPARATOR_25BITS entity_2 (net1, in_b, eq, gt, lt);
FULL_SUBTRACTOR_25BITS entity_3 (net1, in_b, 1'b0, net2, b);
	assign out = lt ? 1'b0 : 1'b1;
	assign divident = lt ? net1 : net2;
endmodule
//-------------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module SHIFT_LEFT_SUB_DIV_TB;
	reg [24:0] in_a, in_b;
	wire out;
	wire [24:0] divident;

SHIFT_LEFT_SUB_DIV uut (in_a, in_b, out, divident);
	initial begin
		#10
		in_a = 25'b0101101101100111001010001;
		in_b = 25'b0100110100111001100101100;
		#10
		in_a = 25'b0111111100001000000000000;
		in_b = 25'b0100001111000000000000000;
		#10
		in_a = 25'b0110010000110100010011000;
		in_b = 25'b0100001111000011010000010;
		#10
		in_a = 25'b0100110101111111110101111;
		in_b = 25'b0101011010110101010111000;
	end
endmodule
//-------------------------------------------------------------------------------------------------------
module DIVISON (in_a, in_b, out);
	input [23:0] in_a, in_b;
	output [24:0] out;
	wire [24:0] divident, divisor;
	wire b, eq, gt, lt;
	wire [24:0] net [0:24];
	wire [24:0] net1;

	assign divident = {1'b0,in_a};
	assign divisor = {1'b0,in_b};
COMPARATOR_25BITS entity_4 (divident, divisor, eq, gt, lt);
FULL_SUBTRACTOR_25BITS entity_5 (divident, divisor, 1'b0, net1, b);
	assign out[24] = lt ? 1'b0 : 1'b1;
	assign net[24] = lt ? divident : net1;
SHIFT_LEFT_SUB_DIV entity_6 (net[24], divisor, out[23], net[23]);
SHIFT_LEFT_SUB_DIV entity_7 (net[23], divisor, out[22], net[22]);
SHIFT_LEFT_SUB_DIV entity_8 (net[22], divisor, out[21], net[21]);
SHIFT_LEFT_SUB_DIV entity_9 (net[21], divisor, out[20], net[20]);
SHIFT_LEFT_SUB_DIV entity_10 (net[20], divisor, out[19], net[19]);
SHIFT_LEFT_SUB_DIV entity_11 (net[19], divisor, out[18], net[18]);
SHIFT_LEFT_SUB_DIV entity_12 (net[18], divisor, out[17], net[17]);
SHIFT_LEFT_SUB_DIV entity_13 (net[17], divisor, out[16], net[16]);
SHIFT_LEFT_SUB_DIV entity_14 (net[16], divisor, out[15], net[15]);
SHIFT_LEFT_SUB_DIV entity_15 (net[15], divisor, out[14], net[14]);
SHIFT_LEFT_SUB_DIV entity_16 (net[14], divisor, out[13], net[13]);
SHIFT_LEFT_SUB_DIV entity_17 (net[13], divisor, out[12], net[12]);
SHIFT_LEFT_SUB_DIV entity_18 (net[12], divisor, out[11], net[11]);
SHIFT_LEFT_SUB_DIV entity_19 (net[11], divisor, out[10], net[10]);
SHIFT_LEFT_SUB_DIV entity_20 (net[10], divisor, out[9], net[9]);
SHIFT_LEFT_SUB_DIV entity_21 (net[9], divisor, out[8], net[8]);
SHIFT_LEFT_SUB_DIV entity_22 (net[8], divisor, out[7], net[7]);
SHIFT_LEFT_SUB_DIV entity_23 (net[7], divisor, out[6], net[6]);
SHIFT_LEFT_SUB_DIV entity_24 (net[6], divisor, out[5], net[5]);
SHIFT_LEFT_SUB_DIV entity_25 (net[5], divisor, out[4], net[4]);
SHIFT_LEFT_SUB_DIV entity_26 (net[4], divisor, out[3], net[3]);
SHIFT_LEFT_SUB_DIV entity_27 (net[3], divisor, out[2], net[2]);
SHIFT_LEFT_SUB_DIV entity_28 (net[2], divisor, out[1], net[1]);
SHIFT_LEFT_SUB_DIV entity_29 (net[1], divisor, out[0], net[0]);
endmodule
//-------------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module DIVISON_TB;
	reg [23:0] in_a, in_b;
	wire [24:0] out;

DIVISON uut (in_a, in_b, out);
	initial begin
		#10
		in_a = 24'b101101101100111001010001;
		in_b = 24'b100110100111001100101100;
		#10
		in_a = 24'b111111100001000000000000;
		in_b = 24'b100001111000000000000000;
		#10
		in_a = 24'b110010000110100010011000;
		in_b = 24'b100001111000011010000010;
		#10
		in_a = 24'b100110101111111110101111;
		in_b = 24'b101011010110101010111000;
		#10
		in_a = 24'b101010111010011100111010;
		in_b = 24'b111000001100011111010010;
		#10
		in_a = 24'b111011001011101111101011;
		in_b = 24'b110110111100101100111010;
	end
endmodule
//-------------------------------------------------------------------------------------------------------