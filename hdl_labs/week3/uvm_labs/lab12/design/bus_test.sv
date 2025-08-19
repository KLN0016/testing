class bus_test extends uvm_test;
   `uvm_component_utils(bus_test)

   bus_sequencer  sqr;
   bus_driver     drv;
   bus_sequence   seq;
   bus_monitor    mon;  // lab8
   high_prio_seq  hseq; // lab7
   low_prio_seq   lseq; // lab7
   bus_env        env;  // lab9

   int seq_count = 8, hseq_count = 2, lseq_count = 5;
   int seq_min_delay = 10,  seq_max_delay = 15;
   int hseq_min_delay = 0, hseq_max_delay = 5;
   int lseq_min_delay = 5, lseq_max_delay = 10;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = bus_env::type_id::create("env", this); // lab9

      //sqr = bus_sequencer::type_id::create("sqr", this);
      //drv = bus_driver::type_id::create("drv", this);
      //mon = bus_monitor::type_id::create("mon", this); // lab8
   endfunction

//   function void connect_phase(uvm_phase phase);
//      drv.seq_item_port.connect(sqr.seq_item_export);
//      drv.ap.connect(mon.ap_implementation); // lab8
//   endfunction

   virtual task run_phase(uvm_phase phase);
      seq  = bus_sequence::type_id::create("seq");
      hseq = high_prio_seq::type_id::create("hseq");
      lseq = low_prio_seq::type_id::create("lseq");
      // Lab 11
      seq.seq_count = this.seq_count;
      seq.min_delay = this.seq_min_delay;
      seq.max_delay = this.seq_max_delay;
      hseq.seq_count = this.hseq_count;
      hseq.min_delay = this.hseq_min_delay;
      hseq.max_delay = this.hseq_max_delay;
      lseq.seq_count = this.lseq_count;
      lseq.min_delay = this.lseq_min_delay;
      lseq.max_delay = this.lseq_max_delay;

      // Lab 11
      `uvm_info("TEST", $sformatf("Starting sequences with config:\n\
                                    Normal:\t count=%0d, delay=%0d-%0d\n\
                                    High:\t count=%0d, delay=%0d-%0d\n\
                                    Low:\t count=%0d, delay=%0d-%0d",
                                  seq.seq_count, seq.min_delay, seq.max_delay,
                                  hseq.seq_count, hseq.min_delay, hseq.max_delay,
                                  lseq.seq_count, lseq.min_delay, lseq.max_delay),
                                  UVM_MEDIUM)

      `uvm_info("TEST", "Launching the sequence", UVM_MEDIUM);
      phase.raise_objection(this);

      fork // lab7
        begin seq.start(env.sqr); end   // Launch the sequence      // Lab9 add env.
        begin hseq.start(env.sqr); end  // Lab7 Launch the sequence // Lab9 add env.
        begin lseq.start(env.sqr); end  // Lab7 Launch the sequence // Lab9 add env.
      join
      wait(env.consumer.num_processed + env.consumer.fifo_overflows == env.consumer.num_received);  // Important to avoid simulation ended before processing all the FIFO contents

      phase.drop_objection(this);
   endtask
endclass
