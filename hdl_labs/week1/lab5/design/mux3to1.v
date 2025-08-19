`timescale 1ns / 1ps

module mux3to1 (
    input [1:0] sel,
    input a, b, c,
    output y
);

    assign y = (sel == 2'b00) ? a :
	       (sel == 2'b01) ? b :
	       (sel == 2'b10) ? c :
	       1'b0;    // default case (e.g. sel == 2'b11)

endmodule
