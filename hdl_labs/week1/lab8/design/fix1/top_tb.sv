`timescale 1ns / 1ps

module top_tb;
    logic clk;
    logic rst;
    logic [7:0] count;
    logic [7:0] prev_count;

    // Expected counter value for automated checking
    logic [7:0] expected_count;

    // Instantiate DUT
    top dut (
        .clk   (clk),
        .rst   (rst),
        .count (count)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        rst = 1;
        #12;
        rst = 0;
    end

    logic enable_tb;
    assign enable_tb = dut.enable;

    // Monitor & check counter value
    //always_ff @(posedge clk or posedge rst) begin
    //    if (rst) begin
    //        expected_count <= 0;
	//    prev_count     <= 0;
	//end else begin
    //        if (count == prev_count + 1) begin
    //            expected_count <= expected_count + 1;
    //        end
    //        prev_count <= count;
    //    end
    //end

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            expected_count <= 0;
        else if (enable_tb)
            expected_count <= expected_count + 1;
    end

    // Scoreboard (basic)
    initial begin
	$monitor("clk=%d r=%d c=%d e=%d", clk, rst, count, expected_count);
        #250;
        if (count == expected_count)
            $display(">>>>>>>>>>>TEST PASSED: count = %0d matches expected_count = %0d", count, expected_count);
        else
            $display(">>>>>>>>>>>TEST FAILED: count = %0d, expected_count = %0d", count, expected_count);
        $finish;
    end

    // Optional: Enable waveform dumping for Verdi
    initial begin
        $fsdbDumpfile("top_sim.fsdb");
        $fsdbDumpvars(0, top_tb);
    end

endmodule
