`timescale 1ns/1ps

module adder_tb;
    // Variables from command line
    int     number_of_tests;
    string  report_file;
    int     seed;

    initial begin
        if (!$value$plusargs("number_of_tests=%d", number_of_tests)) number_of_tests = 50;
        if (!$value$plusargs("report_file=%s"    , report_file))     report_file     = "adder_sim.rpt";
        if (!$value$plusargs("seed=%d"           , seed))            seed            = 200;
        void'($urandom(seed));
    end

    // Signals
    logic a_tb;
    logic b_tb;
    logic cin_tb;
    logic sum_tb;
    logic cout_tb;

    // Test control
    logic expected_sum;
    logic expected_cout;
    int error_count         = 0;
    int sum_error_count     = 0;
    int cout_error_count    = 0;
    int test_count          = 0;

    // Instantiate DUT
    adder uut (
        .a(a_tb),
        .b(b_tb),
        .cin(cin_tb),
        .sum(sum_tb),
        .cout(cout_tb)
    );

    // Expected output calculator
    function automatic void calculate_expected(
        input logic a, b, cin,
        output logic sum, cout
    );
        sum = a ^ b ^ cin;
        cout = (a & b) | (cin & (a ^ b));
    endfunction

    initial begin
        int fd;
        // Open log file
        fd = $fopen(report_file, "w");

        $fdisplay(fd, "[INFO] Number of tests   : %0d", number_of_tests);
        $fdisplay(fd, "[INFO] Report file       : %0s", report_file);
        $fdisplay(fd, "[INFO] Seed value        : %0d", seed);

        // Main test loop
        for (int i = 0; i < number_of_tests; i++) begin
            // Randomize inputs
            a_tb    = $urandom;
            b_tb    = $urandom;
            cin_tb  = $urandom;

            test_count++;

            // Calculate expected outputs
            calculate_expected(a_tb, b_tb, cin_tb, expected_sum, expected_cout);

            // Wait for propagation
            #10;

            // Check results
            if (sum_tb !== expected_sum) begin
                $fdisplay(fd, "[ERROR-S] Test %0d: %b + %b + %b = sum:%b (exp:%b), cout:%b (exp:%b)",
                          i, a_tb, b_tb, cin_tb, sum_tb, expected_sum, cout_tb, expected_cout);
            end
            else if (cout_tb !== expected_cout) begin
                $fdisplay(fd, "[ERROR-C] Test %0d: %b + %b + %b = sum:%b (exp:%b), cout:%b (exp:%b)",
                          i, a_tb, b_tb, cin_tb, sum_tb, expected_sum, cout_tb, expected_cout);
            end
            else begin
                $fdisplay(fd, "[PASS]    Test %0d: %b + %b + %b = sum:%b (exp:%b), cout:%b (exp:%b)",
                          i, a_tb, b_tb, cin_tb, sum_tb, expected_sum, cout_tb, expected_cout);
            end
        end

        // Summary
        $display("[INFO] Testbench completed\n");
        $fdisplay(fd, "[INFO] Testbench completed\n");
        $fclose(fd);
        #10 $finish;
   end
endmodule

