//-------------------------------------------------------------------------------------------------------
module FULL_SUBTRACTOR (a, b, b_in, diff, b_out);
    input wire a, b, b_in;
    input wire diff, b_out;
    wire d1, d2, a1, b1, b2;

    xor (d1, a, b);
    xor (diff, d1, b_in);
    not (d2, d1);
    not (a1, a);
    and (b1, a1, b);
    and (b2, d2, b_in);
    or (b_out, b1, b2);
endmodule
//-------------------------------------------------------------------------------------------------------
module FULL_SUBTRACTOR_8BITS (a, b, b_in, diff, b_out);
    input wire [7:0] a, b;
    input wire b_in;
    output wire [7:0] diff;
    output wire b_out;
    wire [7:1] x;

FULL_SUBTRACTOR entity_1 (a[0], b[0], b_in, diff[0], x[1]);
FULL_SUBTRACTOR entity_2 (a[1], b[1], x[1], diff[1], x[2]);
FULL_SUBTRACTOR entity_3 (a[2], b[2], x[2], diff[2], x[3]);
FULL_SUBTRACTOR entity_4 (a[3], b[3], x[3], diff[3], x[4]);
FULL_SUBTRACTOR entity_5 (a[4], b[4], x[4], diff[4], x[5]);
FULL_SUBTRACTOR entity_6 (a[5], b[5], x[5], diff[5], x[6]);
FULL_SUBTRACTOR entity_7 (a[6], b[6], x[6], diff[6], x[7]);
FULL_SUBTRACTOR entity_8 (a[7], b[7], x[7], diff[7], b_out);
endmodule
//-------------------------------------------------------------------------------------------------------
module FULL_SUBTRACTOR_32BITS (a, b, b_in, diff, b_out);

    input wire [31:0] a, b;
    input wire b_in;
    output wire [31:0] diff;
    output wire b_out;
    wire [3:1] x;

FULL_SUBTRACTOR_8BITS entity_9 (a[7:0], b[7:0], b_in, diff[7:0], x[1]);
FULL_SUBTRACTOR_8BITS entity_10 (a[15:8], b[15:8], x[1], diff[15:8], x[2]);
FULL_SUBTRACTOR_8BITS entity_11 (a[23:16], b[23:16], x[2], diff[23:16], x[3]);
FULL_SUBTRACTOR_8BITS entity_12 (a[31:24], b[31:24], x[3], diff[31:24], b_out);
endmodule
//-----------------------------------------------------------------------------
`timescale 10ns/ 10ps
module FULL_SUBTRACTOR_32BITS_TB;
 reg [24:0] A, B;
 reg Bin;
 wire [24:0] D;
 wire Bout;  
 //Verilog code for the structural full adder 
 FULL_SUBTRACTOR_25BITS uut(
    .a(A),
    .b(B),
    .b_in(Bin),
    .diff(D),
    .b_out(Bout) 
   );
 initial begin
   A = 25'd46;
   B = 25'd47;
   Bin = 0;
   #5;
   A = 25'd110;
   B = 25'd1;
   Bin = 1;
   #5;  
   A = 25'd1100;
   B = 25'd46;
   Bin = 0;
   #5;
   A = 25'd12;
   B = 25'd3;
   Bin = 1;
   #5;
   A = 25'd46;
   B = -25'd13;
   Bin = 0;
   #5;
   A = -25'd46;
   B = 25'd46;
   Bin = 1;
   #5;
   A = 25'd90;
   B = -25'd50;
   Bin = 0;
   #5;  
   A = 25'd4646;
   B = 25'd6464;
   Bin = 1;
   #5;  
  end
      
endmodule 
//-------------------------------------------------------------------------------------------------------
module FULL_SUBTRACTOR_9BITS (a, b, b_in, diff, b_out);

    input wire [8:0] a, b;
    input wire b_in;
    output wire [8:0] diff;
    output wire b_out;
    wire x;

FULL_SUBTRACTOR_8BITS entity_13 (a[7:0], b[7:0], b_in, diff[7:0], x);
FULL_SUBTRACTOR entity_14 (a[8], b[8], x, diff[8], b_out);
endmodule
//-------------------------------------------------------------------------------------------------------
module FULL_SUBTRACTOR_24BITS (a, b, b_in, diff, b_out);
    input wire [23:0] a, b;
    input wire b_in;
    output wire [23:0] diff;
    output wire b_out;
    wire [2:1] x;

FULL_SUBTRACTOR_8BITS entity_15 (a[7:0], b[7:0], b_in, diff[7:0], x[1]);
FULL_SUBTRACTOR_8BITS entity_16 (a[15:8], b[15:8], x[1], diff[15:8], x[2]);
FULL_SUBTRACTOR_8BITS entity_17 (a[23:16], b[23:16], x[2], diff[23:16], b_out);
endmodule
//-------------------------------------------------------------------------------------------------------
module FULL_SUBTRACTOR_48BITS (a, b, b_in, diff, b_out);
    input wire [47:0] a, b;
    input wire b_in;
    output wire [47:0] diff;
    output wire b_out;
    wire x;

FULL_SUBTRACTOR_24BITS entity_18 (a[23:0], b[23:0], b_in, diff[23:0], x);
FULL_SUBTRACTOR_24BITS entity_19 (a[47:24], b[47:24], x, diff[47:24], b_out);
endmodule
//-------------------------------------------------------------------------------------------------------
module FULL_SUBTRACTOR_25BITS (a, b, b_in, diff, b_out);
    input wire [24:0] a, b;
    input wire b_in;
    output wire [24:0] diff;
    output wire b_out;
    wire x;

FULL_SUBTRACTOR_24BITS entity_20 (a[23:0], b[23:0], b_in, diff[23:0], x);
FULL_SUBTRACTOR entity_21 (a[24], b[24], x, diff[24], b_out);
endmodule
//-------------------------------------------------------------------------------------------------------