`timescale 1ns / 1ps

module mux2to1_tb;
    reg a_tb, b_tb, sel_tb;
    wire y_tb;

    mux2to1 uut (
        .a(a_tb),
        .b(b_tb),
        .sel(sel_tb),
        .y(y_tb)
    );

    initial begin
        a_tb = 0;
        b_tb = 0;
        sel_tb = 0;

	#1;
        $display("----------------------------------");
        $display("Simulation starts");
        $display("----------------------------------");
	$display("Time\ta\tb\tsel\ty");
        $display("----------------------------------");

        #10 a_tb = 0; b_tb = 1; sel_tb = 1; #1 $display("=%0d\t%b\t%b\t%b\t%b", $time, a_tb, b_tb, sel_tb, y_tb);
        #10 a_tb = 0; b_tb = 0; sel_tb = 1; #1 $display("=%0d\t%b\t%b\t%b\t%b", $time, a_tb, b_tb, sel_tb, y_tb);
        #10 a_tb = 1; b_tb = 0; sel_tb = 0; #1 $display("=%0d\t%b\t%b\t%b\t%b", $time, a_tb, b_tb, sel_tb, y_tb);
        #10 a_tb = 0; b_tb = 1; sel_tb = 0; #1 $display("=%0d\t%b\t%b\t%b\t%b", $time, a_tb, b_tb, sel_tb, y_tb);

	$display("----------------------------------");
        $display("Simulation finished");
	$display("----------------------------------");
        #50 $finish;
    end

    initial begin
        $dumpfile("mux2to1_sim.vcd");
        $dumpvars(0, mux2to1_tb);
    end

endmodule
