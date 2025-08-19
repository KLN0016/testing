module fa_tb;

    logic a;
    logic b;
    logic cin;
    logic s;
    logic cout;

    fa dut(.*);

    initial begin
    	$fsdbDumpfile("waveform.fsdb");
    	$fsdbDumpvars(0, fa_tb);
	end

    initial begin
        a   = '0;
        b   = '0;
        cin = '0;
        #5;

        for (int i = 0; i < 8; i++) begin
            {a, b, cin} = i;
            #5;

            assert ({cout,s} == a+b+cin) else $error("Assertion failed: a=%0d, b=%0d, cin=%0d => cout=%0d, s=%0d", a, b, cin, cout, s);
        end
        $finish;
    end

    initial begin
        $monitor("Time: %0t, a=%0d, b=%0d, cin=%0d => cout=%0d, s=%0d", $time, a, b, cin, cout, s);
    end
endmodule
