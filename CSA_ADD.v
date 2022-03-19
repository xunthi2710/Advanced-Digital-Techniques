//----------------------------------------------------------------------------
module FULL_ADDER (a, b, c_in, sum, c_out);
    input wire a, b, c_in;
    output wire sum, c_out;
    wire s1, c1, c2;

    xor (s1, a, b); 
    xor (sum, s1, c_in);
    and (c1, a, b);
    and (c2, s1, c_in);
    or (c_out, c1, c2);
endmodule
//----------------------------------------------------------------------------
module FULL_ADDER_4BITS (a, b, c_in, sum, c_out);
    input wire [3:0] a, b;
    input wire c_in;
    output wire [3:0] sum;
    output wire c_out;
    wire [3:1] x;

FULL_ADDER entity_1 (a[0], b[0], c_in, sum[0], x[1]);
FULL_ADDER entity_2 (a[1], b[1], x[1], sum[1], x[2]);
FULL_ADDER entity_3 (a[2], b[2], x[2], sum[2], x[3]);
FULL_ADDER entity_4 (a[3], b[3], x[3], sum[3], c_out);
endmodule
//-----------------------------------------------------------------------------
module mux2X1 (in0, in1, sel, out);
    input wire in0, in1, sel;
    output wire out;
    wire net0, net1, selnot;

    not (selnot, sel);
    and (net0, in0, selnot);
    and (net1, in1, sel);
    or (out, net0, net1);
endmodule
//----------------------------------------------------------------------------
module mux2X2 (in0, in1, sel, out);
    input wire [1:0] in0, in1;
    input wire sel;
    output wire [1:0] out;
    wire net00, net10, selnot0, net01, net11, selnot1;

mux2X1 entity_5 (in0[0], in1[0], sel, out[0]);
mux2X1 entity_6 (in0[1], in1[1], sel, out[1]);
endmodule
//----------------------------------------------------------------------------
module mux2X4 (in0, in1, sel, out);
    input wire [3:0] in0, in1;
    input wire sel;
    output wire [3:0] out;

mux2X2 entity_7 (in0[1:0], in1[1:0], sel, out[1:0]);
mux2X2 entity_8 (in0[3:2], in1[3:2], sel, out[3:2]);
endmodule
//----------------------------------------------------------------------------
module mux2X8 (in0, in1, sel, out);
    input wire [7:0] in0, in1;
    input wire sel;
    output wire [7:0] out;

mux2X4 entity_9 (in0[3:0], in1[3:0], sel, out[3:0]);
mux2X4 entity_10 (in0[7:4], in1[7:4], sel, out[7:4]);
endmodule
//----------------------------------------------------------------------------
module mux2X16 (in0, in1, sel, out);
    input wire [15:0] in0, in1;
    input wire sel;
    output wire [15:0] out;

mux2X8 entity_11 (in0[7:0], in1[7:0], sel, out[7:0]);
mux2X8 entity_12 (in0[15:8], in1[15:8], sel, out[15:8]);
endmodule
//----------------------------------------------------------------------------
module mux2X32 (in0, in1, sel, out);
    input wire [31:0] in0, in1;
    input wire sel;
    output wire [31:0] out;

mux2X16 entity_13 (in0[15:0], in1[15:0], sel, out[15:0]);
mux2X16 entity_14 (in0[31:16], in1[31:16], sel, out[31:16]);
endmodule
//----------------------------------------------------------------------------
module CSA_4BITS (a, b, c_in, sum, c_out);
    input wire [3:0] a, b;
    input wire c_in;
    output wire [3:0] sum;
    output wire c_out;
    wire [1:0] s0, s1;
    wire c0, c1, c2, c3, c4, c5;

FULL_ADDER entity_15 (a[0], b[0], c_in, sum[0], c0);
FULL_ADDER entity_16 (a[1], b[1], c0, sum[1], c1);

