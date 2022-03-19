module SINX ();
    input [31:0] in;
    output [31:0] out;

    wire [31:0] net [1:11];
    wire [38:1] flag;
    wire [31:0] net_1 [1:4];

MUL_2021 entity_1 (in, in, flag[1], flag[2], flag[3], net[1]);  // x^2

MUL_2021 entity_2 (net[1], in, flag[4], flag[5], flag[6], net[2]);  // x^3
DIV_2021 entity_3 (net[2], 32'h40c00000, flag[7], flag[8], flag[9], net[3]);    // x^3/3!

MUL_2021 entity_4 (net[2], net[1], flag[10], flag[11], flag[12], net[4]);  // x^5
DIV_2021 entity_5 (net[4], 32'h42f00000, flag[13], flag[14], flag[15], net[5]);    // x^5/5!

MUL_2021 entity_6 (net[4], net[1], flag[16], flag[17], flag[18], net[6]);  // x^7
DIV_2021 entity_7 (net[6], 32'h459d8000, flag[19], flag[20], flag[21], net[7]);    // x^7/7!

MUL_2021 entity_8 (net[6], net[1], flag[22], flag[23], flag[24], net[8]);  // x^9
DIV_2021 entity_9 (net[8], 32'h48b13000, flag[25], flag[26], flag[27], net[9]);    // x^9/9!

MUL_2021 entity_10 (net[8], net[1], flag[28], flag[29], flag[30], net[10]);  // x^11
DIV_2021 entity_11 (net[10], 32'h4c184540, flag[31], flag[32], flag[33], net[11]);    // x^11/11!

ADD_SUB_2021 entity_12 (in, net[3], 1'b1, flag[34], net_1[1]);
ADD_SUB_2021 entity_13 (net[5], net[7], 1'b1, flag[35], net_1[2]);
ADD_SUB_2021 entity_14 (net[9], net[11], 1'b1, flag[36], net_1[3]);

ADD_SUB_2021 entity_15 (net_1[1], net_1[2], 1'b0, flag[37], net_1[4]);
ADD_SUB_2021 entity_16 (net_1[4], net_1[3], 1'b0, flag[38], out);

endmodule