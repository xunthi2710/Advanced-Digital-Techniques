module ADD_SUB_2021 (a, b, add_sub_signal, exception, res);
    input wire [31:0] a, b;
    input wire add_sub_signal;
    output wire exception;
    output wire [31:0] res;
//----------------------------------------------------------------------------------------------------------------------------------
    wire sign_a, sign_b, enable, enable_sub;
    wire [7:0] exponent_a, exponent_b;
    wire [31:0] significand_a, significand_b;
DECOMPOSE_AS entity_1 (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b, enable, enable_sub);
//----------------------------------------------------------------------------------------------------------------------------------
    wire [7:0] ex_b_add_sub;
    wire [31:0] sig_b_add_sub;
    wire perform;
EQUALIZING_AS entity_2 (exponent_a, exponent_b, significand_b, ex_b_add_sub, sig_b_add_sub, perform);
//----------------------------------------------------------------------------------------------------------------------------------
    wire output_sign, operation;
CONVERTER_1_AS entity_3 (add_sub_signal, enable, exponent_a, exponent_b, sign_a, sign_b, exception, output_sign, operation);
//----------------------------------------------------------------------------------------------------------------------------------
    wire [30:0] add_sum;
ADD_BLOCK entity_4 (perform, operation, exponent_a, significand_a, sig_b_add_sub, add_sum);
//----------------------------------------------------------------------------------------------------------------------------------
    wire [30:0] sub_diff;
SUB_BLOCK entity_5 (enable_sub, exponent_a, significand_a, sig_b_add_sub, sub_diff);
//----------------------------------------------------------------------------------------------------------------------------------
OUTPUT_AS entity_6 (exception, operation, output_sign, sub_diff, add_sum, res);
endmodule
//----------------------------------------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module ADD_SUB_2021_TB;
    reg [31:0] a,b;
    reg clk = 1'b0,
	reset = 1'b1;
    reg add_sub_signal;

    wire [31:0] res;
    wire exception; 

ADD_SUB_2021 uut (a, b, add_sub_signal, exception, res);

always #5 clk = ~clk;

initial
begin

add_sub_signal = 1'b0;

iteration (32'h4201_51EC,32'h4242_147B,32'h42A1_B333,`__LINE__); //32.33 + 48.52 = 80.85

iteration (32'h4068_51EC,32'h4090_A3D7,32'h4102_6666,`__LINE__); //3.63 + 4.52 = 8.15.

iteration (32'h4195_0A3D,32'h419B_47AE,32'h4218_28F6,`__LINE__); //18.63 + 19.41 = 38.04.

iteration (32'h4217_999A,32'h3F8C_CCCD,32'h421C_0000,`__LINE__); //37.9 + 1.1 = 39.

iteration (32'h4383_C7AE,32'h4164_F5C3,32'h438A_EF5C,`__LINE__); //263.56 + 14.31 = 277.87

iteration (32'h4542_77D7,32'h453B_8FD7,32'h45BF_03D7,`__LINE__); //3111.49 + 3000.99 = 6112.48

iteration (32'h3F3A_E148,32'h3EB33333,32'h3F8A_3D71,`__LINE__); //0.73 + 0.35 = 1.08.

iteration (32'h3F7D_70A4,32'h3F7D_70A4,32'h3FFD_70A4,`__LINE__); //0.99 + 0.99 = 1.98

iteration (32'h3F40_0000,32'h3E94_7AE1,32'h3F85_1EB8,`__LINE__); //0.75 + 0.29 = 1.04

iteration (32'h4B7F_FFFF,32'h3F80_0000,32'h4B80_0000,`__LINE__); //16777215 + 1 = 16777216
								 // Corner Case

iteration (32'h4B7F_FFFF,32'h4000_0000,32'h4B80_0001,`__LINE__); //16777215 + 2 = 16777217.
								 // Corner Case

iteration (32'h4B7F_FFFF,32'h4B7F_FFFF,32'h4BFF_FFFF,`__LINE__); //16777215 + 16777215 = 33554430
								 // Working

iteration (32'h4B7F_FFFE,32'h3F80_0000,32'h4B7F_FFFF,`__LINE__); //16777214 + 1 = 16777215

iteration (32'hBF3A_E148,32'h3EC7_AE14,32'hBEAE_147B,`__LINE__); //-0.73 + 0.39 = -0.34

iteration (32'hC207_C28F,32'h4243_B852,32'h416F_D70A,`__LINE__); //-33.94 + 48.93 = 14.99

iteration (32'hBDB2_2D0E,32'h4305_970A,32'h4305_80C5,`__LINE__); //-0.087 + 133.59 = 133.503

iteration (32'h4E6B_79A3,32'hCCEB_79A3,32'h4E4E_0A6F,`__LINE__); //987654321 - 123456789 = 864197532

iteration (32'h4B80_0000,32'hCB80_0000,32'h0000_0000,`__LINE__); //16777216 - 16777216 = 0

iteration (32'h4B7F_FFFF,32'hCB7F_FFFF,32'h0000_0000,`__LINE__); //16777215 - 16777215 = 0

// Subtraction //

add_sub_signal = 1'b1;

iteration (32'h40A00000,32'h40C00000,32'hBF800000,`__LINE__); //5 - 6 = -1

iteration (32'h40C00000,32'h40A00000,32'h3F800000,`__LINE__); //6 - 5 = 1

iteration (32'hC0C00000,32'hC0A00000,32'hBF800000,`__LINE__); //-6 - (-5) = -1

iteration (32'hC0A00000,32'hC0C00000,32'h3F800000,`__LINE__); // -5 - (-6) = 1

iteration (32'h40C00000,32'hC0A00000,32'h41300000,`__LINE__); // 6 - (-5) = 11

iteration (32'h40A00000,32'hC0C00000,32'h41300000,`__LINE__); // 5 - (-6) = 11

iteration (32'hC0A00000,32'h40C00000,32'hC1300000,`__LINE__); // -5 - (6) = -11

iteration (32'hC0C00000,32'h40A00000,32'hC1300000,`__LINE__); // -6 - (+5) = -11

// Exception Cases //

iteration (32'h0000_0000,32'h3EC7_AE14,32'hBEC7_AE14,`__LINE__);

iteration (32'h3EC7_AE14,32'h0000_0000,32'h3EC7_AE14,`__LINE__);

iteration (32'h0000_0000,32'h0000_0000,32'h0000_0000,`__LINE__);

iteration (32'h7F80_0000,32'h7F90_0100,32'h7F80_0000,`__LINE__);

iteration (32'h7F80_0000,32'h3EC7_AE14,32'h7F80_0000,`__LINE__);

iteration (32'h3EC7_AE14,32'h7F80_0000,32'hFF80_0000,`__LINE__);

iteration (32'h7F80_0000,32'h0000_0000,32'h7F80_0000,`__LINE__);

iteration (32'h7F90_0100,32'h7F80_0000,32'h7F80_0000,`__LINE__);

@(negedge clk)
$stop;

end

task iteration(
input [31:0] op_a,op_b,expected_value,
input integer line_num );

begin
	@(negedge clk)
	begin
		a = op_a;
		b = op_b;
	end

	@(posedge clk)
	begin
		#1;
		if (expected_value == res)
			$display ("Success: Line Number -> %d",line_num);
		else 
			$display ("Failed: \t\n A => %h, \t\n B => %h, \t\n Result Obtained => %h, \t\n Expected Value => %h - Line Number",op_a,op_b,res,expected_value,line_num);
	end
end
endtask

endmodule