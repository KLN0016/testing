module mux3to1 (
	input logic		a,
	input logic		b,
	input logic		c,
	input logic	[2-1:0] sel,
	output logic 		y
);
	always_comb begin
		case (sel)
			2'b00	: y = a;
			2'b01	: y = b;
			2'b10	: y = c;
			default	: y = '0;
		endcase
	end
endmodule
