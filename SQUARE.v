//------------------------------------------------------------------------------------------------
module COMPARE_WITH_1 (in_1, flag);
    input [31:0] in_1;
    output flag;
    wire flag1, flag2;

COMPARATOR_32BITS entity_1 ({1'b0,in_1[30:0]}, 32'h3f800000, flag1, flag, flag2);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module COMPARE_WITH_1_TB;
    reg [31:0] in_1;
    wire flag;

COMPARE_WITH_1 uut (in_1, flag);
    initial begin
        #10
        in_1 = 32'h5;
        #10
        in_1 = 32'h1;
        #10
        in_1 = -32'h5;
    end
endmodule

//------------------------------------------------------------------------------------------------
module INVERSE (in_1, out);
    input [31:0] in_1;
    output [31:0] out;
    wire flag1, flag2, flag3;

DIV_2021 entity_2 (32'h3f800000, in_1, flag1, flag2, flag3, out);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module INVERSE_TB;
    reg [31:0] in_1;
    wire [31:0] out;
    
INVERSE uut (in_1, out);
    initial begin
        #10
        in_1 = 32'h40a00000; // 5 --- out = 32'h3e4ccccd (0.2)
        #10
        in_1 = 32'h41200000; // 10 --- out = 32'h3dcccccd (0.1)
        #10
        in_1 = 32'h41a00000; // 20 --- out = 32'h3d4ccccd (0.05)
    end
endmodule

//------------------------------------------------------------------------------------------------
module NATURAL_LOGARIT (in_1, out);
    input [31:0] in_1;
    output [31:0] out;
    
    wire [31:0] in_1_1;
    wire flag1;
ADD_SUB_2021 entity_3 (in_1, 32'h3f800000, 1'b1, flag1, in_1_1); // (x-1) 

    wire [31:0] in_1_1_2, taylor_2;
    wire flag2, flag3, flag4, flag5, flag6, flag7;
MUL_2021 entity_4 (in_1_1, in_1_1, flag2, flag3, flag4, in_1_1_2); // (x-1)^2
DIV_2021 entity_5 (in_1_1_2, 32'hc0000000, flag5, flag6, flag7, taylor_2); //(x-1)^2/-2

    wire [31:0] in_1_1_3, taylor_3;
    wire flag8, flag9, flag10, flag11, flag12, flag13;
MUL_2021 entity_6 (in_1_1_2, in_1_1, flag8, flag9, flag10, in_1_1_3); // (x-1)^3
DIV_2021 entity_7 (in_1_1_3, 32'h40400000, flag11, flag12, flag13, taylor_3); // (x-1)^3/3

    wire [31:0] in_1_1_4, taylor_4;
    wire flag14, flag15, flag16, flag17, flag18, flag19;
MUL_2021 entity_8 (in_1_1_3, in_1_1, flag14, flag15, flag16, in_1_1_4); // (x-1)^4
DIV_2021 entity_9 (in_1_1_4, 32'hc0800000, flag17, flag18, flag19, taylor_4); // (x-1)^4/-4

    wire [31:0] in_1_1_5, taylor_5;
    wire flag20, flag21, flag22, flag23, flag24, flag25;
MUL_2021 entity_10 (in_1_1_4, in_1_1, flag20, flag21, flag22, in_1_1_5); // (x-1)^5
DIV_2021 entity_11 (in_1_1_5, 32'h40a00000, flag23, flag24, flag25, taylor_5); // (x-1)^5/5

    wire [31:0] in_1_1_6, taylor_6;
    wire flag26, flag27, flag28, flag29, flag30, flag31;
MUL_2021 entity_12 (in_1_1_5, in_1_1, flag26, flag27, flag28, in_1_1_6); // (x-1)^6
DIV_2021 entity_13 (in_1_1_6, 32'hc0c00000, flag29, flag30, flag31, taylor_6); // (x-1)^6/-6

    wire [31:0] in_1_1_7, taylor_7;
    wire flag32, flag33, flag34, flag35, flag36, flag37;
MUL_2021 entity_14 (in_1_1_6, in_1_1, flag32, flag33, flag34, in_1_1_7); // (x-1)^7
DIV_2021 entity_15 (in_1_1_7, 32'h40e00000, flag35, flag36, flag37, taylor_7); // (x-1)^7/7

    wire [31:0] in_1_1_8, taylor_8;
    wire flag38, flag39, flag40, flag41, flag42, flag43;
MUL_2021 entity_16 (in_1_1_7, in_1_1, flag38, flag39, flag40, in_1_1_8); // (x-1)^8
DIV_2021 entity_17 (in_1_1_8, 32'hc1000000, flag41, flag42, flag43, taylor_8); // (x-1)^8/-8

    wire [31:0] in_1_1_9, taylor_9;
    wire flag44, flag45, flag46, flag47, flag48, flag49;
MUL_2021 entity_18 (in_1_1_8, in_1_1, flag44, flag45, flag46, in_1_1_9); // (x-1)^9
DIV_2021 entity_19 (in_1_1_9, 32'h41100000, flag47, flag48, flag49, taylor_9); // (x-1)^9/9

    wire [31:0] in_1_1_10, taylor_10;
    wire flag50, flag51, flag52, flag53, flag54, flag55;
MUL_2021 entity_20 (in_1_1_9, in_1_1, flag50, flag51, flag52, in_1_1_10); // (x-1)^10
DIV_2021 entity_21 (in_1_1_10, 32'hc1200000, flag53, flag54, flag55, taylor_10); // (x-1)^10/-10

    wire [31:0] out_1, out_2, out_3, out_4, out_5;
    wire flag56, flag57, flag58, flag59, flag60;
ADD_SUB_2021 entity_22 (in_1_1, taylor_2, 1'b0, flag56, out_1);
ADD_SUB_2021 entity_23 (taylor_3, taylor_4, 1'b0, flag57, out_2);
ADD_SUB_2021 entity_24 (taylor_5, taylor_6, 1'b0, flag58, out_3);
ADD_SUB_2021 entity_25 (taylor_7, taylor_8, 1'b0, flag59, out_4);
ADD_SUB_2021 entity_26 (taylor_9, taylor_10, 1'b0, flag60, out_5);

    wire [31:0] out_6, out_7, out_8;
    wire flag61, flag62, flag63, flag64;
ADD_SUB_2021 entity_27 (out_1, out_2, 1'b0, flag61, out_6);
ADD_SUB_2021 entity_28 (out_3, out_4, 1'b0, flag62, out_7);
ADD_SUB_2021 entity_29 (out_6, out_7, 1'b0, flag63, out_8);
ADD_SUB_2021 entity_30 (out_5, out_8, 1'b0, flag64, out);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module NATURAL_LOGARIT_TB;
    reg [31:0] in_1;
    wire [31:0] out;

NATURAL_LOGARIT uut (in_1, out);
    initial begin
        #10
        in_1 = 32'h40a00000; // 5 --- out = -82106.45079 (32'hc7a05d3a)
        #10
        in_1 = 32'h41200000; // 10 --- out = -310407470.4 (32'hcd940389)
        #10
        in_1 = 32'h41a00000; // 20 --- out = -579255062800 (32'hd306de4b)
    end
endmodule

//------------------------------------------------------------------------------------------------
module INVERT_1 (in_1, out);
    input [31:0] in_1;
    output [31:0] out;
    wire net1;

    not (net1, in_1[31]);
    assign out = {net1,in_1[30:0]};
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module INVERT_1_TB;
    reg [31:0] in_1;
    wire [31:0] out;

INVERT_1 uut (in_1, out);
    initial begin
        #10
        in_1 = 32'h40a00000; // 5
        #10
        in_1 = 32'h41200000; // 10
        #10
        in_1 = 32'h41a00000; // 20
    end
endmodule

//------------------------------------------------------------------------------------------------
module NATURAL_EXPONENT (in_1, out);
    input [31:0] in_1;
    output [31:0] out;

    wire [31:0] in_1_1_2, taylor_2;
    wire flag1, flag2, flag3, flag4, flag5, flag6;
MUL_2021 entity_31 (in_1, in_1, flag1, flag2, flag3, in_1_1_2); // x^2
DIV_2021 entity_32 (in_1_1_2, 32'h40000000, flag4, flag5, flag6, taylor_2); // x^2/2

    wire [31:0] in_1_1_3, taylor_3;
    wire flag7, flag8, flag9, flag10, flag11, flag12;
MUL_2021 entity_33 (in_1_1_2, in_1, flag7, flag8, flag9, in_1_1_3); // x^3
DIV_2021 entity_34 (in_1_1_3, 32'h40c00000, flag10, flag11, flag12, taylor_3); // x^3/6 

    wire [31:0] in_1_1_4, taylor_4;
    wire flag13, flag14, flag15, flag16, flag17, flag18;
MUL_2021 entity_35 (in_1_1_3, in_1, flag13, flag14, flag15, in_1_1_4); // x^4
DIV_2021 entity_36 (in_1_1_4, 32'h41c00000, flag16, flag17, flag18, taylor_4); // x^4/24

    wire [31:0] in_1_1_5, taylor_5;
    wire flag19, flag20, flag21, flag22, flag23, flag24;
MUL_2021 entity_37 (in_1_1_4, in_1, flag19, flag20, flag21, in_1_1_5); // x^5
DIV_2021 entity_38 (in_1_1_5, 32'h42f00000, flag22, flag23, flag24, taylor_5); // x^5/120

    wire [31:0] in_1_1_6, taylor_6;
    wire flag25, flag26, flag27, flag28, flag29, flag30;
MUL_2021 entity_39 (in_1_1_5, in_1, flag25, flag26, flag27, in_1_1_6); // x^6
DIV_2021 entity_40 (in_1_1_6, 32'h44340000, flag28, flag29, flag30, taylor_6); // x^6/720

    wire [31:0] in_1_1_7, taylor_7;
    wire flag31, flag32, flag33, flag34, flag35, flag36;
MUL_2021 entity_41 (in_1_1_6, in_1, flag31, flag32, flag33, in_1_1_7); // x^7
DIV_2021 entity_42 (in_1_1_7, 32'h459d8000, flag34, flag35, flag36, taylor_7); // x^7/5040

    wire [31:0] in_1_1_8, taylor_8; 
    wire flag37, flag38, flag39, flag40, flag41, flag42; 
MUL_2021 entity_43 (in_1_1_7, in_1, flag37, flag38, flag39, in_1_1_8); // x^8
DIV_2021 entity_44 (in_1_1_8, 32'h471d8000, flag40, flag41, flag42, taylor_8); // x^8/40320

    wire [31:0] in_1_1_9, taylor_9;  
    wire flag43, flag44, flag45, flag46, flag47, flag48;
MUL_2021 entity_45 (in_1_1_8, in_1, flag43, flag44, flag45, in_1_1_9); // x^9
DIV_2021 entity_46 (in_1_1_9, 32'h48b13000, flag46, flag47, flag48, taylor_9); // x^9/362880

    wire [31:0] in_1_1_10, taylor_10;  
    wire flag49, flag50, flag51, flag52, flag53, flag54;
MUL_2021 entity_47 (in_1_1_9, in_1, flag49, flag50, flag51, in_1_1_10); // x^10
DIV_2021 entity_48 (in_1_1_10, 32'h4a5d7c00, flag52, flag53, flag54, taylor_10); // x^10/3628800

    wire [31:0] out_1, out_2, out_3, out_4, out_5;
    wire flag55, flag56, flag57, flag58, flag59;
ADD_SUB_2021 entity_49 (in_1, taylor_2, 1'b0, flag55, out_1);
ADD_SUB_2021 entity_50 (taylor_3, taylor_4, 1'b0, flag56, out_2);
ADD_SUB_2021 entity_51 (taylor_5, taylor_6, 1'b0, flag57, out_3);
ADD_SUB_2021 entity_52 (taylor_7, taylor_8, 1'b0, flag58, out_4);
ADD_SUB_2021 entity_53 (taylor_9, taylor_10, 1'b0, flag59, out_5);

    wire [31:0] out_6, out_7, out_8, out_9;
    wire flag60, flag61, flag62, flag63, flag64;
ADD_SUB_2021 entity_54 (out_1, out_2, 1'b0, flag60, out_6);
ADD_SUB_2021 entity_55 (out_3, out_4, 1'b0, flag61, out_7);
ADD_SUB_2021 entity_56 (out_5, out_6, 1'b0, flag62, out_8);
ADD_SUB_2021 entity_57 (out_7, out_8, 1'b0, flag63, out_9);
ADD_SUB_2021 entity_58 (out_9, 32'h3f800000, 1'b0, flag64, out);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module NATURAL_EXPONENT_TB;
    reg [31:0] in_1;
    wire [31:0] out;

NATURAL_EXPONENT uut (in_1, out);
    initial begin
        #10
        in_1 = 32'h40a00000; // 5 --- out = 146.380601 (32'h4312616f)
        #10
        in_1 = 32'h41200000; // 10 --- out = 12842.30511 (32'h4648a938)
        #10
        in_1 = 32'h41a00000; // 20 --- out = 5245469.677 (32'h4aa0143b)
    end
endmodule

//------------------------------------------------------------------------------------------------
module ERROR_CHECKING (in_1, out_1, out_2);
    input [31:0] in_1, out_1;
    output [31:0] out_2;

mux2X32 entity_59 (out_1, 32'h7fffffff, in_1[31], out_2);
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module ERROR_CHECKING_TB;
    reg [31:0] in_1, out_1;
    wire [31:0] out_2;

ERROR_CHECKING uut (in_1, out_1, out_2);
    initial begin
        #10
        in_1 = 32'hd5fdfdff;
        out_1 = 32'h3ddddddd;
        #10
        in_1 = 32'h35fdfdff;
        out_1 = 32'h3edddddd;
    end
endmodule

//------------------------------------------------------------------------------------------------
module CHECKING_NAN (in_1, in_2, out_1, out_2);
    input [31:0] in_1, in_2, out_1;
    output [31:0] out_2;
    wire [31:0] out;
    wire less_1, less_2;
    wire flag1, flag2, flag3, flag4;

COMPARATOR_8BITS entity_59 (in_1[30:23], 8'hff, flag1, flag2, less_1);
COMPARATOR_8BITS entity_60 (in_2[30:23], 8'hff, flag3, flag4, less_2);
    assign out = less_1 ? out_1 : 32'h7fffffff;
    assign out_2 = less_2 ? out : 32'h7fffffff;
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module CHECKING_NAN_TB;
    reg [31:0] in_1, in_2, out_1;
    wire [31:0] out_2;

CHECKING_NAN uut (in_1, in_2, out_1, out_2);
    initial begin
        #10
        in_1 = 32'hd5fdfdff;
        in_2 = 32'h7fffffff;
        out_1 = 32'h3ddddddd;
        #10
        in_1 = 32'h35fdfdff;
        in_2 = 32'h7dffffff;
        out_1 = 32'h3edddddd;
    end
endmodule

//------------------------------------------------------------------------------------------------
module ZERO_CHECKING (in_1, in_2, out_1, out_2);
    input [31:0] in_1, in_2, out_1;
    output [31:0] out_2;
    wire [1:0] sel;

//  assign sel[0] = (|in_1[30:0]);
    or (sel[0], in_1[0], in_1[1], in_1[2], in_1[3], in_1[4], in_1[5], in_1[6], in_1[8], in_1[9], in_1[10], in_1[11], in_1[12], in_1[13], in_1[14], in_1[15], in_1[16], in_1[17], in_1[18], in_1[19], in_1[20], in_1[21], in_1[22], in_1[23], in_1[24], in_1[25], in_1[26], in_1[27], in_1[28], in_1[29], in_1[30]);
//  assign sel[1] = (|in_2[30:0]);
    or (sel[0], in_2[0], in_2[1], in_2[2], in_2[3], in_2[4], in_2[5], in_2[6], in_2[8], in_2[9], in_2[10], in_2[11], in_2[12], in_2[13], in_2[14], in_2[15], in_2[16], in_2[17], in_2[18], in_2[19], in_2[20], in_2[21], in_2[22], in_2[23], in_2[24], in_2[25], in_2[26], in_2[27], in_2[28], in_2[29], in_2[30]);
    assign out_2 = sel[1] ? (sel[0] ? out_1 : 32'd0) : 32'h7fffffff;
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module ZERO_CHECKING_TB;
    reg [31:0] in_1, in_2, out_1;
    wire [31:0] out_2;

ZERO_CHECKING uut (in_1, in_2, out_1, out_2);
    initial begin
        #10
        in_1 = 32'd0;
        in_2 = 32'd0;
        out_1 = 32'h3fb504f3;
        #10
        in_1 = 32'd0;
        in_2 = 32'd2;
        out_1 = 32'h3fb504f3;
        #10
        in_1 = 32'd2;
        in_2 = 32'd0;
        out_1 = 32'h3fb504f3;
        #10
        in_1 = 32'd2;
        in_2 = 32'd2;
        out_1 = 32'h3fb504f3;
    end
endmodule

//------------------------------------------------------------------------------------------------
module INFINITIY_CHECKING (in_1, in_2, out_1, out_2);
    input [31:0] in_1, in_2, out_1;
    output [31:0] out_2;
    wire [1:0] sel;
    wire [7:0] net1, net2;

//  assign sel[0] = (|(~in_1[30:23]));
NOT_8BITS add_1 (in_1[30:23], net1);
    or (sel[0], net1[0], net1[1], net1[2], net1[3], net1[4], net1[5], net1[6], net1[7]);
//  assign sel[1] = (|(~in_2[30:23]));
NOT_8BITS add_2 (in_2[30:23], net2);
    or (sel[1], net2[0], net2[1], net2[2], net2[3], net2[4], net2[5], net2[6], net2[7]);
    assign out_2 = sel[1] ? (sel[0] ? out_1 : 32'h7fffffff) : 32'h7fffffff;
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module INFINITIY_CHECKING_TB;
    reg [31:0] in_1, in_2, out_1;
    wire [31:0] out_2;

INFINITIY_CHECKING uut (in_1, in_2, out_1, out_2);
    initial begin
        #10
        in_1 = 32'h7fffffff;
        in_2 = 32'h7fffffff;
        out_1 = 32'h3edddddd;
        #10
        in_1 = 32'hd5fdfdff;
        in_2 = 32'h7fffffff;
        out_1 = 32'h3ddddddd;
        #10
        in_1 = 32'h7fffffff;
        in_2 = 32'h35fdfdff;
        out_1 = 32'h3edddddd;
        #10
        in_1 = 32'h35fdfdff;
        in_2 = 32'h3edddddd;
        out_1 = 32'h3ed6dddd;
    end
endmodule

//------------------------------------------------------------------------------------------------
module COMPOSE (in_1, sign, out);
    input [31:0] in_1;
    input sign;
    output [31:0] out;

    assign out = {sign,in_1[30:0]};
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module COMPOSE_TB;
    reg [31:0] in_1;
    reg sign;   
    wire [31:0] out;

COMPOSE uut (in_1, sign, out);
    initial begin
        #10
        in_1 = 32'h40a00000; // 5
        sign = 1'b0;
        #10
        in_1 = 32'h41200000; // 10
        sign = 1'b1;
        #10
        in_1 = 32'h41a00000; // 20
        sign = 1'b1;
    end
endmodule

//------------------------------------------------------------------------------------------------
module SQUARE (in_1, in_2, out);
    input wire [31:0] in_1, in_2;
    output wire [31:0] out;
//-----------------------------------------------------------------
    wire flag;
COMPARE_WITH_1 entity_61 (in_1, flag);
//-----------------------------------------------------------------
    wire [31:0] in_1_inverse;
INVERSE entity_62 (in_1, in_1_inverse);
//-----------------------------------------------------------------
    wire [31:0] net_1, net_2, net_3;
NATURAL_LOGARIT entity_63 ({1'b0,in_1[30:0]}, net_1);
NATURAL_LOGARIT entity_64 ({1'b0,in_1_inverse[30:0]}, net_2);
INVERT_1 entity_65 (net_2, net_3);
//-----------------------------------------------------------------
    wire [31:0] net_4;
mux2X32 entity_66 (net_1, net_3, flag, net_4);
//-----------------------------------------------------------------
    wire [31:0] net_5;
    wire flag1, flag2, flag3;
DIV_2021 entity_67 (net_4, in_2, flag1, flag2, flag3, net_5);
//-----------------------------------------------------------------
    wire [31:0] out_1;
NATURAL_EXPONENT entity_68 (net_5, out_1);
//-----------------------------------------------------------------
    wire [31:0] out_2, out_3, out_4, out_5;
ERROR_CHECKING entity_69 (in_1, out_1, out_2);
CHECKING_NAN entity_70 (in_1, in_2, out_2, out_3);  
ZERO_CHECKING entity_71 (in_1, in_2, out_3, out_4);
INFINITIY_CHECKING entity_72 (in_1, in_2, out_4, out_5);
/*
COMPOSE entity_73 (out_5, in_1[31], out);
*/
    assign out = in_1_inverse;
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module SQUARE_TB;
    reg [31:0] in_1, in_2;
    wire [31:0] out;

SQUARE uut (in_1, in_2, out);
    initial begin
        #10
        in_1 = 32'h40800000;
        in_2 = 32'h40000000;
        #10
        in_1 = 32'h42480000;
        in_2 = 32'h40400000;
        #10
        in_1 = 32'h461c4000;
        in_2 = 32'h40a00000;
    end
endmodule
//------------------------------------------------------------------------------------------------