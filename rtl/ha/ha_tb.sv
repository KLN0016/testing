module ha_tb;

    logic a;
    logic b;
    logic s;
    logic cout;

    ha dut(.*);

    initial begin
    	$fsdbDumpfile("waveform.fsdb");
    	$fsdbDumpvars(0, ha_tb);
	end

    initial begin
        a   = '0;
        b   = '0;
        #5;

        for (int i = 0; i < 10; i++) begin
            {a, b} = i%4;
            #5;
            assert (s == (a ^ b));
            assert (cout == (a & b));
        end
        $finish;
    end

    initial begin
        $monitor("Time: %0t, a=%0d, b=%0d => cout=%0d, s=%0d", $time, a, b, cout, s);
    end
endmodule
