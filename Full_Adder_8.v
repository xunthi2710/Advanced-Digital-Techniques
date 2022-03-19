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
module FULL_ADDER_8BITS (a, b, c_in, sum, c_out);
    input wire [7:0] a, b;
    input wire c_in;
    output wire [7:0] sum;
    output wire c_out;
    wire [7:1] x;

FULL_ADDER entity_1 (a[0], b[0], c_in, sum[0], x[1]);
FULL_ADDER entity_2 (a[1], b[1], x[1], sum[1], x[2]);
FULL_ADDER entity_3 (a[2], b[2], x[2], sum[2], x[3]);
FULL_ADDER entity_4 (a[3], b[3], x[3], sum[3], x[4]);
FULL_ADDER entity_5 (a[4], b[4], x[4], sum[4], x[5]);
FULL_ADDER entity_6 (a[5], b[5], x[5], sum[5], x[6]);
FULL_ADDER entity_7 (a[6], b[6], x[6], sum[6], x[7]);
FULL_ADDER entity_8 (a[7], b[7], x[7], sum[7], c_out);
endmodule
//-----------------------------------------------------------------------------
/*
`timescale 1ns/1ps
module FULL_ADDER_8BITS_TB;
    reg [7:0] A, B;
    reg Cin;
    wire [7:0] S;
    wire Cout;  

  FULL_ADDER_8BITS uut(
    .a(A),
    .b(B),
    .c_in(Cin),
    .sum(S),
    .c_out(Cout) 
   );
 initial begin
   #5
   A = 8'd6;
   B = 8'd7;
   Cin = 0;
   #5;
   A = 8'd10;
   B = 8'd1;
   Cin = 1;
   #5;  
   A = 8'd10;
   B = 8'd6;
   Cin = 0;
   #5;
   A = 8'd12;
   B = 8'd3;
   Cin = 1;
   #5;
   A = 8'd46;
   B = -8'd13;
   Cin = 0;
   #5;
   A = -8'd46;
   B = 8'd46;
   Cin = 1;
   #5;
   A = 8'd90;
   B = -8'd50;
   Cin = 0;
   #5;  
   A = 8'd44;
   B = 8'd66;
   Cin = 1;
   #5;  
  end
endmodule 
*/
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
module FULL_ADDER_32BITS (a, b, c_in, sum, c_out);

    input wire [31:0] a, b;
    input wire c_in;
    output wire [31:0] sum;
    output wire c_out;
    wire [3:1] x;

FULL_ADDER_8BITS entity_9 (a[7:0], b[7:0], c_in, sum[7:0], x[1]);
FULL_ADDER_8BITS entity_10 (a[15:8], b[15:8], x[1], sum[15:8], x[2]);
FULL_ADDER_8BITS entity_11 (a[23:16], b[23:16], x[2], sum[23:16], x[3]);
FULL_ADDER_8BITS entity_12 (a[31:24], b[31:24], x[3], sum[31:24], c_out);
endmodule
//-----------------------------------------------------------------------------
/*
`timescale 10ns/ 10ps;
module FULL_ADDER_32BITS_TB;
  reg [31:0] A, B;
  reg Cin;
  wire [31:0] S;
  wire Cout;  
 //Verilog code for the structural full adder 
 FULL_ADDER_32BITS uut(
    .a(A),
    .b(B),
    .c_in(Cin),
    .sum(S),
    .c_out(Cout) 
   );
 initial begin
   A = 32'd46;
   B = 32'd47;
   Cin = 0;
   #5;
   A = 32'd110;
   B = 32'd1;
   Cin = 1;
   #5;  
   A = 32'd1100;
   B = 32'd46;
   Cin = 0;
   #5;
   A = 32'd12;
   B = 32'd3;
   Cin = 1;
   #5;
   A = 32'd46;
   B = -32'd13;
   Cin = 0;
   #5;
   A = -32'd46;
   B = 32'd46;
   Cin = 1;
   #5;
   A = 32'd90;
   B = -32'd50;
   Cin = 0;
   #5;  
   A = 32'd4646;
   B = 32'd6464;
   Cin = 1;
   #5;  
  end
endmodule
*/
//-----------------------------------------------------------------------------

