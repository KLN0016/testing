
//coverpoint bin
typedef enum logic [1:0] {IDLE, PRE_CALC, CALC} state_t;

module tb;
  bit [4:0] mode;
  bit [1:0] test;
  state_t   state;
  // This covergroup does not get sample automatically because
  // the sample event is missing in declaration
  covergroup cg;
    CG_MODE: coverpoint mode {
    	bins one = {1};
    	bins five = {5};
        bins misc = default;
        bins all_in[] = {[6:7]};
        bins all_din[] = {[10:15]};
        illegal_bins zero = {0};
    }
    CG_TEST: coverpoint test {}
    CG_STATE: coverpoint state {
        bins trans1 = (IDLE     =>PRE_CALC);
        bins trans2 = (PRE_CALC =>CALC);
        bins trans3 = (CALC     =>IDLE);
    }
    cross CG_MODE, CG_STATE;
  endgroup

  // Stimulus: Simply randomize mode to have different values and
  // manually sample each time
  initial begin
    cg cg_inst = new();

    for (int i = 0; i < 1000; i++) begin
	  #10 mode = $urandom_range(1,15);
	  #10 state = i%3;
      $display ("[%0t] mode = 0x%0h | state: ", $time, mode, state.name());
      cg_inst.sample(); //sample for coverage
    end
    $display ("Instance Coverage = %0.2f %%", cg_inst.get_inst_coverage());
    $display ("Cumulative Coverage = %0.2f %%", cg_inst.get_coverage());
  end

endmodule
