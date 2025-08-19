`timescale 1ns / 1ps

module mux3to1_tb;
    reg [1:0] sel_tb;
    reg a_tb, b_tb, c_tb;
    wire y_tb;

    mux3to1 uut (
        .a(a_tb),
        .b(b_tb),
        .c(c_tb),
        .sel(sel_tb),
        .y(y_tb)
    );

    initial begin
	#1;
        $display("--------------------------------------------");
        $display("Simulation starts");
        $display("--------------------------------------------");
        $display("sel_tb\ta_tb\tb_tb\tc_tb\t\|\ty_tb");
        $display("--------------------------------|-----------");

        a_tb = 1; b_tb = 0; c_tb = 1;

        sel_tb = 2'b00; #10;

        $display("%b\t%b\t%b\t%b\t\|\t%b", sel_tb, a_tb, b_tb, c_tb, y_tb);

        sel_tb = 2'b01; #10;

        $display("%b\t%b\t%b\t%b\t\|\t%b", sel_tb, a_tb, b_tb, c_tb, y_tb);

        sel_tb = 2'b10; #10;

        $display("%b\t%b\t%b\t%b\t\|\t%b", sel_tb, a_tb, b_tb, c_tb, y_tb);

        sel_tb = 2'b11; #10;

        $display("%b\t%b\t%b\t%b\t\|\t%b", sel_tb, a_tb, b_tb, c_tb, y_tb);

        $display("--------------------------------------------");
        $display("Simulation finished");
        $display("--------------------------------------------");
        #50 $finish;
    end
    
endmodule