FULL_ADDER entity_17 (a[2], b[2], 1'b0, s0[0], c2);
FULL_ADDER entity_18 (a[3], b[3], c2, s0[1], c3);
FULL_ADDER entity_19 (a[2], b[2], 1'b1, s1[0], c4);
FULL_ADDER entity_20 (a[3], b[3], c4, s1[1], c5);

mux2X1 entity_21 (c3, c5, c1, c_out);
mux2X2 entity_22 (s0, s1, c1, sum[3:2]);
endmodule
//----------------------------------------------------------------------------
module CSA_8BITS (a, b, c_in, sum, c_out);
    input wire [7:0] a, b;
    input wire c_in;
    output wire [7:0] sum;
    output wire c_out;
    wire [3:0] s0, s1;
    wire c0, c1, c2;

CSA_4BITS entity_23 (a[3:0], b[3:0], c_in, sum[3:0], c0);

CSA_4BITS entity_24 (a[7:4], b[7:4], 1'b0, s0, c1);
CSA_4BITS entity_25 (a[7:4], b[7:4], 1'b1, s1, c2);

mux2X1 entity_26 (c1, c2, c0, c_out);
mux2X4 entity_27 (s0, s1, c0, sum[7:4]);
endmodule
//----------------------------------------------------------------------------
module CSA_16BITS (a, b, c_in, sum, c_out);
    input wire [15:0] a, b;
    input wire c_in;
    output wire [15:0] sum;
    output wire c_out;
    wire [7:0] s0, s1;
    wire c0, c1, c2;

CSA_8BITS entity_28 (a[7:0], b[7:0], c_in, sum[7:0], c0);

CSA_8BITS entity_29 (a[15:8], b[15:8], 1'b0, s0, c1);
CSA_8BITS entity_30 (a[15:8], b[15:8], 1'b1, s1, c2);

mux2X1 entity_31 (c1, c2, c0, c_out);
mux2X8 entity_32 (s0, s1, c0, sum[15:8]);
endmodule
//----------------------------------------------------------------------------
module CSA_32BITS (a, b, c_in, sum, c_out);
    input wire [31:0] a, b;
    input wire c_in;
    output wire [31:0] sum;
    output wire c_out;
    wire [15:0] s0, s1;
    wire c0, c1, c2;

CSA_16BITS entity_33 (a[15:0], b[15:0], c_in, sum[15:0], c0);

CSA_16BITS entity_34 (a[31:16], b[31:16], 1'b0, s0, c1);
CSA_16BITS entity_35 (a[31:16], b[31:16], 1'b1, s1, c2);

mux2X1 entity_36 (c1, c2, c0, c_out);
mux2X16 entity_37 (s0, s1, c0, sum[31:16]);
endmodule
//----------------------------------------------------------------------------

`timescale 1ns/1ps
module CSA_TB;
    reg [31:0] a, b;
    reg c_in;
    wire [31:0] sum;
    wire c_out;

//Verilog code for the structural full adder 
CSA_32BITS uut (a, b, c_in, sum, c_out);
    initial begin
        #10
        a = 32'b00000000100000111100001110101110;
        b = 32'b00000000000001110010011110101110;
        c_in = 0;
        #10
        a = 32'b00000000110000100111011111010111;
        b = 32'b00000000101110111000111111010111;
        c_in = 1;
        #10 
        a = 32'b00000000101110101110000101001000;
        b = 32'b00000000010110011001100110011001;
        c_in = 0;
        #10
        a = 32'b00000000111111010111000010100100;
        b = 32'b00000000111111010111000010100100;
        c_in = 1;
/*
        #10
        a = 8'd44;
        b = -8'd14;
        c_in = 0;
        #10
        a = -8'd45;
        b = 8'd45;
        c_in = 1;
        #10
        a = 8'd16;
        b = -8'd56;
        c_in = 0;
        #10 
        a = 8'd6;
        b = -8'd4;
        c_in = 1;
*/
    end
endmodule
//----------------------------------------------------------------------------
module mux2X64 (in0, in1, sel, out);
    input wire [63:0] in0, in1;
    input wire sel;
    output wire [63:0] out;

mux2X32 entity_38 (in0[31:0], in1[31:0], sel, out[31:0]);
mux2X32 entity_39 (in0[63:32], in1[63:32], sel, out[63:32]);
endmodule