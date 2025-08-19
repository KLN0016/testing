module tb_bus_switching_controller;

    logic           clk;
    logic           rstn;
    logic           vld;
    logic [8 -1:0]  addr;
    logic [16-1:0]  data;

    logic [8 -1:0]  addr_a;
    logic [8 -1:0]  addr_b;
    logic [16-1:0]  data_a;
    logic [16-1:0]  data_b;

    localparam test_num = 100;

    bus_switching_controller dut(.*);

    initial begin
    	$fsdbDumpfile("waveform.fsdb");
    	$fsdbDumpvars(0, tb_bus_switching_controller);
	end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rstn = '0;
        vld  = '0;
        addr = '0;
        data = '0;
        repeat (2) @(posedge clk);

        rstn = '1;
        repeat (5) @(posedge clk);
        vld  = '1;
        repeat (2) @(posedge clk);

        fork
            begin
                for (int i = 0; i < test_num; i++) begin
                    addr = $urandom;
                    data = $urandom;
                    repeat (2) @(posedge clk);
                end
            end
            begin
                rstn = '0;
                repeat (15) @(posedge clk);
                rstn = '0;
                repeat (15) @(posedge clk);
                rstn = '1;
            end
        join

        $finish;
    end

    initial begin
        $monitor("Time: %0t \t | vld=%0b | addr=%2h | data=%4h => addr_a=%2h | data_a=%4h | addr_b=%2h | data_b=%4h", $time, vld, addr, data, addr_a, data_a, addr_b, data_b);
    end

    RST_CHECK:  assert property ( @(posedge clk or negedge rstn)
                    (!rstn) |-> (addr_a == '0 && data_a == '0 && addr_b == '0 && data_b == '0)
                )
                else $error("FAIL: addr and data not zero during async reset.");

    VLD_CHECK:  assert property ( @(posedge clk)
                    (rstn && !vld) |-> (addr_a == '0 && data_a == '0 && addr_b == '0 && data_b == '0)
                )
                else $error("FAIL: addr and data not zero when valid is low.");

    PORT_A_CHECK:   assert property ( @(posedge clk)
                        (rstn && vld && addr inside {[8'h00:8'h3F]}) |-> (addr_a == addr && data_a == data && addr_b == '0 && data_b == '0)
                    )
                    else $error("FAIL: Incorrect output.");

    PORT_B_CHECK:   assert property ( @(posedge clk)
                        (rstn && vld && addr inside {[8'h40:8'hFF]}) |-> (addr_b == addr && data_b == data && addr_a == '0 && data_a == '0)
                    )
                    else $error("FAIL: Incorrect output.");
endmodule
