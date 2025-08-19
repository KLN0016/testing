`include "uvm_macros.svh"

module bus_tb;
   initial $display(">>>>>>>> SIM TIME START: %0t", $time);
   final   $display(">>>>>>>> SIM TIME END  : %0t", $time);

   // Include all required files
   `include "bus_transaction.sv"
   `include "bus_sequence.sv"
   `include "bus_sequencer.sv"
   `include "bus_sequence_prio.sv"  // lab7
   `include "bus_driver.sv"
   `include "bus_monitor.sv"        // lab8
   `include "bus_consumer.sv"       // lab10
   `include "bus_scoreboard.sv"     // lab12
   `include "bus_coverage.sv"       // lab12
   `include "bus_env.sv"            // lab9
   `include "bus_test.sv"

   initial begin
      run_test("bus_test");
   end
endmodule
