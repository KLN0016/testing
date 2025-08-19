`timescale 1ns / 1ps

module mux2to1 (
    input  logic a, b, sel,
    output logic y
);

    always_comb begin
        if (sel)
            y = b;
        else
            y = a;
    end

/*    always_comb begin
        case (sel)
            1'b0: y = a;
            1'b1: y = b;
            default: y = 'x;  // Handle Undefined States
        endcase
    end */

endmodule
