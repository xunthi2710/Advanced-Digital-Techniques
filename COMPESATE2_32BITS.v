//------------------------------------------------------------------------------------------------
module COMPENSATE2_8BITS (a, b);
    input wire [7:0] a;
    output wire [7:0] b;
    wire c, net1;
    wire [7:0] a1;

//  assign a1 = ~a;
NOT_8BITS add_1 (a1, a);
//  LAY BU 2    
FULL_ADDER_8BITS entity_1 (a1, 8'd1, 1'b0, b, c);

endmodule
//------------------------------------------------------------------------------------------------
module COMPENSATE2_32BITS (a, b);
    input wire [31:0] a;
    output wire [31:0] b;
    wire c;
    wire [31:0] a1;

//  assign a1 = ~a;
NOT_32BITS add_2 (a1, a);
//  LAY BU 2
FULL_ADDER_32BITS entity_2 (a1, 32'd1, 1'b0, b, c);
endmodule
//------------------------------------------------------------------------------------------------
module COMPENSATE2_24BITS (a, b);
    input wire [23:0] a;
    output wire [23:0] b;
    wire c;
    wire [23:0] a1;

//  assign a1 = ~a;
NOT_24BITS add_3 (a1, a);
//  LAY BU 2
FULL_ADDER_24BITS entity_2 (a1, 24'd1, 1'b0, b, c);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module COMPENSATE2_32BITS_TB;
    reg [31:0] a;
    wire [31:0] b;

COMPENSATE2_32BITS uut (a, b);
    initial begin
        #10
        a = 32'b00000000000001110010011110101110;
        #10
        a = 32'b00000000101110111000111111010111;
        #10
        a = 32'b00000000010110011001100110011001;
        #10
        a = 32'b00000000111110101110000101001000;
        
    end

endmodule
