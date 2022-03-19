module COSX (in_1, out_1);
    input [31:0] in_1;
    output [31:0] out_1;

    wire [31:0] net [1:10];
    wire [35:1] flag;
    wire [31:0] net_1 [1:4];

MUL_2021 entity_1 (in_1, in_1, flag[1], flag[2], flag[3], net[1]);  // x^2
DIV_2021 entity_2 (net[1], 32'h40000000, flag[4], flag[5], flag[6], net[2]);    // x^2/2!

MUL_2021 entity_3 (net[1], net[1], flag[7], flag[8], flag[9], net[3]);  // x^4
DIV_2021 entity_4 (net[3], 32'h41c00000, flag[10], flag[11], flag[12], net[4]);    // x^4/4!

MUL_2021 entity_5 (net[3], net[1], flag[13], flag[14], flag[15], net[5]);  // x^6
DIV_2021 entity_6 (net[5], 32'h44340000, flag[16], flag[17], flag[18], net[6]);    // x^6/6!

MUL_2021 entity_7 (net[5], net[1], flag[19], flag[20], flag[21], net[7]);  // x^8
DIV_2021 entity_8 (net[7], 32'h471d8000, flag[22], flag[23], flag[24], net[8]);    // x^8/8!

MUL_2021 entity_9 (net[7], net[1], flag[25], flag[26], flag[27], net[9]);  // x^10
DIV_2021 entity_10 (net[9], 32'h4a5d7c00, flag[28], flag[29], flag[30], net[10]);    // x^10/10!

ADD_SUB_2021 entity_11 (32'h3f800000, net[2], 1'b1, flag[31], net_1[1]);
ADD_SUB_2021 entity_12 (net[4], net[6], 1'b1, flag[32], net_1[2]);
ADD_SUB_2021 entity_13 (net[8], net[10], 1'b1, flag[33], net_1[3]);

ADD_SUB_2021 entity_14 (net_1[1], net_1[2], 1'b0, flag[34], net_1[4]);
ADD_SUB_2021 entity_15 (net_1[4], net_1[3], 1'b0, flag[35], out_1);

endmodule
//------------------------------------------------------------------------------------------------
module COSX_TB;
    reg [31:0] in_1;
    wire [31:0] out_1;

COSX dut (in_1, out_1);
    initial begin
        #10
        in_1 = 32'h3f860a92;
        #10
        in_1 = 32'h3f060a92;
    end

endmodule