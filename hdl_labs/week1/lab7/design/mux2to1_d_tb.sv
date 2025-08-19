module mux2to1_d_tb;
    localparam NUM_TESTS = 30;                  // Parameters
    logic a_tb, b_tb, sel_tb;                   // Signals
    logic y_tb;
    logic expected_tb;
    int seed_value, random_value;
    int nf = 0;
    int e, f;

    mux2to1_d dut (                             // Instantiate DUT
        .a(a_tb),
        .b(b_tb),
        .sel(sel_tb),
        .y(y_tb)
    );

    initial begin
	$display("----------[$display] Hello, SystemVerilog!");
	$write("----------[$write] Part 1 ");
        $write("----------[$write] Part 2\n");
	e = 0;
        f = 1;
        #1 f = 1;
        $strobe("----------[$strobe] e = %0b, f = %0b", e, f);
	$error("----------[$error] There is an error.");
	$warning("----------[$warning] Warning, please take note.");
	//$fatal("----------[$fatal] Fatal, simulation stopped.");
    end

    initial begin                               // Test Stimulus Generation
        int fd_tb;                              // Open Summary Report
        fd_tb = $fopen("mux2to1_d_sim.rpt", "w");
        $fdisplay(fd_tb, "TIME: %t | Seed | Test# | a | b | sel | y | expected | PASS/FAIL | RANDOM", $time);
        $fdisplay(fd_tb, "--------------------------------------------------------------");

	#1;
	seed_value = 200;
        void'($urandom(seed_value));            // Set the seed value for reproducibility

        // Run random tests
        for (int i_tb = 0; i_tb < NUM_TESTS; i_tb++) begin
	    random_value = $urandom();          // Testing purpose
            //$display("%d", random_value);

            a_tb = $urandom_range(0, 1);        // Generate Random Inputs
            b_tb = $urandom_range(0, 1);
            sel_tb = $urandom_range(0, 1);

            expected_tb = sel_tb ? b_tb : a_tb; // Calculate Expected Output
            #10;                                // Wait For Propagation

            // Check Results (simulation vs expected outputs)
            if (y_tb === expected_tb) begin
                $fdisplay(fd_tb, "TIME: %t | %4d | %5d | %b | %b | %3b | %b | %8b | PASS      | %6d",
                          $time, seed_value, i_tb, a_tb, b_tb, sel_tb, y_tb, expected_tb, random_value);
                $display("Test %0d PASSED", i_tb);
            end
            else begin
		nf++;
                $fdisplay(fd_tb, "TIME: %t | %4d | %5d | %b | %b | %3b | %b | %8b | FAIL--    | %6d",
                          $time, seed_value, i_tb, a_tb, b_tb, sel_tb, y_tb, expected_tb, random_value);
                $display("Test %0d FAILED--", i_tb);
            end
        end
	$fdisplay(fd_tb, "Total test failed: %d", nf);
	$display("Total test failed: %d", nf);

        $fclose(fd_tb);                         // Close Summary Report
        $display("Testing complete. Results saved to mux2to1_d_sim.rpt");
        $finish;                                // Stop Simulation
    end

    initial begin                               // Waveform Dumping
        $fsdbDumpfile("mux2to1_d_sim.fsdb");
        $fsdbDumpvars(0, mux2to1_d_tb);
    end

endmodule
