module ha (
	input logic a,
	input logic b,
	output logic s,
	output logic cout
);
    assign {cout, s} = a + b;
endmodule
