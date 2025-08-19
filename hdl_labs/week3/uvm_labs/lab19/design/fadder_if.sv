interface fadder_if;
  logic a_tb;
  logic b_tb;
  logic cin_tb;
  logic sum_tb;
  logic cout_tb;
  logic clk_tb;

  // optional modport
  modport drv_mp(
    output a_tb, b_tb, cin_tb,      // Driver drive DUT input
    input clk_tb,                   // Driver need clock for timing
    input sum_tb, cout_tb           // Driver read  DUT output
  );

  modport mon_mp(
    input clk_tb,                   // Monitor only read
    input a_tb, b_tb, cin_tb,
    input sum_tb, cout_tb
  );

  clocking drv_cb @(posedge clk_tb);
    default input #1step output #1;
    input sum_tb, cout_tb;
    output a_tb, b_tb, cin_tb;
  endclocking

  clocking mon_cb @(posedge clk_tb);
    default input #1step output #1;
    input sum_tb, cout_tb, a_tb, b_tb, cin_tb;
  endclocking

  task automatic init_tb();
    a_tb    = 0;
    b_tb    = 0;
    cin_tb  = 0;
  endtask
endinterface
