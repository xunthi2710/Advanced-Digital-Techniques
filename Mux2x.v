//----------------------------------------------------------------------------
module mux2X1 (in0, in1, sel, out);
    input in0;
    input in1;
    input sel;
    output out;

    assign out = (sel) ? in1 : in0;   
endmodule
//----------------------------------------------------------------------------
module mux2X2 (in0, in1, sel, out);
    input wire [1:0] in0, in1;
    input wire sel;
    output wire [1:0] out;

mux2X1 entity_1 (in0[0], in1[0], sel, out[0]);
mux2X1 entity_2 (in0[1], in1[1], sel, out[1]);
endmodule
//----------------------------------------------------------------------------
module mux2X4 (in0, in1, sel, out);
    input wire [3:0] in0, in1;
    input wire sel;
    output wire [3:0] out;

mux2X2 entity_3 (in0[1:0], in1[1:0], sel, out[1:0]);
mux2X2 entity_4 (in0[3:2], in1[3:2], sel, out[3:2]);
endmodule
//----------------------------------------------------------------------------
module mux2X8 (in0, in1, sel, out);
    input wire [7:0] in0, in1;
    input wire sel;
    output wire [7:0] out;

mux2X4 entity_5 (in0[3:0], in1[3:0], sel, out[3:0]);
mux2X4 entity_6 (in0[7:4], in1[7:4], sel, out[7:4]);
endmodule
//----------------------------------------------------------------------------
module mux2X16 (in0, in1, sel, out);
    input wire [15:0] in0, in1;
    input wire sel;
    output wire [15:0] out;

mux2X8 entity_7 (in0[7:0], in1[7:0], sel, out[7:0]);
mux2X8 entity_8 (in0[15:8], in1[15:8], sel, out[15:8]);
endmodule
//----------------------------------------------------------------------------
module mux2X24 (in0, in1, sel, out);
    input wire [23:0] in0, in1;
    input wire sel;
    output wire [23:0] out;

mux2X16 entity_9 (in0[15:0], in1[15:0], sel, out[15:0]);
mux2X8 entity_10 (in0[23:16], in1[23:16], sel, out[23:16]);
endmodule
//----------------------------------------------------------------------------
module mux2X32 (in0, in1, sel, out);
    input wire [31:0] in0, in1;
    input wire sel;
    output wire [31:0] out;

mux2X16 entity_11 (in0[15:0], in1[15:0], sel, out[15:0]);
mux2X16 entity_12 (in0[31:16], in1[31:16], sel, out[31:16]);
endmodule
//----------------------------------------------------------------------------
module mux2X48 (in0, in1, sel, out);
    input wire [47:0] in0, in1;
    input wire sel;
    output wire [47:0] out;

mux2X32 entity_13 (in0[31:0], in1[31:0], sel, out[31:0]);
mux2X16 entity_14 (in0[47:32], in1[47:32], sel, out[47:32]);
endmodule
//----------------------------------------------------------------------------
module mux2X64 (in0, in1, sel, out);
    input wire [63:0] in0, in1;
    input wire sel;
    output wire [63:0] out;

mux2X32 entity_15 (in0[31:0], in1[31:0], sel, out[31:0]);
mux2X32 entity_16 (in0[63:32], in1[63:32], sel, out[63:32]);
endmodule
//----------------------------------------------------------------------------
module mux2X48_tb;
    reg [24:0] in0, in1;
    reg sel;
    wire [24:0] out;

mux2X25 uut (in0, in1, sel, out);
    initial begin
        #10
        in0 = 25'd1010;
        in1 = 25'd1001;
        sel = 0;
    end
endmodule
//----------------------------------------------------------------------------
module mux2X25 (in0, in1, sel, out);
    input wire [24:0] in0, in1;
    input wire sel;
    output wire [24:0] out;

mux2X16 entity_17 (in0[15:0], in1[15:0], sel, out[15:0]);
mux2X8 entity_18 (in0[23:16], in1[23:16], sel, out[23:16]);     
mux2X1 entity_19 (in0[24], in1[24], sel, out[24]);
endmodule
//----------------------------------------------------------------------------