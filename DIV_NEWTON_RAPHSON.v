//------------------------------------------------------------------------------------------------
module ITERATION (operand_1, operand_2, solution);
    input wire [31:0] operand_1, operand_2;
    output wire [31:0] solution;
    wire [31:0] net_intermediate1, net_intermediate2;
    wire flag1, flag2, flag3, flag4, flag5, flag6, flag7;
    
MUL_2021 entity_1 (operand_1, operand_2, flag1, flag2, flag3, net_intermediate1);
//32'h4000_0000 -> 2.
ADD_SUB_2021 entity_2 (32'h4000_0000, {1'b1,net_intermediate1[30:0]}, 1'b0, flag4, net_intermediate2);
MUL_2021 entity_3 (operand_1, net_intermediate2, flag5, flag6, flag7, solution);
endmodule
//------------------------------------------------------------------------------------------------
module DIV_ITE (sign_a, exponent, significand_a, significand_b, solution);
    input wire sign_a;
    input wire [7:0] exponent;
    input wire [22:0] significand_a, significand_b;
    output wire [31:0] solution;
    wire [31:0] divisor, op_a;
    wire [31:0] net;
    wire [31:0] iter0, iter1, iter2, iter3;

    assign divisor = {1'b0,8'd126,significand_b};
    assign op_a = {sign_a,exponent,significand_a};

    wire flag1, flag2, flag3;
//32'hC00B_4B4B = (-37)/17
MUL_2021 entity_4 (32'hC00B_4B4B, divisor, flag1, flag2, flag3, net);

    wire flag4;
//32'h4034_B4B5 = 48/17
ADD_SUB_2021 entity_5 (net, 32'h4034_B4B5, 1'b0, flag4, iter0);

ITERATION entity_6 (iter0, divisor, iter1);
ITERATION entity_7 (iter1, divisor, iter2);
ITERATION entity_8 (iter2, divisor, iter3);

    wire flag5, flag6, flag7;
MUL_2021 entity_9 (iter3, op_a, flag5, flag6, flag7, solution);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module DIV_ITE_TB;
    reg sign_a;
    reg [7:0] exponent;
    reg [22:0] significand_a, significand_b;
    wire [31:0] solution;

DIV_ITE uut (sign_a, exponent, significand_a, significand_b, solution);
    initial begin
        #10
        sign_a = 1'b1;
        exponent = 8'b01111111;
        significand_a = 23'b00110101111111110101111;
        significand_b = 23'b01011010110101010111000; // solution = 32'hBFE4_CF9C
        #10
        sign_a = 1'b1;
        exponent = 8'b10000100;
        significand_a = 23'b01010111010011100111010;
        significand_b = 23'b11000001100011111010010; // solution = 32'hC243_    7E70
        #10
        sign_a = 1'b1;
        exponent = 8'b01111110;
        significand_a = 23'b10010000110100010011000;
        significand_b = 23'b00001111000011010000010; // solution = 32'hBF3D_47CA
    end
endmodule