module testbench;
  bit tb_clk;

  clk_if 	m_clk_if();
  adder_if 	m_adder_if();
  my_adder8	dut0(m_adder_if);   //Design Under Test

  covergroup cg;
    CG_RSTN : coverpoint m_adder_if.rstn {
                bins rstn_valid = {1};
              }
    CG_A    : coverpoint m_adder_if.a {
                bins a_valid[] = {[3:7]};
              }
    CG_B    : coverpoint m_adder_if.b {
                bins b_valid[] = {[8'h1a:8'h1f]};
              }
    CG_SUM  : coverpoint m_adder_if.sum {
                bins sum[] = {[8'h1A+8'h3:8'h1F+8'h7]};
              }
  endgroup

  initial begin
    test t0;

    cg cg_inst = new();
    t0 = new();
    t0.e0.m_adder_vif = m_adder_if;
    t0.e0.m_clk_vif = m_clk_if;

    fork
      t0.run();
      forever @(posedge m_clk_if.tb_clk) cg_inst.sample();
    join_any


    // Once the main stimulus is over, wait for some time
    // until all transactions are finished and then end
    // simulation. Note that $finish is required because
    // there are components that are running forever in
    // the background like clk, monitor, driver, etc
    #20 $finish;
  end
endmodule
