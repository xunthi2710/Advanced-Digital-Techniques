module DIV_2021 (a, b, exception, overflow, underflow, res);
    input wire [31:0] a, b;
	output wire exception, overflow, underflow;
	output wire [31:0] res;
//------------------------------------------------------------------------------------------------
    wire sign_a, sign_b;
    wire [7:0] exponent_a, exponent_b;
    wire [23:0] significand_a, significand_b;
DECOMPOSE_DIV entity_1 (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b);
//------------------------------------------------------------------------------------------------
    wire sign, zero, zero_divisor;
CHECK_DIV entity_2 (sign_a, sign_b, exponent_a, exponent_b, sign, exception, zero, zero_divisor);
//------------------------------------------------------------------------------------------------
    wire [8:0] exponent;
EXPONENT_DIV entity_3 (exponent_a, exponent_b, significand_a, significand_b, exponent);
//------------------------------------------------------------------------------------------------
FLOW_DIV entity_4 (exponent_a, exponent_b, exponent, overflow, underflow);
//------------------------------------------------------------------------------------------------
/*
	wire [31:0] solution;
DIV_ITE entity_5 (sign_a, exponent, significand_a[22:0], significand_b[22:0], solution);
//------------------------------------------------------------------------------------------------		
RES_DIV_2 entity_6 (exception, sign, overflow, underflow, solution, res);
*/
//------------------------------------------------------------------------------------------------

	wire [24:0] sig;
DIVISON entity_7 (significand_a, significand_b, sig);
//------------------------------------------------------------------------------------------------
RES_DIV entity_8 (exception, sign, overflow, underflow, zero, zero_divisor, exponent, sig, res);

//------------------------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module DIV_2021_TB;

reg [31:0] a,b;
wire exception,overflow,underflow;
wire [31:0] res;

reg clk = 1'b1;

DIV_2021 uut(a,b,exception,overflow,underflow,res);

always clk = #5 ~clk;

initial
begin

iteration (32'hCA9A_FFAF,32'h4A2D_6AB8,1'b0,1'b0,1'b0,32'hBFE4_CF9C,`__LINE__); // -5078999.5 / 2841262 = -1.787585735321044921875 (-1.78758573532)

iteration (32'h4A2B_A73A,32'hC760_C7D2,1'b0,1'b0,1'b0,32'hC243_7E70,`__LINE__); // 2812366.5 / -57543.8203125 = -48.87347412109375 (-48.8734741211)

iteration (32'hCA82_C570,32'h4B16_3E36,1'b0,1'b0,1'b0,32'hBEDE_D26A,`__LINE__); // -4285112 / 9846326 = -0.435199081897735595703125 (-0.435199081898)

iteration (32'hCB08_3738,32'hCAE6_A5A4,1'b0,1'b0,1'b0,32'h3F97_304D,`__LINE__); // -8927032 / -7557842 = 1.18116152286529541015625 (1.18116152287)

iteration (32'hCA26_D40A,32'hC9A9_A137,1'b0,1'b0,1'b0,32'h3FFB_C5A9,`__LINE__); // -2733314.5 / -1389606.875 = 1.96696960926055908203125 (1.96696960926)

iteration (32'h4AB9_89FF,32'hCABB_037A,1'b0,1'b0,1'b0,32'hBF7D_FB46,`__LINE__); // 6079743.5 / -6128061 = -0.99211537837982177734375 (-0.99211537838)

iteration (32'h4AD9_0A68,32'h4966_EF05,1'b0,1'b0,1'b0,32'h40F0_9957,`__LINE__); // 7111988 / 945904.3125 = 7.518718242645263671875 (7.51871824265)

iteration (32'hCAEC_BBE8,32'hCA5B_CB3A,1'b0,1'b0,1'b0,32'h4009_DD87,`__LINE__); // -7757300 / -3601102.5 = 2.1541459560394287109375 (2.15414595604)

iteration (32'h38D1_B717,32'h7E96_7699,1'b0,1'b0,1'b1,32'h00000_0000,`__LINE__); // 10^-4 / 10^38 = 0 (underflow)

iteration (32'h7E96_7699,32'h38D1_B717,1'b0,1'b1,1'b0,32'h7F80_0000,`__LINE__); // 10^38 / 10^-4 = NaN (overflow)
$stop;

end

task iteration(
input [31:0] op_a,op_b,
input Expected_Exception,Expected_Overflow,Expected_Underflow,
input [31:0] Expected_result,
input integer linenum 
);
begin
@(negedge clk)
begin
	a = op_a;
	b = op_b;
end

@(posedge clk)
begin
if ((Expected_result == res) && (Expected_Exception == exception) && (Expected_Overflow == overflow) && (Expected_Underflow == underflow))
	$display ("Success : %d",linenum);

else
	$display ("Failed : Expected_result = %h, Result = %h, \n Expected_Exception = %d, Exception = %d,\n Expected_Overflow = %d, Overflow = %d, \n Expected_Underflow = %d, Underflow = %d - %d \n ",Expected_result,res,Expected_Exception,exception,Expected_Overflow,overflow,Expected_Underflow,underflow,linenum);
end
end
endtask
endmodule