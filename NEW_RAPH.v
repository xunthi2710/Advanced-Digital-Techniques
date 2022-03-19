module NORMARLISE_DIV (in_1, in_2, out_1, out_2);
    input [31:0] in_1, in_2;
    output [31:0] out_1, out_2;
    wire [7:0] diff, diff_1, diff_2;
    wire [2:0] c;

FULL_SUBTRACTOR_8BITS entity_1 (in_2[30:23], 8'd126, 1''b0, diff, c[0]);

endmodule