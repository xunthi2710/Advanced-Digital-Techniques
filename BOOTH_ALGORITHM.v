//------------------------------------------------------------------------------------------------
module CHECK_LSB_BOOTH (in_1, in_2, in_3, sel, out);
    input [64:0] in_1, in_2, in_3;
    input [1:0] sel;
    output [64:0] out;

    assign out = sel[1] ? (sel[0] ? in_3 : in_2) : (sel[0] ? in_1 : in_3);
endmodule
//------------------------------------------------------------------------------------------------
module ADD_SUB_BOOTH (in_1, in_2, out);
    input [64:0] in_1;
    input [31:0] in_2;
    output [64:0] out;
    wire [64:0] net_1, net_2, net_3;
    wire c;

FULL_ADDER_32BITS entity_1 (in_1[64:33], in_2, 1'b0, net_1[63:32], c);
FULL_SUBTRACTOR_32BITS entity_2 (in_1[64:33], in_2, 1'b0, net_2[63:32], c);
    assign net_1[64] = net_1[63];
    assign net_2[64] = net_2[63];
    assign net_3[64] = in_1[64];
    assign net_1[31:0] = in_1[32:1];
    assign net_2[31:0] = in_1[32:1];
    assign net_3[63:0] = in_1[64:1];
CHECK_LSB_BOOTH entity_3 (net_1, net_2, net_3, {in_1[1],in_1[0]}, out);
endmodule
//------------------------------------------------------------------------------------------------
module BOOTH_ALGORITHM (in_1, in_2, out);
    input [31:0] in_1, in_2;
    output [63:0] out;
    wire [64:0] in_1_1 [0:32];
    genvar i;

    assign in_1_1[0] = {32'd0,in_1,1'b0};
    generate
        for (i=0;i<32;i=i+1) begin
            ADD_SUB_BOOTH entity_5 (in_1_1[i], in_2, in_1_1[i+1]);
        end
    endgenerate
    assign out = in_1_1[32][64:1];
endmodule
//------------------------------------------------------------------------------------------------
module CHECK_LSB_BOOTH_48BITS (in_1, in_2, in_3, sel, out);
    input [48:0] in_1, in_2, in_3;
    input [1:0] sel;
    output [48:0] out;

    assign out = sel[1] ? (sel[0] ? in_3 : in_2) : (sel[0] ? in_1 : in_3);
endmodule
//------------------------------------------------------------------------------------------------
module ADD_SUB_BOOTH_48BITS (in_1, in_2, out);
    input [48:0] in_1;
    input [23:0] in_2;
    output [48:0] out;
    wire [48:0] net_1, net_2, net_3;
    wire c;

FULL_ADDER_24BITS entity_6 (in_1[48:25], in_2, 1'b0, net_1[47:24], c);
FULL_SUBTRACTOR_24BITS entity_7 (in_1[48:25], in_2, 1'b0, net_2[47:24], c);
    assign net_1[48] = net_1[47];
    assign net_2[48] = net_2[47];
    assign net_3[48] = in_1[48];
    assign net_1[23:0] = in_1[24:1];
    assign net_2[23:0] = in_1[24:1];
    assign net_3[47:0] = in_1[48:1];
CHECK_LSB_BOOTH_48BITS entity_8 (net_1, net_2, net_3, {in_1[1],in_1[0]}, out);
endmodule
//------------------------------------------------------------------------------------------------
module BOOTH_ALGORITHM_48BITS (in_1, in_2, out);
    input [23:0] in_1, in_2;
    output [47:0] out;
    wire [48:0] in_1_1 [0:24];
    genvar i;

    assign in_1_1[0] = {24'd0,in_1,1'b0};
    generate
        for (i=0;i<24;i=i+1) begin
            ADD_SUB_BOOTH_48BITS entity_10 (in_1_1[i], in_2, in_1_1[i+1]);
        end
    endgenerate
    assign out = in_1_1[24][48:1];
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module BOOTH_ALGORITHM_TB;

    reg [31:0] in_1, in_2;
    wire [63:0] out;

BOOTH_ALGORITHM uut (in_1, in_2, out);
    initial begin
        #10
        in_1 = 32'd12;
        in_2 = 32'd13;
        #10
        in_1 = 32'd46;
        in_2 = 32'd50;
        #10
        in_1 = 32'd89;
        in_2 = 32'd134;
        #10
        in_1 = 32'b00000000101101001000010100011111;
        in_2 = 32'b00000000111111001000010100011111;
        #10
        in_1 = 32'b00000000110010011001100110011010;
        in_2 = 32'b00000000111001100011110101110001;
        #10
        in_1 = 32'b00000000110100100110011001100110;
        in_2 = 32'b00000000110000001010001111010111;
    end
/*
    reg [23:0] in_1, in_2;
    wire [47:0] out;

BOOTH_ALGORITHM_48BITS uut (in_1, in_2, out);
    initial begin
        #10
        in_1 = 24'd12;
        in_2 = 24'd13;
        #10
        in_1 = 24'd46;
        in_2 = 24'd50;
        #10
        in_1 = 24'd89;
        in_2 = 24'd134;
        #10
        in_1 = 24'b101101001000010100011111;
        in_2 = 24'b111111001000010100011111;
        #10
        in_1 = 24'b110010011001100110011010;
        in_2 = 24'b111001100011110101110001;
        #10
        in_1 = 24'b110100100110011001100110;
        in_2 = 24'b110000001010001111010111;
    end
*/
endmodule
//------------------------------------------------------------------------------------------------