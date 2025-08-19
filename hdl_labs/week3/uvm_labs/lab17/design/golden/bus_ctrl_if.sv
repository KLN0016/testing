interface bus_ctrl_if;
  // Testbench-driven signals
  logic reset_n_tb;       // Active-low reset (0 = reset, 1 = normal operation)
  logic [7:0] addr_tb;    // Address bus
  logic [31:0] wdata_tb;  // Write data
  logic write_tb;         // Write enable (1 = write, 0 = read)
  logic valid_tb;         // Transaction valid
  logic clk_tb;           // Clock supplied by testbench

  // DUT-driven signals
  logic [31:0] rdata;     // Read data
  logic ready;            // Transaction ready

  // Clocking blocks for synchronization
  clocking drv_cb @(posedge clk_tb);
    default input #1step output #1;
    output reset_n_tb, addr_tb, wdata_tb, write_tb, valid_tb;  // Driven 1ns AFTER clock edge
    input rdata, ready;                                        // Sampled 1step BEFORE clock edge
  endclocking

  clocking mon_cb @(posedge clk_tb);
    default input #1step;
    input reset_n_tb, addr_tb, wdata_tb, write_tb, valid_tb, rdata, ready;
  endclocking

  // Synchronous signal assertion checks
  // When:
  // The testbench starts a transaction (valid_tb=1)
  // The DUT is busy (ready=0)
  // Then:
  // The DUT must assert ready within 1 to 4 clock cycles
  // If not, the assertion fails (indicating a protocol violation)
  property valid_ready_handshake;
    @(posedge clk_tb)
    (valid_tb && !ready)
    |=> ##[1:4] (ready);
    // Below are for debug purpose
    //(valid_tb && !ready, $display("Transaction started at %t", $time))
    //|=> ##[1:4] (ready, $display("Handshake completed at %t", $time));
  endproperty

  assert property (valid_ready_handshake) else
    $error("Valid-Ready handshake violation: Ready didn't arrive within 1-4 cycles after Valid");
endinterface
