module mux2to1_tb;

    logic a;
    logic b;
    logic sel;
    logic y;

    localparam test_num = 10;

    mux2to1 dut(.*);

    initial begin
    	$fsdbDumpfile("waveform.fsdb");
    	$fsdbDumpvars(0, mux2to1_tb);
	end

    initial begin
        a   = '0;
        b   = '0;
        sel = '0;
        #5

        for (int i = 0; i < test_num; i++) begin
            a   = $urandom_range(0, 1);
            b   = $urandom_range(0, 1);
            sel = $urandom_range(0, 1);
            #5;

            case(sel)
                2'b00   : assert (y == a)  else $error("Assertion failed: sel=0, out=%0d, expected=%0d", y, a);
                2'b01   : assert (y == b)  else $error("Assertion failed: sel=1, out=%0d, expected=%0d", y, b);
                default : assert (y == '0) else $error("Assertion failed: sel=invalid range, out=%0d, expected=0", y);
            endcase
        end
        $finish;
    end

    initial begin
        $monitor("Time: %0t, sel=%0d, a=%0d, b=%0d => out=%0d", $time, sel, a, b, y);
    end
endmodule

