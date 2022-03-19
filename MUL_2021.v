module MUL_2021 (a, b, exception, overflow, underflow, res);
    input wire [31:0] a, b;
	output wire exception, overflow, underflow;
	output wire [31:0] res;
//------------------------------------------------------------------------------------------------
    wire sign_a, sign_b;
    wire [7:0] exponent_a, exponent_b;
    wire [23:0] significand_a, significand_b;
DECOMPOSE_MUL entity_1 (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b);
//------------------------------------------------------------------------------------------------
    wire [22:0] sig_mul;
    wire normalised;
MUL_NORMALISE entity_2 (significand_a, significand_b, sig_mul, normalised);
//------------------------------------------------------------------------------------------------
    wire sign, zero;
CHECK_MUL entity_3 (sign_a, sign_b, exponent_a, exponent_b, sign, exception, zero);
//------------------------------------------------------------------------------------------------
    wire [8:0] exponent;
EXPONENT_MUL entity_4 (exponent_a, exponent_b, normalised, exponent);
//------------------------------------------------------------------------------------------------
FLOW_MUL entity_5 (exponent, zero, overflow, underflow);
//------------------------------------------------------------------------------------------------
RES_MUL entity_6 (exception, zero, sign, overflow, underflow, exponent, sig_mul, res);
//------------------------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------------------------
`timescale 1ns/1ps
module MUL_2021_TB;

reg [31:0] a,b;
wire exception,overflow,underflow;
wire [31:0] res;

reg clk = 1'b1;

MUL_2021 uut(a,b,exception,overflow,underflow,res);

always clk = #5 ~clk;

initial
begin
iteration (32'h0200_0000,32'h0200_0000,1'b0,1'b0,1'b0,32'h0000_0000,`__LINE__);

iteration (32'h4234_851F,32'h427C_851F,1'b0,1'b0,1'b0,32'h4532_10E9,`__LINE__); // 45.13 * 63.13 = 2849.0569;

iteration (32'h4049_999A,32'hC166_3D71,1'b0,1'b0,1'b0,32'hC235_5062,`__LINE__); // 3.15 * -14.39 = -45.3285

iteration (32'hC152_6666,32'hC240_A3D7,1'b0,1'b0,1'b0,32'h441E_5375,`__LINE__); // -13.15 * -48.16 = 633.304

iteration (32'h4580_0000,32'h4580_0000,1'b0,1'b0,1'b0,32'h4B80_0000,`__LINE__); // 4096 * 4096 = 16777216

iteration (32'h3ACA_62C1,32'h3ACA_62C1,1'b0,1'b0,1'b0,32'h361F_FFE7,`__LINE__); // 0.00154408081 * 0.00154408081 = 0.00000238418

iteration (32'h0000_0000,32'h0000_0000,1'b0,1'b0,1'b0,32'h0000_0000,`__LINE__); // 0 * 0 = 0;

iteration (32'hC152_6666,32'h0000_0000,1'b0,1'b0,1'b0,32'h0000_0000,`__LINE__); // -13.15 * 0 = 0;

iteration (32'h7F80_0000,32'h7F80_0000,1'b1,1'b1,1'b0,32'h7F80_0000,`__LINE__); 

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
