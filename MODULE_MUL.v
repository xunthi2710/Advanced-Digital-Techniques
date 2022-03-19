//------------------------------------------------------------------------------------------------
module DECOMPOSE_MUL (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b);
    input wire [31:0] a, b;
    output wire sign_a, sign_b;
    output wire [7:0] exponent_a, exponent_b;
    output wire [23:0] significand_a, significand_b;
    wire net1, net2;

    assign sign_a = a[31];
    assign sign_b = b[31];
    assign exponent_a = a[30:23];
    assign exponent_b = b[30:23];
    or (net1, exponent_a[0], exponent_a[1], exponent_a[2], exponent_a[3], exponent_a[4], exponent_a[5], exponent_a[6], exponent_a[7]); // net1 = |exponent_a
    or (net2, exponent_b[0], exponent_b[1], exponent_b[2], exponent_b[3], exponent_b[4], exponent_b[5], exponent_b[6], exponent_b[7]); // net2 = |exponent_b
    assign significand_a = net1 ? {1'b1,a[22:0]} : {1'b0,a[22:0]};
    assign significand_b = net2 ? {1'b1,b[22:0]} : {1'b0,b[22:0]}; 
endmodule
//------------------------------------------------------------------------------------------------
/*
`timescale 1ns/1ps
module DECOMPOSE_MUL_TB;
    reg [31:0] a, b;
    wire sign_a, sign_b;
    wire [7:0] exponent_a, exponent_b;
    wire [23:0] significand_a, significand_b;

DECOMPOSE_MUL uut (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b);
    initial begin
        #10
        a = 32'h4234_851F;
        b = 32'h427C_851F;
        #10
        a = 32'h4049_999A;
        b = 32'hC166_3D71;
        #10
        a = 32'hC152_6666;
        b = 32'hC240_A3D7;
    end
endmodule
*/
//------------------------------------------------------------------------------------------------
module MUL_NORMALISE (sig_a, sig_b, sig_mul, normalised);
    input wire [23:0] sig_a, sig_b;
    output wire [22:0] sig_mul;
    output wire normalised;
    wire [47:0] product, product_normalised, product_shift;
    wire [23:0] product_sig, product_mantissa;
    wire round, c;
    wire net1;

MULTIPLY entity_2 (sig_a, sig_b, product);
    assign normalised = product[47] ? 1'b1 : 1'b0;                      // Gia tri cua normalised 
