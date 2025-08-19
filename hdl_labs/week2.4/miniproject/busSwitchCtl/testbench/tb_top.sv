module testbench;
  logic tb_clk;

  bus_if 	m_bus_if(tb_clk);

  // DUT
  switch dut0(
    .clk    (m_bus_if.clk),
    .rstn   (m_bus_if.rstn),
    .vld    (m_bus_if.vld),
    .addr   (m_bus_if.addr),
    .data   (m_bus_if.data),
    .addr_a (m_bus_if.addr_a),
    .data_a (m_bus_if.data_a),
    .addr_b (m_bus_if.addr_b),
    .data_b (m_bus_if.data_b)
  );

  covergroup cg;
    CG_RSTN   : coverpoint m_bus_if.rstn {
                }
    CG_VLD    : coverpoint m_bus_if.vld {
                }
    CG_ADDR   : coverpoint m_bus_if.addr {
                  bins valid_a = {['h00:'h3F]};
                  bins valid_b = {['h40:'hFF]};
                }
    CG_DATA   : coverpoint m_bus_if.data {
                  bins zero_data     = {'h0};
                  bins non_zero_data = {['h0001:'hFFFF]};
                }
    CG_ADDR_A : coverpoint m_bus_if.addr_a {
                  bins         valid_addr   = {['h00:'h3F]};
                  illegal_bins invalid_addr = {['h40:'hFF]};
                }
    CG_DATA_A : coverpoint m_bus_if.data_a {
                  bins zero_data     = {'h0};
                  bins non_zero_data = {['h0001:'hFFFF]};
                }
    CG_ADDR_B : coverpoint m_bus_if.addr_b {
                  bins         valid_zero   = {8'h00};
                  bins         valid_addr   = {[8'h40:8'hFF]};
                  illegal_bins invalid_addr = {[8'h01:8'h3F]};
                }
    CG_DATA_B : coverpoint m_bus_if.data_b {
                  bins zero_data     = {'h0};
                  bins non_zero_data = {['h0001:'hFFFF]};
                }
  endgroup

  RST_CHECK:  assert property ( @(posedge m_bus_if.clk)
                (!m_bus_if.rstn) |=> (m_bus_if.addr_a === '0 &&
                                      m_bus_if.data_a === '0 &&
                                      m_bus_if.addr_b === '0 &&
                                      m_bus_if.data_b === '0 )
              ) else $fatal("FAIL: addr and data not zero during sync reset.");

  VLD_0_CHECK:  assert property ( @(posedge m_bus_if.clk)
                (m_bus_if.rstn && !m_bus_if.vld) |=> (m_bus_if.addr_a === $past(m_bus_if.addr_a) &&
                                                      m_bus_if.data_a === $past(m_bus_if.data_a) &&
                                                      m_bus_if.addr_b === $past(m_bus_if.addr_b) &&
                                                      m_bus_if.data_b === $past(m_bus_if.data_b) )
                ) else $fatal("FAIL: addr and data not hold when valid is low.");

  PORT_A_CHECK:  assert property ( @(posedge m_bus_if.clk)
                    (m_bus_if.rstn && m_bus_if.vld && m_bus_if.addr inside {[8'h00:8'h3F]})
                    |=> (m_bus_if.addr_a === $past(m_bus_if.addr) &&
                         m_bus_if.data_a === $past(m_bus_if.data) &&
                         m_bus_if.addr_b === '0                   &&
                         m_bus_if.data_b === '0                   )
                  ) else $fatal("FAIL: Incorrect output when A condition.");

  PORT_B_CHECK:  assert property ( @(posedge m_bus_if.clk)
                    (m_bus_if.rstn && m_bus_if.vld && m_bus_if.addr inside {[8'h40:8'hFF]})
                    |=> (m_bus_if.addr_a === '0                   &&
                         m_bus_if.data_a === '0                   &&
                         m_bus_if.addr_b === $past(m_bus_if.addr) &&
                         m_bus_if.data_b === $past(m_bus_if.data) )
                  ) else $fatal("FAIL: Incorrect output when B condition");

  initial begin
      $fsdbDumpfile("waveform.fsdb");
      $fsdbDumpvars(0, testbench);
  end

  initial begin
    tb_clk = '0;
    forever #10 tb_clk = ~tb_clk;
  end

  initial begin
    test t0;
    cg cg_inst      = new();
    t0              = new();
    t0.e0.m_bus_vif = m_bus_if;

    // initialize input
    m_bus_if.rstn = '0;
    m_bus_if.vld  = '0;
    m_bus_if.addr = '0;
    m_bus_if.data = '0;

    repeat (5) @(posedge m_bus_if.clk);

    fork
      t0.run();
      forever @(posedge m_bus_if.clk) cg_inst.sample();
    join_any


    // Once the main stimulus is over, wait for some time
    // until all transactions are finished and then end
    // simulation. Note that $finish is required because
    // there are components that are running forever in
    // the background like clk, monitor, driver, etc
    // repeat (5) @(posedge tb_clk);
    $display("NO FATAL! RUN COMPLETED!");
    $finish;
  end
endmodule
