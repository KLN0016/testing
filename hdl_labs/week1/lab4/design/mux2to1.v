`timescale 1ns / 1ps

module mux2to1 (
    input wire a, b, sel,
    output wire y
);

    assign y = sel ? b : a;

endmodule
