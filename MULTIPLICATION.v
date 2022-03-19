//------------------------------------------------------------------------------------------------
module AND_24_48 (a, b, out);
    input wire a;
    input wire [23:0] b;
    output wire [47:0] out;
    wire [23:0] net;
    genvar i;
 
    generate
        for (i=0;i<=23;i=i+1)
            begin
                and (net[i], a, b[i]);
                // assign net[i] = a & b[i];
            end
    endgenerate
    assign out = {24'b0,net};
endmodule
//------------------------------------------------------------------------------------------------
module AND_32_64 (a, b, out);
    input wire a;
    input wire [31:0] b;
    output wire [63:0] out;
    wire [31:0] net;
    genvar i;
 
    generate
        for (i=0;i<=31;i=i+1)
            begin
                and (net[i], a, b[i]);
                // assign net[i] = a & b[i];
            end
    endgenerate
    assign out = {32'b0,net};
endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module AND_24_48_TB;
    reg a;
    reg [23:0] b;
    wire [47:0] out;

AND_24_48 uut (a, b, out);
    initial begin
        #10
        a = 1;
        b = 24'd12345;
        #10
        a = 0;
        b = 24'd6789;
        #10
        a = 1;
        b = 24'd98745;
    end
endmodule

//------------------------------------------------------------------------------------------------
module MULTIPLY (a, b, out);
    input wire [23:0] a, b;
    output wire [47:0] out;
    
    wire [47:0] n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23;
    wire [47:0] l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23;
    wire [47:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23;
/*    
    wire [47:0] n, l [0:23];
    wire [47:0] s [1:24];
    wire c;
    genvar i;

AND_24_48 entity_1 (b[0], a, n[0]);
SHIFTER_LEFT_48BITS entity_2 (n[0], 6'd0, l[0]);
FULL_ADDER_48BITS entity_3 (l[0], 48'd0, 1'b0, s[1], c);
    generate
        for (i=1;i<24;i=i+1) begin
            AND_24_48 entity_4 (b[i], a, n[i]);
            SHIFTER_LEFT_48BITS entity_5 (n[i], i, l[i]);
            FULL_ADDER_48BITS entity_6 (l[i], s[i], 1'b0, s[i+1], c);
        end 
    endgenerate
    assign out = s[1];
*/
AND_24_48 entity_1 (b[0], a, n0);
SHIFTER_LEFT_48BITS entity_2 (n0, 6'd0, l0);
FULL_ADDER_48BITS entity_3 (l0, 48'd0, 1'b0, s1, c);

AND_24_48 entity_4 (b[1], a, n1);
SHIFTER_LEFT_48BITS entity_5 (n1, 6'd1, l1);
FULL_ADDER_48BITS entity_6 (l1, s1, 1'b0, s2, c);

AND_24_48 entity_7 (b[2], a, n2);
SHIFTER_LEFT_48BITS entity_8 (n2, 6'd2, l2);
FULL_ADDER_48BITS entity_9 (l2, s2, 1'b0, s3, c);

AND_24_48 entity_10 (b[3], a, n3);
SHIFTER_LEFT_48BITS entity_11 (n3, 6'd3, l3);
FULL_ADDER_48BITS entity_12 (l3, s3, 1'b0, s4, c);

AND_24_48 entity_13 (b[4], a, n4);
SHIFTER_LEFT_48BITS entity_14 (n4, 6'd4, l4);
FULL_ADDER_48BITS entity_15 (l4, s4, 1'b0, s5, c);

AND_24_48 entity_16 (b[5], a, n5);
SHIFTER_LEFT_48BITS entity_17 (n5, 6'd5, l5);
FULL_ADDER_48BITS entity_18 (l5, s5, 1'b0, s6, c);

AND_24_48 entity_19 (b[6], a, n6);
SHIFTER_LEFT_48BITS entity_20 (n6, 6'd6, l6);
FULL_ADDER_48BITS entity_21 (l6, s6, 1'b0, s7, c);

AND_24_48 entity_22 (b[7], a, n7);
SHIFTER_LEFT_48BITS entity_23 (n7, 6'd7, l7);
FULL_ADDER_48BITS entity_24 (l7, s7, 1'b0, s8, c);

AND_24_48 entity_25 (b[8], a, n8);
SHIFTER_LEFT_48BITS entity_26 (n8, 6'd8, l8);
FULL_ADDER_48BITS entity_27 (l8, s8, 1'b0, s9, c);

AND_24_48 entity_28 (b[9], a, n9);
SHIFTER_LEFT_48BITS entity_29 (n9, 6'd9, l9);
FULL_ADDER_48BITS entity_30 (l9, s9, 1'b0, s10, c);

AND_24_48 entity_31 (b[10], a, n10);
SHIFTER_LEFT_48BITS entity_32 (n10, 6'd10, l10);
FULL_ADDER_48BITS entity_33 (l10, s10, 1'b0, s11, c);

AND_24_48 entity_34 (b[11], a, n11);
SHIFTER_LEFT_48BITS entity_35 (n11, 6'd11, l11);
FULL_ADDER_48BITS entity_36 (l11, s11, 1'b0, s12, c);

AND_24_48 entity_37 (b[12], a, n12);
SHIFTER_LEFT_48BITS entity_38 (n12, 6'd12, l12);
FULL_ADDER_48BITS entity_39 (l12, s12, 1'b0, s13, c);

AND_24_48 entity_40 (b[13], a, n13);
SHIFTER_LEFT_48BITS entity_41 (n13, 6'd13, l13);
FULL_ADDER_48BITS entity_42 (l13, s13, 1'b0, s14, c);

AND_24_48 entity_43 (b[14], a, n14);
SHIFTER_LEFT_48BITS entity_44 (n14, 6'd14, l14);
FULL_ADDER_48BITS entity_45 (l14, s14, 1'b0, s15, c);

AND_24_48 entity_46 (b[15], a, n15);
SHIFTER_LEFT_48BITS entity_47 (n15, 6'd15, l15);
FULL_ADDER_48BITS entity_48 (l15, s15, 1'b0, s16, c);

AND_24_48 entity_49 (b[16], a, n16);
SHIFTER_LEFT_48BITS entity_50 (n16, 6'd16, l16);
FULL_ADDER_48BITS entity_51 (l16, s16, 1'b0, s17, c);

AND_24_48 entity_52 (b[17], a, n17);
SHIFTER_LEFT_48BITS entity_53 (n17, 6'd17, l17);
FULL_ADDER_48BITS entity_54 (l17, s17, 1'b0, s18, c);

AND_24_48 entity_55 (b[18], a, n18);
SHIFTER_LEFT_48BITS entity_56 (n18, 6'd18, l18);
FULL_ADDER_48BITS entity_57 (l18, s18, 1'b0, s19, c);

AND_24_48 entity_58 (b[19], a, n19);
SHIFTER_LEFT_48BITS entity_59 (n19, 6'd19, l19);
FULL_ADDER_48BITS entity_60 (l19, s19, 1'b0, s20, c);

AND_24_48 entity_61 (b[20], a, n20);
SHIFTER_LEFT_48BITS entity_62 (n20, 6'd20, l20);
FULL_ADDER_48BITS entity_63 (l20, s20, 1'b0, s21, c);

AND_24_48 entity_64 (b[21], a, n21);
SHIFTER_LEFT_48BITS entity_65 (n21, 6'd21, l21);
FULL_ADDER_48BITS entity_66 (l21, s21, 1'b0, s22, c);

AND_24_48 entity_67 (b[22], a, n22);
SHIFTER_LEFT_48BITS entity_68 (n22, 6'd22, l22);
FULL_ADDER_48BITS entity_69 (l22, s22, 1'b0, s23, c);

AND_24_48 entity_70 (b[23], a, n23);
SHIFTER_LEFT_48BITS entity_71 (n23, 6'd23, l23);
FULL_ADDER_48BITS entity_72 (l23, s23, 1'b0, out, c);

endmodule
//------------------------------------------------------------------------------------------------

`timescale 1ns/1ps
module MULTIPLY_TB;
    

    reg [23:0] a, b;
    wire [47:0] out;
MULTIPLY uut (a, b, out);
    initial begin
        #10
        a = 24'd12;
        b = 24'd13;
        #10
        a = 24'd46;
        b = 24'd50;
        #10
        a = 24'd89;
        b = 24'd134;
        #10
        a = 24'b001101001000010100011111;
        b = 24'b011111001000010100011111;
        #10
        a = 24'b010010011001100110011010;
        b = 24'b011001100011110101110001;
        #10
        a = 24'b010100100110011001100110;
        b = 24'b010000001010001111010111;
    end
/*
    reg [31:0] a, b;
    wire [63:0] out;
MULTIPLY_32_BITS uut (a, b, out);
    initial begin
        #10
        a = 32'b00000000101101001000010100011111;
        b = 32'b00000000111111001000010100011111;
        #10
        a = 32'b00000000110010011001100110011010;
        b = 32'b00000000111001100011110101110001;
        #10
        a = 32'b00000000110100100110011001100110;
        b = 32'b00000000110000001010001111010111;
    end
*/
endmodule
//------------------------------------------------------------------------------------------------
module MULTIPLY_32_BITS (a, b, out);
    input wire [31:0] a, b;
    output wire [63:0] out;
    wire [63:0] n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31;
    wire [63:0] l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31;
    wire [63:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31;
    wire c;

AND_32_64 entity_73 (b[0], a, n0);
SHIFTER_LEFT_64BITS entity_74 (n0, 6'd0, l0);
FULL_ADDER_64BITS entity_75 (l0, 64'd0, 1'b0, s1, c);

AND_32_64 entity_76 (b[1], a, n1);
SHIFTER_LEFT_64BITS entity_77 (n1, 6'd1, l1);
FULL_ADDER_64BITS entity_78 (l1, s1, 1'b0, s2, c);

AND_32_64 entity_79 (b[2], a, n2);
SHIFTER_LEFT_64BITS entity_80 (n2, 6'd2, l2);
FULL_ADDER_64BITS entity_81 (l2, s2, 1'b0, s3, c);

AND_32_64 entity_82 (b[3], a, n3);
SHIFTER_LEFT_64BITS entity_83 (n3, 6'd3, l3);
FULL_ADDER_64BITS entity_84 (l3, s3, 1'b0, s4, c);

AND_32_64 entity_85 (b[4], a, n4);
SHIFTER_LEFT_64BITS entity_86 (n4, 6'd4, l4);
FULL_ADDER_64BITS entity_87 (l4, s4, 1'b0, s5, c);

AND_32_64 entity_88 (b[5], a, n5);
SHIFTER_LEFT_64BITS entity_89 (n5, 6'd5, l5);
FULL_ADDER_64BITS entity_90 (l5, s5, 1'b0, s6, c);

AND_32_64 entity_91 (b[6], a, n6);
SHIFTER_LEFT_64BITS entity_92 (n6, 6'd6, l6);
FULL_ADDER_64BITS entity_93 (l6, s6, 1'b0, s7, c);

AND_32_64 entity_94 (b[7], a, n7);
SHIFTER_LEFT_64BITS entity_95 (n7, 6'd7, l7);
FULL_ADDER_64BITS entity_96 (l7, s7, 1'b0, s8, c);

AND_32_64 entity_97 (b[8], a, n8);
SHIFTER_LEFT_64BITS entity_98 (n8, 6'd8, l8);
FULL_ADDER_64BITS entity_99 (l8, s8, 1'b0, s9, c);

AND_32_64 entity_100 (b[9], a, n9);
SHIFTER_LEFT_64BITS entity_101 (n9, 6'd9, l9);
FULL_ADDER_64BITS entity_102 (l9, s9, 1'b0, s10, c);

AND_32_64 entity_103 (b[10], a, n10);
SHIFTER_LEFT_64BITS entity_104 (n10, 6'd10, l10);
FULL_ADDER_64BITS entity_105 (l10, s10, 1'b0, s11, c);

AND_32_64 entity_106 (b[11], a, n11);
SHIFTER_LEFT_64BITS entity_107 (n11, 6'd11, l11);
FULL_ADDER_64BITS entity_108 (l11, s11, 1'b0, s12, c);

AND_32_64 entity_109 (b[12], a, n12);
SHIFTER_LEFT_64BITS entity_110 (n12, 6'd12, l12);
FULL_ADDER_64BITS entity_111 (l12, s12, 1'b0, s13, c);

AND_32_64 entity_112 (b[13], a, n13);
SHIFTER_LEFT_64BITS entity_113 (n13, 6'd13, l13);
FULL_ADDER_64BITS entity_114 (l13, s13, 1'b0, s14, c);

AND_32_64 entity_115 (b[14], a, n14);
SHIFTER_LEFT_64BITS entity_116 (n14, 6'd14, l14);
FULL_ADDER_64BITS entity_117 (l14, s14, 1'b0, s15, c);

AND_32_64 entity_118 (b[15], a, n15);
SHIFTER_LEFT_64BITS entity_119 (n15, 6'd15, l15);
FULL_ADDER_64BITS entity_120 (l15, s15, 1'b0, s16, c);

AND_32_64 entity_121 (b[16], a, n16);
SHIFTER_LEFT_64BITS entity_122 (n16, 6'd16, l16);
FULL_ADDER_64BITS entity_123 (l16, s16, 1'b0, s17, c);

AND_32_64 entity_124 (b[17], a, n17);
SHIFTER_LEFT_64BITS entity_125 (n17, 6'd17, l17);
FULL_ADDER_64BITS entity_126 (l17, s17, 1'b0, s18, c);

AND_32_64 entity_127 (b[18], a, n18);
SHIFTER_LEFT_64BITS entity_128 (n18, 6'd18, l18);
FULL_ADDER_64BITS entity_129 (l18, s18, 1'b0, s19, c);

AND_32_64 entity_130 (b[19], a, n19);
SHIFTER_LEFT_64BITS entity_131 (n19, 6'd19, l19);
FULL_ADDER_64BITS entity_132 (l19, s19, 1'b0, s20, c);

AND_32_64 entity_133 (b[20], a, n20);
SHIFTER_LEFT_64BITS entity_134 (n20, 6'd20, l20);
FULL_ADDER_64BITS entity_135 (l20, s20, 1'b0, s21, c);

AND_32_64 entity_136 (b[21], a, n21);
SHIFTER_LEFT_64BITS entity_137 (n21, 6'd21, l21);
FULL_ADDER_64BITS entity_138 (l21, s21, 1'b0, s22, c);

AND_32_64 entity_139 (b[22], a, n22);
SHIFTER_LEFT_64BITS entity_140 (n22, 6'd22, l22);
FULL_ADDER_64BITS entity_141 (l22, s22, 1'b0, s23, c);

AND_32_64 entity_142 (b[23], a, n23);
SHIFTER_LEFT_64BITS entity_143 (n23, 6'd23, l23);
FULL_ADDER_64BITS entity_144 (l23, s23, 1'b0, s24, c);

AND_32_64 entity_145 (b[24], a, n24);
SHIFTER_LEFT_64BITS entity_146 (n24, 6'd24, l24);
FULL_ADDER_64BITS entity_147 (l24, s24, 1'b0, s25, c);

AND_32_64 entity_148 (b[25], a, n25);
SHIFTER_LEFT_64BITS entity_149 (n25, 6'd25, l25);
FULL_ADDER_64BITS entity_150 (l25, s25, 1'b0, s26, c);

AND_32_64 entity_151 (b[26], a, n26);
SHIFTER_LEFT_64BITS entity_152 (n26, 6'd26, l26);
FULL_ADDER_64BITS entity_153 (l26, s26, 1'b0, s27, c);

AND_32_64 entity_154 (b[27], a, n27);
SHIFTER_LEFT_64BITS entity_155 (n27, 6'd27, l27);
FULL_ADDER_64BITS entity_156 (l27, s27, 1'b0, s28, c);

AND_32_64 entity_157 (b[28], a, n28);
SHIFTER_LEFT_64BITS entity_158 (n28, 6'd28, l28);
FULL_ADDER_64BITS entity_159 (l28, s28, 1'b0, s29, c);

AND_32_64 entity_160 (b[29], a, n29);
SHIFTER_LEFT_64BITS entity_161 (n29, 6'd29, l29);
FULL_ADDER_64BITS entity_162 (l29, s29, 1'b0, s30, c);

AND_32_64 entity_163 (b[30], a, n30);
SHIFTER_LEFT_64BITS entity_164 (n30, 6'd30, l30);
FULL_ADDER_64BITS entity_165 (l30, s30, 1'b0, s31, c);

AND_32_64 entity_166 (b[31], a, n31);
SHIFTER_LEFT_64BITS entity_167 (n31, 6'd31, l31);
FULL_ADDER_64BITS entity_168 (l31, s31, 1'b0, out, c);

endmodule
//------------------------------------------------------------------------------------------------