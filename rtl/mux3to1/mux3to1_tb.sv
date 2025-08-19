module mux3to1_tb;

    logic           a;
    logic           b;
    logic           c;
    logic [2-1:0]   sel;
    logic           y;

    localparam test_num = 10;
    integer    fd;

    mux3to1 dut(.*);

    initial begin
    	$fsdbDumpfile("waveform.fsdb");
    	$fsdbDumpvars(0, mux3to1_tb);
	end

    initial begin
        a   = '0;
        b   = '0;
        c   = '0;
        sel = '0;
        #5

        for (int i = 0; i < test_num; i++) begin
            a   = $urandom_range(0, 1);
            b   = $urandom_range(0, 1);
            c   = $urandom_range(0, 1);
            sel = $urandom_range(0, 2);
            #5;

            case(sel)
                2'b00   : assert (y == a)  $fdisplay(fd, "TEST PASSED");
                            else $error("Assertion failed: sel=0, out=%0d, expected=%0d", y, a);
                2'b01   : assert (y == b)  $fdisplay(fd, "TEST PASSED");
                            else $error("Assertion failed: sel=1, out=%0d, expected=%0d", y, b);
                2'b10   : assert (y == c)  $fdisplay(fd, "TEST PASSED");
                            else $error("Assertion failed: sel=2, out=%0d, expected=%0d", y, c);
                default : assert (y == '0) $fdisplay(fd, "TEST PASSED");
                            else $error("Assertion failed: sel=invalid range, out=%0d, expected=0", y);
            endcase
        end
        $fclose(fd);
        $finish;
    end

    initial begin
        fd = $fopen("mux3to1_tb_log.txt", "w");
        $fmonitor(fd, "Time: %0t \t| sel=%0d | a=%0d | b=%0d | c=%0d | out=%0d", $time, sel, a, b, c, y);
        $monitor("Time: %0t \t| sel=%0d | a=%0d | b=%0d | c=%0d | out=%0d", $time, sel, a, b, c, y);
    end
endmodule
