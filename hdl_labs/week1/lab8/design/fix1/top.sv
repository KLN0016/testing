`timescale 1ns / 1ps

module top (
    input  logic clk,
    input  logic rst,
    output logic [7:0] count
);

    logic enable;

    controller u_ctrl (
        .clk    (clk),
        .rst    (rst),
        .enable (enable)
    );

    counter u_cnt (
        .clk    (clk),
        .rst    (rst),
        .enable (enable),
        .count  (count)
    );

endmodule
