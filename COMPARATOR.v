//------------------------------------------------------------------------------------------------
module COMPARATOR (a, b, eq, gt, lt);
    input a, b;
    output eq, gt, lt;
    wire net1, net2, net3, net4;

    not (net1, a);
    not (net2, b);
    and (net3, a, b);
    and (net4, net1, net2);
    or (eq, net3, net4);
    and (gt, a, net2);
    and (lt, net1, b);

/*
    assign eq = (a&b)|(~a&~b);
    assign gt = a&~b;
    assign lt = ~a&b;
*/
endmodule
//------------------------------------------------------------------------------------------------
module COMPARATOR_4BITS (a, b, eq, gt, lt);
    input wire [3:0] a, b;
    output wire eq, gt, lt;
    wire [3:0] e, g, l;
    wire net1, net2, net3, net4, net5;

COMPARATOR entity_1 (a[0], b[0], e[0], g[0], l[0]);
COMPARATOR entity_2 (a[1], b[1], e[1], g[1], l[1]);
COMPARATOR entity_3 (a[2], b[2], e[2], g[2], l[2]);
COMPARATOR entity_4 (a[3], b[3], e[3], g[3], l[3]);

    and (eq, e[0], e[1], e[2], e[3]);
    and (net1, g[2], e[3]);
    and (net2, g[1], e[3], e[2]);
    and (net3, g[0], e[3], e[2], e[1]);
    or (gt, g[3], net1, net2, net3);
    not (net4, eq);
    not (net5, gt);
    and (lt, net4, net5);
/*
    assign eq = e[0]&e[1]&e[2]&e[3];
    assign gt = (g[3])|(g[2]&e[3])|(g[1]&e[3]&e[2])|(g[0]&e[3]&e[2]&e[1]);
    assign lt = ~eq&~gt;
*/
endmodule
//------------------------------------------------------------------------------------------------
module COMPARATOR_8BITS (a, b, eq, gt, lt);
    input wire [7:0] a, b;
    output wire eq, gt, lt;
    wire [1:0] e, g, l;
    wire net1, net2, net3;

COMPARATOR_4BITS entity_5 (a[3:0], b[3:0], e[0], g[0], l[0]);
COMPARATOR_4BITS entity_6 (a[7:4], b[7:4], e[1], g[1], l[1]);

    and (eq, e[0], e[1]);
    and (net1, g[0], e[1]);
    or (gt, g[1], net1);
    not (net2, eq);
    not (net3, gt);
    and (lt, net2, net3);
/*
    assign eq = e[0]&e[1];
    assign gt = (g[1])|(g[0]&e[1]);
    assign lt = ~eq&~gt;
*/
endmodule
//------------------------------------------------------------------------------------------------
module COMPARATOR_32BITS (a, b, eq, gt, lt);
    input wire [31:0] a, b;
    output wire eq, gt, lt;
    wire [3:0] e, g, l;
    wire net1, net2, net3, net4, net5;

COMPARATOR_8BITS entity_7 (a[7:0], b[7:0], e[0], g[0], l[0]);
COMPARATOR_8BITS entity_8 (a[15:8], b[15:8], e[1], g[1], l[1]);
COMPARATOR_8BITS entity_9 (a[23:16], b[23:16], e[2], g[2], l[2]);
COMPARATOR_8BITS entity_10 (a[31:24], b[31:24], e[3], g[3], l[3]);

    and (eq, e[0], e[1], e[2], e[3]);
    and (net1, g[2], e[3]);
    and (net2, g[1], e[3], e[2]);
    and (net3, g[0], e[3], e[2], e[1]);
    or (gt, g[3], net1, net2, net3);
    not (net4, eq);
    not (net5, gt);
    and (lt, net4, net5);
/*
    assign eq = e[0]&e[1]&e[2]&e[3];
    assign gt = (g[3])|(g[2]&e[3])|(g[1]&e[3]&e[2])|(g[0]&e[3]&e[2]&e[1]);
    assign lt = ~eq&~gt;
*/
endmodule   
//------------------------------------------------------------------------------------------------
module COMPARATOR_16BITS (a, b, eq, gt, lt);
    input wire [15:0] a, b;
    output wire eq, gt, lt;
    wire [1:0] e, g, l;
    wire net1, net2, net3;