module FULL_ADDER_48BITS (a, b, c_in, sum, c_out);
    input wire [47:0] a, b;
    input wire c_in;
    output wire [47:0] sum;
    output wire c_out;
    wire [5:1] x;

FULL_ADDER_8BITS entity_13 (a[7:0], b[7:0], c_in, sum[7:0], x[1]);
FULL_ADDER_8BITS entity_14 (a[15:8], b[15:8], x[1], sum[15:8], x[2]);
FULL_ADDER_8BITS entity_15 (a[23:16], b[23:16], x[2], sum[23:16], x[3]);
FULL_ADDER_8BITS entity_16 (a[31:24], b[31:24], x[3], sum[31:24], x[4]);
FULL_ADDER_8BITS entity_17 (a[39:32], b[39:32], x[4], sum[39:32], x[5]);
FULL_ADDER_8BITS entity_18 (a[47:40], b[47:40], x[5], sum[47:40], c_out);
endmodule

//-----------------------------------------------------------------------------

`timescale 10ns/ 10ps
module FULL_ADDER_TB;
    reg [31:0] a, b;    
    reg c_in;
    wire [31:0] sum;
    wire c_out;  

//Verilog code for the structural full adder 
FULL_ADDER_32BITS uut(a, b, c_in, sum, c_out);
    initial begin
        /*
        #10
        a = 4'd4;
        b = 4'd7;
        c_in = 0;
        #10
        a = 4'd10;
        b = 4'd1;
        c_in = 1;
        #10 
        a = 4'd10;
        b = 4'd4;
        c_in = 0;
        #10
        a = 4'd12;
        b = 4'd3;
        c_in = 1;
        #10
        a = 4'd4;
        b = -4'd13;
        c_in = 0;
        #10
        a = -4'd4;
        b = 4'd4;
        c_in = 1;
        #10
        a = 4'd9;
        b = -4'd5;
        c_in = 0;
        #10 
        a = 4'd6;
        b = 4'd4;
        c_in = 1;
        */
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
    end
endmodule

//-----------------------------------------------------------------------------

module FULL_ADDER_24BITS (a, b, c_in, sum, c_out);
    input wire [23:0] a, b;
    input wire c_in;
    output wire [23:0] sum;
    output wire c_out;
    wire [2:1] x;

FULL_ADDER_8BITS entity_13 (a[7:0], b[7:0], c_in, sum[7:0], x[1]);
FULL_ADDER_8BITS entity_14 (a[15:8], b[15:8], x[1], sum[15:8], x[2]);
FULL_ADDER_8BITS entity_15 (a[23:16], b[23:16], x[2], sum[23:16], c_out);
endmodule
//-----------------------------------------------------------------------------
module FULL_ADDER_9BITS (a, b, c_in, sum, c_out);

    input wire [8:0] a, b;
    input wire c_in;
    output wire [8:0] sum;
    output wire c_out;
    wire x;

FULL_ADDER_8BITS entity_16 (a[7:0], b[7:0], c_in, sum[7:0], x);
FULL_ADDER entity_17 (a[8], b[8], x, sum[8], c_out);
endmodule
//-----------------------------------------------------------------------------
module FULL_ADDER_4BITS (a, b, c_in, sum, c_out);
    input wire [3:0] a, b;
    input wire c_in;
    output wire [3:0] sum;
    output wire c_out;
    wire [3:1] x;

FULL_ADDER entity_18 (a[0], b[0], c_in, sum[0], x[1]);
FULL_ADDER entity_19 (a[1], b[1], x[1], sum[1], x[2]);
FULL_ADDER entity_20 (a[2], b[2], x[2], sum[2], x[3]);
FULL_ADDER entity_21 (a[3], b[3], x[3], sum[3], c_out);
endmodule
//-----------------------------------------------------------------------------
module FULL_ADDER_64BITS (a, b, c_in, sum, c_out);

    input wire [63:0] a, b;
    input wire c_in;
    output wire [63:0] sum;
    output wire c_out;
    wire x;

FULL_ADDER_32BITS entity_22 (a[31:0], b[31:0], c_in, sum[31:0], x);
FULL_ADDER_32BITS entity_23 (a[63:32], b[63:32], x, sum[63:32], c_out);
endmodule
//-----------------------------------------------------------------------------
