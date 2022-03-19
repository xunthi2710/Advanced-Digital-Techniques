//------------------------------------------------------------------------------------------------
module DECOMPOSE_AS (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b, enable, enable_sub);
    input wire [31:0] a, b;
    output wire sign_a, sign_b;
    output wire [7:0] exponent_a, exponent_b;
    output wire [31:0] significand_a, significand_b;
    output wire enable, enable_sub;
    wire [22:0] sig_big, sig_small;
    wire eq, gt, lt;
    wire net1, net2;

COMPARATOR_32BITS entity_1 ({1'b0,a[30:0]}, {1'b0,b[30:0]}, eq, gt, lt);
    assign enable = lt;
    assign enable_sub = eq; 
    assign sign_a = lt ? b[31] : a[31];
    assign sign_b = lt ? a[31] : b[31];
    assign exponent_a = lt ? b[30:23] : a[30:23];
    assign exponent_b = lt ? a[30:23] : b[30:23];
    assign sig_big = lt ? b[22:0] : a[22:0];
    assign sig_small = lt ? a[22:0] : b[22:0];
    or (net1, exponent_a[0], exponent_a[1], exponent_a[2], exponent_a[3], exponent_a[4], exponent_a[5], exponent_a[6], exponent_a[7]); // net1 = |exponent_a
    or (net2, exponent_b[0], exponent_b[1], exponent_b[2], exponent_b[3], exponent_b[4], exponent_b[5], exponent_b[6], exponent_b[7]); // net2 = |exponent_b
    assign significand_a = net1 ? {9'b000000001,sig_big} : {9'd0,sig_big};
    assign significand_b = net2 ? {9'b000000001,sig_small} : {9'd0,sig_small};
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module DECOMPOSE_AS_TB;
    reg [31:0] a, b;
    wire sign_a, sign_b;
    wire [7:0] exponent_a, exponent_b;
    wire [31:0] significand_a, significand_b;
    wire enable, enable_sub;

DECOMPOSE_AS uut (a, b, sign_a, sign_b, exponent_a, exponent_b, significand_a, significand_b, enable, enable_sub);
    initial begin
        #10
        a = 32'h4383C7AE;
        b = 32'h4164F5C3;
        #10
        a = 32'h454277D7;
        b = 32'h453B8FD7;
        #10
        a = 32'h3F3AE148;
        b = 32'h3EB33333;
        #10
        a = 32'h3F7D70A4;
        b = 32'h3F7D70A4;
    end
endmodule

//------------------------------------------------------------------------------------------------
module EQUALIZING_AS (ex_a, ex_b, signi_b, ex_b_add_sub, signi_add_sub, perform);
    input wire [7:0] ex_a, ex_b;
    input wire [31:0] signi_b;
    output wire [7:0] ex_b_add_sub;
    output wire [31:0] signi_add_sub;
    output wire perform;
    wire [8:0] diff;
    wire eq, gt, lt, c;