COMPARATOR_8BITS entity_11 (a[7:0], b[7:0], e[0], g[0], l[0]);
COMPARATOR_8BITS entity_12 (a[15:8], b[15:8], e[1], g[1], l[1]);

    and (eq, e[0], e[1]);
    and (net1, g[0], e[1]);
    or (gt, g[1], net1);
    not (net2, eq);
    not (net3, gt);
    and (lt, net2, net3);
/*
    assign eq = e[0]&e[1];
    assign gt = (g[1])|(g[0]&e[1]);
    assign lt = ~eq&~gt;
*/
endmodule
//------------------------------------------------------------------------------------------------
module COMPARATOR_24BITS (a, b, eq, gt, lt);
    input wire [23:0] a, b;
    output wire eq, gt, lt;
    wire [1:0] e, g, l;
    wire net1, net2, net3;

COMPARATOR_16BITS entity_13 (a[15:0], b[15:0], e[0], g[0], l[0]);
COMPARATOR_8BITS entity_14 (a[23:16], b[23:16], e[1], g[1], l[1]);

    and (eq, e[0], e[1]);
    and (net1, g[0], e[1]);
    or (gt, g[1], net1);
    not (net2, eq);
    not (net3, gt);
    and (lt, net2, net3);
/*
    assign eq = e[0]&e[1];
    assign gt = (g[1])|(g[0]&e[1]);
    assign lt = ~eq&~gt;
*/
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module COMPARATOR_TB;
    // Variables    
    reg [24:0] a, b;
    wire eq, gt, lt;
    // Call comparator
COMPARATOR_25BITS uut (a, b, eq, gt, lt);

    // Test input
initial begin  
    #10
        a = 25'd1234;
        b = 25'd1235;
    #10
        a = 25'd667;
        b = 25'd890;
    #10
        a = 25'd200;
        b = 25'd200;        
    end   
endmodule
//------------------------------------------------------------------------------------------------
module COMPARATOR_25BITS (a, b, eq, gt, lt);
    input wire [24:0] a, b;
    output wire eq, gt, lt;
    wire [2:0] e, g, l;
    wire net1, net2, net3, net4;

COMPARATOR_16BITS entity_15 (a[15:0], b[15:0], e[0], g[0], l[0]);
COMPARATOR_8BITS entity_16 (a[23:16], b[23:16], e[1], g[1], l[1]);
COMPARATOR entity_17 (a[24], b[24], e[2], g[2], l[2]);

    and (eq, e[0], e[1], e[2]);
    and (net1, g[1], e[2]);
    and (net2, g[0], e[2], e[1]);
    or (gt, g[2], net1, net2);
    not (net3, eq);
    not (net4, gt);
    and (lt, net3, net4);
/*
    assign eq = e[0]&e[1]e[2];
    assign gt = (g[2])|(g[1]&e[2])|(g[0]&e[2]&e[1]);
    assign lt = ~eq&~gt;
*/
endmodule
//------------------------------------------------------------------------------------------------
module COMPARATOR_9BITS (a, b, eq, gt, lt);
    input wire [8:0] a, b;
    output wire eq, gt, lt;
    wire [2:0] e, g, l;
    wire net1, net2, net3;

COMPARATOR_8BITS entity_18 (a[7:0], b[7:0], e[0], g[0], l[0]);
COMPARATOR entity_19 (a[8], b[8], e[1], g[1], l[1]);

    and (eq, e[0], e[1]);
    and (net1, g[0], e[1]);
    or (gt, g[1], net1);
    not (net2, eq);
    not (net3, gt);
    and (lt, net2, net3);
/*
    assign eq = e[0]&e[1];
    assign gt = (g[1])|(g[0]&e[1]);
    assign lt = ~eq&~gt;
*/
endmodule
//------------------------------------------------------------------------------------------------