SHIFTER_LEFT_48BITS entity_3 (product, 6'd1, product_shift);
    assign product_normalised = normalised ? product : product_shift;   
//  assign round = |product_normalised[22:0]; 
    or (round, product_normalised[0], product_normalised[1], product_normalised[2], product_normalised[3], product_normalised[4], product_normalised[5], product_normalised[6], product_normalised[7], product_normalised[8], product_normalised[9], product_normalised[10], product_normalised[11], product_normalised[12], product_normalised[13], product_normalised[14], product_normalised[15], product_normalised[16], product_normalised[17], product_normalised[18], product_normalised[19], product_normalised[20], product_normalised[21], product_normalised[22], product_normalised[23]);
//  assign bit_round = product_normalised[23] & round;
    and (bit_round, product_normalised[23], round);
FULL_ADDER_24BITS entity_4 ({1'b0,product_normalised[46:24]}, {23'd0,bit_round}, 1'b0, product_mantissa, c);
    assign sig_mul = product_mantissa[22:0];
endmodule
//------------------------------------------------------------------------------------------------
/*
`timescale 1ns/1ps
module MUL_NORMALISE_TB;
    reg [23:0] sig_a, sig_b;
    wire [22:0] sig_mul;
    wire normalised;

MUL_NORMALISE uut (sig_a, sig_b, sig_mul, normalised);
    initial begin
        #10
        sig_a = 24'b101101001000010100011111;
        sig_b = 24'b111111001000010100011111;
        #10
        sig_a = 24'b110010011001100110011010;
        sig_b = 24'b111001100011110101110001;
        #10
        sig_a = 24'b110100100110011001100110;
        sig_b = 24'b110000001010001111010111;
    end
endmodule
*/
//------------------------------------------------------------------------------------------------
module CHECK_MUL (sign_a, sign_b, ex_a, ex_b, sign, exception, zero);
    input wire sign_a, sign_b;
    input wire [7:0] ex_a, ex_b;
    output wire sign, exception, zero;
    wire [3:0] eq, gt, lt;
    wire net1;

//  assign sign = sign_a ^ sign_b;
    xor (sign, sign_a, sign_b);
//  assign exception = (ex_a == 8'b11111111) || (ex_b == 8'b11111111);
COMPARATOR_8BITS add_1 (ex_a, 8'b11111111, eq[0], gt[0], lt[0]);
COMPARATOR_8BITS add_2 (ex_b, 8'b11111111, eq[1], gt[1], lt[1]);
COMPARATOR_8BITS add_3 (ex_a, 8'd0, eq[2], gt[2], lt[2]);
COMPARATOR_8BITS add_4 (ex_b, 8'd0, eq[3], gt[3], lt[3]);
    or (exception, eq[0], eq[1]);
    or (net1, eq[2], eq[3]);
    assign zero = exception ? 1'b0 : net1 ? 1'b1 : 1'b0; 
endmodule
//------------------------------------------------------------------------------------------------
/*
`timescale 1ns/1ps
module CHECK_MUL_TB;
    reg sign_a, sign_b;
    reg [7:0] ex_a, ex_b;
    wire sign, exception, zero;

CHECK_MUL uut (sign_a, sign_b, ex_a, ex_b, sign, exception, zero);
    initial begin
        #10
        sign_a = 0;
        sign_b = 0;
        ex_a = 8'b10000100;
        ex_b = 8'b10000100;
        #10
        sign_a = 0;
        sign_b = 1;
        ex_a = 8'b10000000;
        ex_b = 8'b10000010;
        #10
        sign_a = 1;
        sign_b = 1;
        ex_a = 8'b10000010;
        ex_b = 8'b10000100;
        #10
        sign_a = 0;
        sign_b = 0;
        ex_a = 8'b10000100;
        ex_b = 8'b10000100;
        #10
        sign_a = 0;
        sign_b = 0;
        ex_a = 8'd0;
        ex_b = 8'd0;
    end
endmodule
*/
//------------------------------------------------------------------------------------------------
module EXPONENT_MUL (ex_a, ex_b, normalised, exponent);
    input wire [7:0] ex_a, ex_b;
    input wire normalised;
    output wire [8:0] exponent;
    wire [8:0] sum_ex, diff_nor;
    wire b;

FULL_ADDER_8BITS entity_5 (ex_a, ex_b, 1'b0, sum_ex[7:0], sum_ex[8]);
FULL_SUBTRACTOR_8BITS entity_6 (8'd127, {7'd0,normalised}, 1'b0, diff_nor[7:0], diff_nor[8]);
FULL_SUBTRACTOR_9BITS entity_7 (sum_ex, diff_nor, 1'b0, exponent, b);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module EXPONENT_MUL_TB;
    reg [7:0] ex_a, ex_b;
    reg normalised;
    wire [8:0] exponent;

EXPONENT_MUL uut (ex_a, ex_b, normalised, exponent);
    initial begin
        #10
        ex_a = 8'b10000100;
        ex_b = 8'b10000100;
        normalised = 1;
        #10
        ex_a = 8'b10000000;
        ex_b = 8'b10000010;
        normalised = 1;
        #10
        ex_a = 8'b10000010;
        ex_b = 8'b10000100;
        normalised = 1;
        #10
        ex_a = 8'b00000100;
        ex_b = 8'b00000100;
        normalised = 1;
    end
endmodule

//------------------------------------------------------------------------------------------------
module FLOW_MUL (exponent, zero, overflow, underflow);
    input wire [8:0] exponent;
    input wire zero;
    output wire overflow, underflow;
    wire net1;
    wire eq, gt, lt;

//  assign overflow = ((exponent[8] & !exponent[7]) & !zero);       // So mu lon hon 255 thi la overflow
    not (net1, exponent[7]);
    not (net2, zero);
    and (overflow, exponent[8], net1, net2);
//  assign underflow = ((exponent[8] & exponent[7]) & !zero); 
    and (underflow, exponent[8], exponent[7], net2);
endmodule
//------------------------------------------------------------------------------------------------
/*
`timescale 1ns/1ps
module FLOW_MUL_TB;
    reg [8:0] exponent;
    reg zero;
    wire overflow, underflow;

FLOW_MUL uut (exponent, zero, overflow, underflow);
    initial begin
        #10
        exponent = 9'b010001010;
        zero = 0;
        #10
        exponent = 9'b010000100;
        zero = 0;
        #10
        exponent = 9'b010001000;
        zero = 0;
        #10
        exponent = 9'b101111111;
        zero = 0;
    end
endmodule
*/
//------------------------------------------------------------------------------------------------
module RES_MUL (exception, zero, sign, overflow, underflow, exponent, sig_mul, res);
    input wire exception, zero, sign, overflow, underflow;
    input wire [8:0] exponent;
    input wire [22:0] sig_mul;
    output wire [31:0] res;

    assign res = exception ? {sign,8'hFF,23'd0} : zero ? {32'd0} : overflow ? {sign,8'hFF,23'd0} : underflow ? 32'd0 : {sign,exponent[7:0],sig_mul};
endmodule
//------------------------------------------------------------------------------------------------
/*
`timescale 1ns/1ps
module RES_MUL_TB;
    reg exception, zero, sign, overflow, underflow;
    reg [8:0] exponent;
    reg [22:0] sig_mul;
    wire [31:0] res;

RES_MUL uut (exception, zero, sign, overflow, underflow, exponent, sig_mul, res);
    initial begin
        #10
        exception = 0;
        zero = 0;
        sign = 0;
        overflow = 0;
        underflow = 0;
        exponent = 9'b010001010;
        sig_mul = 23'b01100100001000101000100;
        #10
        exception = 0;
        zero = 0;
        sign = 1;
        overflow = 0;
        underflow = 0;
        exponent = 9'b010000100;
        sig_mul = 23'b01101010101000011001000;
        #10
        exception = 0;
        zero = 0;
        sign = 0;
        overflow = 0;
        underflow = 0;
        exponent = 9'b010001000;
        sig_mul = 23'b00111100101001101110100;
    end
endmodule
*/