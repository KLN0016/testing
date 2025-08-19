`timescale 1ns / 1ps

module mux2to1_all (
    input logic a_u1, b_u1, sel_u1,
    input logic a_u2, b_u2, sel_u2,
    output logic y_u1,
    output logic y_output
 );

    mux2to1 u1 (
        .a(a_u1),
        .b(b_u1),
        .sel(sel_u1),
        .y(y_u1)
    );

    mux2to1 u2 (
        .a(y_u1),
        .b(b_u2),
        .sel(sel_u2),
        .y(y_u2)
    );

endmodule