FULL_SUBTRACTOR_8BITS entity_2 (ex_a, ex_b, 1'b0, diff[7:0], diff[8]);
SHIFTER_RIGHT_32BITS entity_3 (signi_b, diff[4:0], signi_add_sub);
FULL_ADDER_8BITS entity_4 (ex_b, diff[7:0], 1'b0, ex_b_add_sub, c);
COMPARATOR_8BITS entity_5 (ex_b_add_sub, ex_a, eq, gt, lt);
    assign perform = eq; 
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module EQUALIZING_AS_TB;
    reg [7:0] ex_a, ex_b;
    reg [31:0] signi_b;
    wire [7:0] ex_b_add_sub;
    wire [31:0] signi_add_sub;
    wire perform;

EQUALIZING_AS uut (ex_a, ex_b, signi_b, ex_b_add_sub, signi_add_sub, perform);
    initial begin
        #10
        ex_a = 8'b10000111; 
        ex_b = 8'b10000010;
        signi_b = 32'b00000000111001001111010111000011;
        #10
        ex_a = 8'b10001010;
        ex_b = 8'b10001010;
        signi_b = 32'b00000000101110111000111111010111;
        #10
        ex_a = 8'b01111110;
        ex_b = 8'b01111101;
        signi_b = 32'b00000000101100110011001100110011;
        #10
        ex_a = 8'b01111110;
        ex_b = 8'b01111110;
        signi_b = 32'b00000000111111010111000010100100;
    end
endmodule

//------------------------------------------------------------------------------------------------
module CONVERTER_1_AS (add_sub_signal, enable, ex_a, ex_b, sign_a, sign_b, exception, output_sign, operation);
    input wire add_sub_signal, enable;
    input wire [7:0] ex_a, ex_b;
    input wire sign_a, sign_b;
    output wire exception, output_sign, operation;
    wire net1, net2, net3, net4, net5;

//  assign exception = (&ex_a) | (&ex_b);
    and (net1, ex_a[0], ex_a[1], ex_a[2], ex_a[3], ex_a[4], ex_a[5], ex_a[6], ex_a[7]);
    and (net2, ex_b[0], ex_b[1], ex_b[2], ex_b[3], ex_b[4], ex_b[5], ex_b[6], ex_b[7]);
    or (exception, net1, net2);
    not (net3, sign_a); // net3 = ~sign_a
    assign output_sign = add_sub_signal ? enable ? net3 : sign_a: sign_a;
    xor (net4, sign_a, sign_b); // net4 = sign_a ^ sign_b
    not (net5, net4); // net5 = ~(sign_a ^ sign_b)
    assign operation = add_sub_signal ? net4 : net5;        
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module CONVERTER_1_AS_TB;
    reg add_sub_signal, enable;
    reg [7:0] ex_a, ex_b;
    reg sign_a, sign_b;
    wire exception, output_sign, operation;

CONVERTER_1_AS uut (add_sub_signal, enable,ex_a, ex_b, sign_a, sign_b, exception, output_sign, operation);
    initial begin
        #10
        add_sub_signal = 0;
        enable = 0;
        ex_a = 8'b10000111; 
        ex_b = 8'b10000010;
        sign_a = 0;
        sign_b = 0;
        #10
        add_sub_signal = 0;
        enable = 0;
        ex_a = 8'b10001010;
        ex_b = 8'b10001010;
        sign_a = 0;
        sign_b = 0;
        #10
        add_sub_signal = 0;
        enable = 0;
        ex_a = 8'b01111110;
        ex_b = 8'b01111101;
        sign_a = 0;
        sign_b = 0;
        #10
        add_sub_signal = 0;
        enable = 0;
        ex_a = 8'b01111110;
        ex_b = 8'b01111110;
        sign_a = 0;
        sign_b = 0;
    end
endmodule

//------------------------------------------------------------------------------------------------
module ADD_BLOCK (perform, operation, ex_a, sig_a, sig_b_add_sub, add_sum);
    input wire perform, operation;
    input wire [7:0] ex_a;
    input wire [31:0] sig_a, sig_b_add_sub;
    output wire [30:0] add_sum;
    wire [31:0] sig_add, sum;
    wire [7:0] op;
    wire c0, c1;
    wire net1;

FULL_ADDER_32BITS entity_6 (sig_a, sig_b_add_sub, 1'b0, sum, c0);
    and (net1, perform, operation); // net1 = perform & operation
    assign sig_add = net1 ? sum : 32'd0;
    assign add_sum[22:0] = sig_add[24] ? sig_add[23:1] : sig_add[22:0];
FULL_ADDER_8BITS entity_7 (ex_a, 8'd1, 1'b0, op, c1);
    assign add_sum[30:23] = sig_add[24] ? op : ex_a; 
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module ADD_BLOCK_TB;
    reg perform, operation;
    reg [7:0] ex_a;
    reg [31:0] sig_a, sig_b_add_sub;
    wire [30:0] add_sum;

ADD_BLOCK uut (perform, operation, ex_a, sig_a, sig_b_add_sub, add_sum);
    initial begin
        #10
        perform = 1;
        operation = 1;
        ex_a = 8'b10000111;
        sig_a = 32'b00000000100000111100001110101110;
        sig_b_add_sub = 32'b00000000000001110010011110101110;
        #10
        perform = 1;
        operation = 1;
        ex_a = 8'b10001010;
        sig_a = 32'b00000000110000100111011111010111;
        sig_b_add_sub = 32'b00000000101110111000111111010111;
        #10
        perform = 1;
        operation = 1;
        ex_a = 8'b01111110;
        sig_a = 32'b00000000101110101110000101001000;
        sig_b_add_sub = 32'b00000000010110011001100110011001;
        #10
        perform = 1;
        operation = 1;
        ex_a = 8'b01111110;
        sig_a = 32'b00000000111111010111000010100100;
        sig_b_add_sub = 32'b00000000111111010111000010100100;
    end
endmodule

//------------------------------------------------------------------------------------------------
module SUB_BLOCK (enable_sub, ex_a, sig_a, sig_b_add_sub, sub_diff);
    input wire enable_sub;
    input wire [7:0] ex_a;
    input wire [31:0] sig_a, sig_b_add_sub;
    output wire [30:0] sub_diff;
    wire [31:0] sig_sub, sub;
    wire [7:0] ex_sub;
    wire c, eq, gt, lt;
    wire net1;

FULL_SUBTRACTOR_32BITS entity_8 (sig_a, sig_b_add_sub, 1'b0, sub, c);
PRIORITY_ENCODER_32BITS_SIG entity_9 (sub, ex_a, sig_sub, ex_sub);
COMPARATOR_32BITS entity_10 (sig_sub, 32'd0, eq, gt, lt);
    and (net1, enable_sub, eq);
    assign sub_diff[30:23] = net1 ? 8'd0 : ex_sub;
    assign sub_diff[22:0] = sig_sub[22:0];
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module SUB_BLOCK_TB;
    reg enable_sub;
    reg [7:0] ex_a;
    reg [31:0] sig_a, sig_b_add_sub;
    wire [30:0] sub_diff;

SUB_BLOCK uut (enable_sub, ex_a, sig_a, sig_b_add_sub, sub_diff);
    initial begin
        #10
        enable_sub = 0;
        ex_a = 8'b10000111;
        sig_a = 32'b00000000100000111100001110101110;
        sig_b_add_sub = 32'b00000000000001110010011110101110;
        #10
        enable_sub = 0;
        ex_a = 8'b10001010;
        sig_a = 32'b00000000110000100111011111010111;
        sig_b_add_sub = 32'b00000000101110111000111111010111;
        #10
        enable_sub = 0;
        ex_a = 8'b01111110;
        sig_a = 32'b00000000101110101110000101001000;
        sig_b_add_sub = 32'b00000000010110011001100110011001;
        #10
        enable_sub = 1;
        ex_a = 8'b01111110;
        sig_a = 32'b00000000111111010111000010100100;
        sig_b_add_sub = 32'b00000000111111010111000010100100;
    end
endmodule

//------------------------------------------------------------------------------------------------
module OUTPUT_AS (exception, operation, output_sign, sub_diff, add_sum, res);
    input wire exception, operation, output_sign;
    input wire [30:0] add_sum, sub_diff;
    output wire [31:0] res;
    wire net1;

    not (net1, operation);
    assign res = exception ? (output_sign ? 32'hff800000: 32'h7f800000) : (net1 ? {output_sign,sub_diff} : {output_sign,add_sum});
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module OUTPUT_AS_TB;
    reg exception, operation, output_sign;
    reg [30:0] add_sum, sub_diff;
    wire [31:0] res;

OUTPUT_AS uut (exception, operation, output_sign, sub_diff, add_sum, res);
    initial begin
        #10
        exception = 0;
        operation = 1;
        output_sign = 0;
        add_sum = 31'b1000011100010101110111101011100;
        sub_diff = 31'd0;
        #10
        exception = 0;
        operation = 1;
        output_sign = 0;
        add_sum = 31'b1000101101111110000001111010111;
        sub_diff = 31'd0;
        #10
        exception = 0;
        operation = 1;
        output_sign = 0;
        add_sum = 31'b0111111100010100011110101110000;
        sub_diff = 31'd0;
        #10
        exception = 0;
        operation = 1;
        output_sign = 0;
        add_sum = 31'b0111111111111010111000010100100;
        sub_diff = 31'd0;
    end
endmodule

//------------------------------------------------------------------------------------------------