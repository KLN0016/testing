module fsm_short_tb;

    logic clock;
    logic reset;
    logic r, y, g;

    logic [2:0] expected_output;
    logic [4:0] timer_tb;
    localparam RED      = 3'b100;
    localparam YELLOW   = 3'b010;
    localparam GREEN    = 3'b001;
    localparam RED_TIMER    = 5'd20;
    localparam YELLOW_TIMER = 5'd5;
    localparam GREEN_TIMER  = 5'd15;

    fsm_short dut(.*);

    initial begin
        $fsdbDumpfile("waveform.fsdb");
        $fsdbDumpvars(0, fsm_short_tb);
    end

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    always @(posedge clock or posedge reset) begin
      if (reset) begin
        expected_output <= RED;
        timer_tb        <= '0;
      end else begin
        if (timer_tb >= RED_TIMER && expected_output == RED) begin // RED TO GREEN
          expected_output <= GREEN;
          timer_tb        <= '0;
        end else if (timer_tb >= GREEN_TIMER && expected_output == GREEN) begin // GREEN TO YELLOW
          expected_output <= YELLOW;
          timer_tb        <= '0;
        end else if (timer_tb >= YELLOW_TIMER && expected_output == YELLOW) begin // YELLOW TO RED
          expected_output <= RED;
          timer_tb        <= '0;
        end else begin
          expected_output <= expected_output;
          timer_tb <= timer_tb +1;
        end
      end
    end

    initial begin
        timer_tb = '0;
        reset = 1;
        repeat (2) @(posedge clock);
        reset = 0;
        repeat (2) @(posedge clock);

        repeat (100) @(posedge clock);
        $finish;
    end

    initial begin
        $monitor("Time: %t | Red=%0d | Yellow=%0d | Green=%0d", $time, r, y, g);
        if ({r,y,g} == expected_output) begin

        end
    end


endmodule

