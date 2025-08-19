module dff(
    input logic clk,
    input logic rstn,
    input logic d,
    output logic q
);

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            q <= '0;
        end else begin
            q <= d;
        end
    end

endmodule
