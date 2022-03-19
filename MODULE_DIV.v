//------------------------------------------------------------------------------------------------
module DECOMPOSE_DIV (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b);
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

`timescale 1ns/1ps
module DECOMPOSE_DIV_TB;
    reg [31:0] a, b;
    wire sign_a, sign_b;
    wire [7:0] exponent_a, exponent_b;
    wire [23:0] significand_a, significand_b;

DECOMPOSE_DIV uut (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b);
    initial begin
        #10
        a = 32'h4AC8_6898;
        b = 32'hCB07_8682;
        #10
        a = 32'hCA9A_FFAF;
        b = 32'h4A2D_6AB8;
        #10
        a = 32'h4AB6_CE51;
        b = 32'h499A_732C;
        #10
        a = 32'h42FE_1000;
        b = 32'h4187_8000;
    end
endmodule


//------------------------------------------------------------------------------------------------
module CHECK_DIV (sign_a, sign_b, ex_a, ex_b, sign, exception, zero_divident, zero_divisor);
    input wire sign_a, sign_b;
    input wire [7:0] ex_a, ex_b;
    output wire sign, exception, zero_divident, zero_divisor;
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
//  assign zero_divident = (ex_a == 8'd0);
    assign zero_divident = eq[2];
//  assign zero_divisor = (ex_b == 8'd0);
    assign zero_divisor = eq[3];
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module CHECK_DIV_TB;
    reg sign_a, sign_b;
    reg [7:0] ex_a, ex_b;
    reg [22:0] sig_mul;
    wire sign, exception, zero_divident, zero_divisor;

CHECK_DIV uut (sign_a, sign_b, ex_a, ex_b, sign, exception, zero_divident, zero_divisor);
    initial begin
        #10
        sign_a = 0;
        sign_b = 1;
        ex_a = 8'b10010101;
        ex_b = 8'b10010110;
        sig_mul = 23'b01111010100011111000100;
        #10
        sign_a = 1;
        sign_b = 0;
        ex_a = 8'b10010101;
        ex_b = 8'b10010100;
        sig_mul = 23'b11001001100111110011100;
        #10
        sign_a = 0;
        sign_b = 0;
        ex_a = 8'b10010101;
        ex_b = 8'b10010011;
        sig_mul = 23'b00101111000000000000000;
        #10
        sign_a = 0;
        sign_b = 0;
        ex_a = 8'b10000101;
        ex_b = 8'b10000011;
        sig_mul = 23'b11100000000000000000000;
    end
endmodule

//------------------------------------------------------------------------------------------------
module EXPONENT_DIV (ex_a, ex_b, sig_a, sig_b, exponent);
    input wire [7:0] ex_a, ex_b;  
    input wire [23:0] sig_a, sig_b;  
    output wire [8:0] exponent;
    wire [8:0] diff_ex, diff_nor;
    wire b, c, eq, gt, lt;

COMPARATOR_24BITS add_5 (sig_a, sig_b, eq, gt, lt);
/*
FULL_SUBTRACTOR_8BITS add_6 (8'd127, ex_b, lt, diff, b);
FULL_ADDER_8BITS add_7 (ex_a, diff, 1'b0, exponent[7:0], c);
*/
FULL_SUBTRACTOR_8BITS entity_1 (ex_a, ex_b, 1'b0, diff_ex[7:0], diff_ex[8]);
FULL_SUBTRACTOR_8BITS entity_2 (8'd127, {7'd0,lt}, 1'b0, diff_nor[7:0], diff_nor[8]);
FULL_ADDER_9BITS entity_3 (diff_ex, diff_nor, 1'b0, exponent, b);
endmodule
//------------------------------------------------------------------------------------------------
module EXPONENT_DIV_2 (ex_a, ex_b, exponent);
    input wire [7:0] ex_a, ex_b;  
    output wire [7:0] exponent;
    wire [7:0] diff;
    wire b, c;

FULL_SUBTRACTOR_8BITS entity_1 (8'd126, ex_b, 1'b0, diff, b);
FULL_ADDER_8BITS entity_2 (ex_a, diff, 1'b0, exponent, c);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module EXPONENT_DIV_TB;
    reg [7:0] ex_a, ex_b;
    reg [23:0] sig_a, sig_b;
    wire [8:0] exponent;

EXPONENT_DIV uut (ex_a, ex_b, sig_a, sig_b, exponent);
    initial begin
        #10
        ex_a = 8'b10010101;
        ex_b = 8'b10010110;
        sig_a = 24'd3;
        sig_b = 24'd4;
        #10
        ex_a = 8'b10010101;
        ex_b = 8'b10010100;
        sig_a = 24'd3;
        sig_b = 24'd2;
        #10
        ex_a = 8'b10010101;
        ex_b = 8'b10010011;
        sig_a = 24'd3;
        sig_b = 24'd4;
        #10
        ex_a = 8'b10000101;
        ex_b = 8'b10000011;
        sig_a = 24'd3;
        sig_b = 24'd2;
        #10
        ex_a = 8'b00000100;
        ex_b = 8'b00000100;
        sig_a = 24'd3;
        sig_b = 24'd4;
    end
endmodule

//------------------------------------------------------------------------------------------------
module FLOW_DIV (ex_a, ex_b, exponent, overflow, underflow);
    input wire [7:0] ex_a, ex_b;
    input wire [8:0] exponent;
    output wire overflow, underflow;
    wire [1:0] eq, lt, gt;
    wire net1;

//  assign overflow = (exponent[8] & !exponent[7]);       // So mu lon hon 255 thi la overflow
    not (net1, exponent[7]);
    and (overflow, exponent[8], net1);
//  assign underflow = (exponent[8] & exponent[7]); 
    and (underflow, exponent[8], exponent[7]);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module FLOW_DIV_TB;
    reg [7:0] ex_a, ex_b;
    wire overflow, underflow;

FLOW_DIV uut (ex_a, ex_b, overflow, underflow);
    initial begin
        #10
        ex_a = 8'b10010101;
        ex_b = 8'b10010110;
        #10
        ex_a = 8'b10010101;
        ex_b = 8'b10010100;
        #10
        ex_a = 8'b10010101;
        ex_b = 8'b10010011;
        #10
        ex_a = 8'b10000101;
        ex_b = 8'b10000011;
    end
endmodule

//------------------------------------------------------------------------------------------------
module RES_DIV (exception, sign, overflow, underflow, zero_divident, zero_divisor, exponent, sig_div, res);
    input wire exception, sign, overflow, underflow, zero_divident, zero_divisor;
    input wire [8:0] exponent;
    input wire [24:0] sig_div;
    output wire [31:0] res;

    assign res = exception ? {sign,8'hFF,23'd0} : zero_divident ? 32'd0 : zero_divisor ? {sign,8'hFF,23'd0} : overflow ? {sign,8'hFF,23'd0} : underflow ? 32'd0 : sig_div[23] ? {sign,exponent[7:0],sig_div[22:0]} : {sign,exponent[7:0],sig_div[23:1]};
endmodule
//------------------------------------------------------------------------------------------------
module RES_DIV_2 (exception, sign, overflow, underflow, solution, res);
    input wire exception, sign, overflow, underflow;
    input wire [31:0] solution;
    output wire [31:0] res;

    assign res = exception ? {sign,8'hFF,23'd0} : overflow ? {sign,8'hFF,23'd0} : underflow ? 32'd0 : {sign,solution[30:0]};
endmodule
//------------------------------------------------------------------------------------------------
/*
`timescale 1ns/1ps
module RES_DIV_TB;
    reg exception, zero, sign, overflow, underflow;
    reg [7:0] exponent;
    reg [22:0] sig_mul;
    wire [31:0] res;

RES_DIV uut (exception, zero, sign, overflow, underflow, exponent, sig_mul, res);
    initial begin
        #10
        exception = 0;
        zero = 0;
        sign = 1;
        overflow = 0;
        underflow = 0;
        exponent = 8'b01111110;
        sig_mul = 23'b01111010100011111000100;
        #10
        exception = 0;
        zero = 0;
        sign = 1;
        overflow = 0;
        underflow = 0;
        exponent = 8'b01111111;
        sig_mul = 23'b11001001100111110011100;
        #10
        exception = 0;
        zero = 0;
        sign = 0;
        overflow = 0;
        underflow = 0;
        exponent = 8'b10000001;
        sig_mul = 23'b00101111000000000000000;
        #10
        exception = 0;
        zero = 0;
        sign = 0;
        overflow = 0;
        underflow = 0;
        exponent = 8'b10000011;
        sig_mul = 23'b11100000000000000000000;
    end
endmodule
*/