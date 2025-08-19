module tb_fa;
    logic clk;
    logic rstn;
    logic d;
    logic q;

    dff dut(.*);

    covergroup cg @(posedge clk);
        CP_RSTN : coverpoint rstn;
        CP_D    : coverpoint d;
        CP_Q    : coverpoint q;
    endgroup

    initial begin
    	$fsdbDumpfile("waveform.fsdb");
    	$fsdbDumpvars(0, tb_fa);
	end

    initial begin
        clk = '0;
        forever #10 clk = ~clk;
    end

    initial begin
        cg cg_inst = new();
        rstn    = '0;
        d       = '0;

        repeat (10) @(posedge clk);
        rstn    = '1;
        repeat (5) @(posedge clk);

        fork
            begin
                for (int i = 0; i < 20; i++) begin
                    d <= $urandom_range(0, 1);
                    repeat (2) @(posedge clk);
                end
            end
            begin
                #144 rstn <= '0;
                repeat (5) @(posedge clk);
                rstn <= '1;
                repeat (5) @(posedge clk);
            end
        join

        repeat (20) @(posedge clk);
        $finish;
    end

    initial begin
        $monitor("Time: %0t, rstn=%0d, d=%0d => q=%0d", $time, rstn, d, q);
    end

    AST_RST_CHECK:  assert property (@(posedge clk) disable iff (rstn)
                        (!rstn) |=> (q == '0)
                    );

    AST_Q_EQUAL_D_AFTER_1C: assert property (@(posedge clk) disable iff (!rstn)
                                (rstn & 1'b1) |=> (q == $past(d))
                            );
endmodule
