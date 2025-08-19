`timescale 1ns / 1ps

module mux2to1_new (
    input wire a, b, sel,
    output wire y
);

    assign y = sel ? a : b;

endmodule
