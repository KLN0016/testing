class bus_test extends uvm_test;
   `uvm_component_utils(bus_test)

   bus_sequencer  sqr;
   bus_driver     drv;
   bus_sequence   seq;
   bus_monitor    mon;  // lab8
   high_prio_seq  hseq; // lab7
   low_prio_seq   lseq; // lab7
   bus_env        env;  // lab9

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
      `uvm_info("BTOP/TEST", "Launching the sequence", UVM_MEDIUM);
      phase.raise_objection(this);

      fork // lab7
        begin seq.start(env.sqr); end   // Launch the sequence      // Lab9 add env.
        begin hseq.start(env.sqr); end  // Lab7 Launch the sequence // Lab9 add env.
        begin lseq.start(env.sqr); end  // Lab7 Launch the sequence // Lab9 add env.
      join
      phase.drop_objection(this);
   endtask
endclass
