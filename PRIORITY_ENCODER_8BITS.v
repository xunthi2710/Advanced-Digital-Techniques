//-----------------------------------------------------------------
module PRIORITY_ENCODER_8BITS (in, out);
    input wire [7:0] in;
    output [3:0] out;
    wire [14:0] net;

//  assign out[3] = (~in[0])&(~in[1])&(~in[2])&(~in[3])&(~in[4])&(~in[5])&(~in[6])&(~in[7]);
    not (net[0], in[0]);
    not (net[1], in[1]);
    not (net[2], in[2]);
    not (net[3], in[3]);
    not (net[4], in[4]);
    not (net[5], in[5]);
    not (net[6], in[6]);
    not (net[7], in[7]);
    and (out[3], net[0], net[1], net[2], net[3], net[4], net[5], net[6], net[7]);
//  assign out[2] = in[7]|(~in[7]&in[6])|(~in[7]&~in[6]&in[5])|(~in[7]&~in[6]&~in[5]&in[4]);
    and (net[8], net[7], in[6]);
    and (net[9], net[7], net[6], in[5]);
    and (net[10], net[7], net[6], net[5], in[4]);
    or (out[2], in[7], net[8], net[9], net[10]);
//  assign out[1] = in[7]|(~in[7]&in[6])|(~in[7]&~in[6]&~in[5]&~in[4]&in[3])|(~in[7]&~in[6]&~in[5]&~in[4]&~in[3]&in[2]);
    and (net[11], net[7], net[6], net[5], net[4], in[3]);
    and (net[12], net[7], net[6], net[5], net[4], net[3], in[2]);
    or (out[1], in[7], net[8], net[11], net[12]);
//  assign out[0] = in[7]|(~in[7]&~in[6]&in[5])|(~in[7]&~in[6]&~in[5]&~in[4]&in[3])|(~in[7]&~in[6]&~in[5]&~in[4]&~in[3]&~in[2]&in[1]);
    and (net[13], net[7], net[6], in[5]);
    and (net[14], net[7], net[6], net[5], net[4], net[3], net[2], in[1]);
    or (out[0], in[7], net[13], net[11], net[14]);
endmodule
//-----------------------------------------------------------------
module PRIORITY_ENCODER_32BITS (in, out);
    input wire [31:0] in;
    output [5:0] out;
    wire [3:0] net1, net2, net3, net4;
    wire [2:0] d1, d2, d3, d4;
    wire [17:0] net;

PRIORITY_ENCODER_8BITS entity_1 (in[7:0], net1);
PRIORITY_ENCODER_8BITS entity_2 (in[15:8], net2);
PRIORITY_ENCODER_8BITS entity_3 (in[23:16], net3);
PRIORITY_ENCODER_8BITS entity_4 (in[31:24], net4);

//  assign out[5] = net1[3]&net2[3]&net3[3]&net4[3];
    and (out[5], net1[3], net2[3], net3[3], net4[3]);
//  assign out[4] = (~net4[3])|(~net3[3]);
    not (net[0], net4[3]);
    not (net[1], net3[3]);
    or (out[4], net[0], net[1]);
//  assign out[3] = (~net4[3])|(net3[3]&(~net2[3]));
    not (net[2], net2[3]); 
    and (net[3], net3[3], net[2]);
    or (out[3], net[0], net[3]);
//  assign d1 = {net1[2]&~out[3]&~out[4],net1[1]&~out[3]&~out[4],net1[0]&~out[3]&~out[4]};
    not (net[4], out[3]);
    not (net[5], out[4]);
    and (net[6], net1[2], net[4], net[5]);
    and (net[7], net1[1], net[4], net[5]);
    and (net[8], net1[0], net[4], net[5]);
    assign d1 = {net[6], net[7], net[8]};
//  assign d2 = {net2[2]&out[3]&~out[4],net2[1]&out[3]&~out[4],net2[0]&out[3]&~out[4]};
    and (net[9], net2[2], out[3], net[5]);
    and (net[10], net2[1], out[3], net[5]);
    and (net[11], net2[0], out[3], net[5]);
    assign d2 = {net[9], net[10], net[11]};
//  assign d3 = {net3[2]&~out[3]&out[4],net3[1]&~out[3]&out[4],net3[0]&~out[3]&out[4]};
    and (net[12], net3[2], net[4], out[4]);
    and (net[13], net3[1], net[4], out[4]);
    and (net[14], net3[0], net[4], out[4]);
    assign d3 = {net[12], net[13], net[14]};
//  assign d4 = {net4[2]&out[3]&out[4],net4[1]&out[3]&out[4],net4[0]&out[3]&out[4]};
    and (net[15], net4[2], out[3], out[4]);
    and (net[16], net4[1], out[3], out[4]);
    and (net[17], net4[0], out[3], out[4]);
    assign d4 = {net[15], net[16], net[17]};
//  assign out[2:0] = d1|d2|d3|d4;
    or (out[0], net[17], net[14], net[11], net[8]);
    or (out[1], net[16], net[13], net[10], net[7]);
    or (out[2], net[15], net[12], net[9], net[6]);
endmodule
//-----------------------------------------------------------------

`timescale 1ns/1ps
module PRIORITY_ENCODER_32BITS_TB;
    reg [31:0] y;
    wire [5:0] a;
//  Instantiate the Unit Under Test (uut)
PRIORITY_ENCODER_32BITS uut (y, a);
    initial begin     
    // apply test vectors
        #10 y = 32'b00000000011111001001110000000000;
        #10 y = 32'b00000000000001101110100000000000;
        #10 y = 32'b00000000011000010100011110101111;

    end
endmodule

//-----------------------------------------------------------------
module PRIORITY_ENCODER_32BITS_SIG (sig, ex_a, sig_sub, ex_sub);
    input wire [31:0] sig;
    input wire [7:0] ex_a;
    output wire [31:0] sig_sub;
    output wire [7:0] ex_sub;
    wire [5:0] left;
    wire [7:0] left_1, left_2;
    wire b0, b1;

PRIORITY_ENCODER_32BITS entity_5 (sig, left);
FULL_SUBTRACTOR_8BITS entity_6 (8'd23, {2'd0,left}, 1'b0, left_1, b0);
SHIFTER_LEFT_32BITS entity_7 (sig, left_1[4:0], sig_sub);
    assign left_2 = left_1;
FULL_SUBTRACTOR_8BITS entity_8 (ex_a, left_2, 1'b0, ex_sub, b1);
endmodule
//-----------------------------------------------------------------

`timescale 1ns/1ps
module PRIORITY_ENCODER_32BITS_SIG_TB;
    reg [31:0] sig;
    reg [7:0] ex_a;
    wire [31:0] sig_sub;
    wire [7:0] ex_sub;

PRIORITY_ENCODER_32BITS_SIG uut (sig, ex_a, sig_sub, ex_sub);
    initial begin
        #10
        sig = 32'b00000000011111001001110000000000;
        ex_a = 8'b10000111;
        #10
        sig = 32'b00000000000001101110100000000000;
        ex_a = 8'b10001010;
        #10
        sig = 32'b00000000011000010100011110101111;
        ex_a = 8'b01111110;
    end
endmodule
