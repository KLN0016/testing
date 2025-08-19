`timescale 1ns / 1ps

module controller (
    input  logic clk,
    input  logic rst,
    output logic enable
);

    typedef enum logic [1:0] {IDLE, ENABLE, DISABLE} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        enable = 0;

        case (state)
            IDLE:    next_state = ENABLE;
            ENABLE:  begin
                         enable = 1;
                         next_state = DISABLE;
                     end
            DISABLE: next_state = ENABLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
