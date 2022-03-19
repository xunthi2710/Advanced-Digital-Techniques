//------------------------------------------------------------------------------------------------
module NOT_1BIT (in, out);
    input in;
    output out;

    not (in, out);
endmodule
//------------------------------------------------------------------------------------------------
module NOT_4BITS (in, out);
    input [3:0] in;
    output [3:0] out;

    not (in[3], out[3]);
    not (in[2], out[2]);
    not (in[1], out[1]);
    not (in[0], out[0]);
endmodule
//------------------------------------------------------------------------------------------------
module NOT_8BITS (in, out);
    input [7:0] in;
    output [7:0] out;

NOT_4BITS entity_1 (in[3:0], out[3:0]);
NOT_4BITS entity_2 (in[7:4], out[7:4]);
endmodule
//------------------------------------------------------------------------------------------------
module NOT_16BITS (in, out);
    input [15:0] in;
    output [15:0] out;

NOT_8BITS entity_3 (in[7:0], out[7:0]);
NOT_8BITS entity_4 (in[15:8], out[15:8]);
endmodule
//------------------------------------------------------------------------------------------------
module NOT_24BITS (in, out);
    input [23:0] in;
    output [23:0] out;

NOT_16BITS entity_5 (in[15:0], out[15:0]);
NOT_8BITS entity_6 (in[23:16], out[23:16]);
endmodule
//------------------------------------------------------------------------------------------------
module NOT_32BITS (in, out);
    input [31:0] in;
    output [31:0] out;

NOT_16BITS entity_7 (in[15:0], out[15:0]);
NOT_16BITS entity_8 (in[31:16], out[31:16]);
endmodule
//------------------------------------------------------------------------------------------------
