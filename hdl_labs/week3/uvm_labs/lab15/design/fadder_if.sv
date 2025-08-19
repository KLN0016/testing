interface fadder_if;
  logic a_tb;
  logic b_tb;
  logic cin_tb;
  logic sum_tb;
  logic cout_tb;
  logic clk_tb;

  // optional modport
  modport drv_mp(input sum_tb, cout_tb, clk_tb,
                 output a_tb, b_tb, cin_tb);

  modport mon_mp(input sum_tb, cout_tb, clk_tb,
                       a_tb, b_tb, cin_tb);

  clocking drv_cb @(posedge clk_tb);
    default input #1step output #1;
    input sum_tb, cout_tb;
    output a_tb, b_tb, cin_tb;
  endclocking

  clocking mon_cb @(posedge clk_tb);
    default input #1step output #1;
    input sum_tb, cout_tb, a_tb, b_tb, cin_tb;
  endclocking
endinterface
