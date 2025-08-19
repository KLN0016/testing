`timescale 1ns / 1ps

module counter (
    input  logic clk,
    input  logic rst,
    input  logic enable,
    output logic [7:0] count
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            count <= 8'd0;
        else if (enable)
            count <= count + 1;
    end

endmodule
