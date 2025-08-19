
//Assertion Sequence $rose, $fell, $stable
//
//A sequence is a simple building block in System Verilog assertions that can
//represent certain expressions to aid in creating more complex properties.
//
module tb;
  	bit a;
  	bit clk;

    logic req, ack;
    logic resetn;
    logic temp;

    always_ff @(posedge clk, negedge resetn) begin
        if (~resetn) begin
            temp <= '0;
            ack <= '0;
        end else begin
            temp <= req;
            ack <= temp;
        end
    end

    REQ_1CYCLE: assert property (@(posedge clk)
                    $rose(req) |=> $fell(req)
                );
    ACK_1CYCLE: assert property (@(posedge clk)
                    $rose(ack) |=> $fell(ack)
                );

    property sva_req2ack;
        @(posedge clk) disable iff(!resetn)
            $fell(req) |=> $rose(ack);
    endproperty
    ACK_AFTER_REQ_DEASSERT: assert property (sva_req2ack);

    //    ACK_AFTER_REQ_DEASSERT: assert property (@(posedge clk) disable iff(~resetn)
    //                              $fell(req) |=> $rose(ack)
    //                            );


    ///////////////////////////////////////////////////////////////////
	// This sequence states that a should be high on every posedge clk
  	sequence s_a;
      @(posedge clk) a;
    endsequence

  	// When the above sequence is asserted, the assertion fails if 'a'
  	// is found to be not high on any posedge clk
  	//assert_a:assert property(s_a);

    ///////////////////////////////////////////////////////////////////
	// This sequence states that 'a' should rise on every posedge clk
  	sequence s_rose_a;
      @(posedge clk) $rose(a);
    endsequence

  	// When the above sequence is asserted, the assertion fails if
  	// posedge 'a' is not found on every posedge clk
  	//rose_a:assert property(s_rose_a);

    ///////////////////////////////////////////////////////////////////
	// This sequence states that 'a' should fall on every posedge clk
  	sequence s_fell_a;
      @(posedge clk) $fell(a);
    endsequence

  	// When the above sequence is asserted, the assertion fails if
  	// negedge 'a' is not found on every posedge clk
  	//fell_a:assert property(s_fell_a);

    ///////////////////////////////////////////////////////////////////
	// This sequence states that 'a' should be stable on every clock
	// and should not have posedge/negedge at any posedge clk
  	sequence s_stable_a;
      @(posedge clk) $stable(a);
    endsequence

  	// When the above sequence is asserted, the assertion fails if
  	// 'a' toggles at any posedge clk
  	//stable_a:assert property(s_stable_a);

    property combine_seq;
        @(posedge clk)
            s_fell_a |-> s_stable_a;
    endproperty

    //NEW_PROPERTY: assert property (combine_seq) else $error("SVA_ERROR");

    ///////////////////////////////////////////////////////////////////

	always #10 clk = ~clk;

    initial begin
        req = '0;
        resetn = '0;
    end

    initial begin
        //repeat(10) @(posedge clk)
        //resetn <= '0;
        repeat(10) @(posedge clk);
        resetn <= '1;


        for(int idx = 0; idx < 100; idx++) begin
            @(posedge clk) req <= ~req;
        end
    end

    initial begin
        #2000;
        $finish;
    end
/*
	initial begin
      for (int i = 0; i < 100; i++) begin
        a = $random;
        @(posedge clk);

        // Assertion is evaluated in the preponed region and
        // use $display to see the value of 'a' in that region
        $display("[%0t] a=%0d", $time, a);
      end
      #2000 $finish;
    end
*/
    initial begin
        $fsdbDumpfile("waveform.fsdb");   // Set output FSDB file name
        $fsdbDumpvars(0, tb);         // Dump all variables from tb_top and below
    end
endmodule
