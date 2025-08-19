class bus_test extends uvm_test;
   `uvm_component_utils(bus_test)

   bus_sequencer sqr;
   bus_driver drv;
   bus_vsequence v_seq;
//   bus_sequence seq;
//   high_prio_seq hseq; // lab7
//   low_prio_seq lseq;  // lab7

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sqr = bus_sequencer::type_id::create("sqr", this);
      drv = bus_driver::type_id::create("drv", this);
   endfunction

   function void connect_phase(uvm_phase phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
   endfunction

   virtual task run_phase(uvm_phase phase);
      v_seq = bus_vsequence::type_id::create("v_seq");
      v_seq.main_sqr = sqr;
//      seq  = bus_sequence::type_id::create("seq");
//      hseq = high_prio_seq::type_id::create("hseq");
//      lseq = low_prio_seq::type_id::create("lseq");
      `uvm_info("BTOP/TEST", "Launching the sequence", UVM_MEDIUM);
      phase.raise_objection(this);
      v_seq.start(null); // Start on null (virtual sequence)
//      fork // lab7
//        begin seq.start(sqr); end// Launch the sequence
//        begin hseq.start(sqr); end// Lab7 Launch the sequence
//        begin lseq.start(sqr); end // Lab7 Launch the sequence
//      join
      phase.drop_objection(this);
   endtask
endclass
