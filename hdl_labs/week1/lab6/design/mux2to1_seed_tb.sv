module mux2to1_seed_tb;
    localparam NUM_TESTS = 20;                  // Parameters
    logic a_tb, b_tb, sel_tb;                   // Signals
    logic y_tb;
    logic expected_tb;

    int seed_value, random_value;

    mux2to1_seed dut (                               // Instantiate DUT
        .a(a_tb),
        .b(b_tb),
        .sel(sel_tb),
        .y(y_tb)
    );

    initial begin                               // Test Stimulus Generation
        int fd_tb;                              // Open Summary Report
        fd_tb = $fopen("mux2to1_seed_sim.rpt", "w");
        $fdisplay(fd_tb, "Test# | a | b | sel | y | expected | PASS/FAIL | RANDOM");
        $fdisplay(fd_tb, "----------------------------------------------");

        #1
        seed_value = 300;
        void'($urandom(seed_value));
        random_value = $urandom();
        //$display("%d", random_value);
        // Run random tests
        for (int i_tb = 0; i_tb < NUM_TESTS; i_tb++) begin
            a_tb = $urandom_range(0, 1);        // Generate Random Inputs
            b_tb = $urandom_range(0, 1);
            sel_tb = $urandom_range(0, 1);

            expected_tb = sel_tb ? b_tb : a_tb; // Calculate Expected Output
            #10;                                // Wait For Propagation

            // Check Results (simulation vs expected outputs)
            if (y_tb === expected_tb) begin
                $fdisplay(fd_tb, "%5d | %b | %b | %3b | %b | %8b | PASS | %6d",
                          i_tb, a_tb, b_tb, sel_tb, y_tb, expected_tb, random_value);
                $display("Test %0d PASSED", i_tb);
            end
            else begin
                $fdisplay(fd_tb, "%5d | %b | %b | %3b | %b | %8b | FAIL | %6d",
                          i_tb, a_tb, b_tb, sel_tb, y_tb, expected_tb, random_value);
                $display("Test %0d FAILED", i_tb);
            end
        end

        $fclose(fd_tb);                         // Close Summary Report
        $display("Testing complete. Results saved to mux2to1_seed_sim.rpt");
        $finish;                                // Stop Simulation
    end

    initial begin                               // Waveform Dumping
        $fsdbDumpfile("mux2to1_seed_sim.fsdb");
        $fsdbDumpvars(0, mux2to1_seed_tb);
    end

endmodule
