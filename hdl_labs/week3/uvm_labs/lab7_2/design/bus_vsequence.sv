class bus_vsequence extends uvm_sequence;
    `uvm_object_utils(bus_vsequence)

    // Handles to sub-sequences
    bus_sequence normal_seq;
    high_prio_seq h_prio_seq;
    low_prio_seq l_prio_seq;

    // Sequencer handles
    uvm_sequencer #(bus_transaction) main_sqr;

    function new(string name="bus_vsequence");
        super.new(name);
    endfunction

    task body();
        // Create sub-sequences
        normal_seq = bus_sequence::type_id::create("normal_seq");
        h_prio_seq = high_prio_seq::type_id::create("h_prio_seq");
        l_prio_seq = low_prio_seq::type_id::create("l_prio_seq");

        `uvm_info("V_SEQ", "Starting virtual sequence", UVM_MEDIUM)

        // Fork off all sequences in parallel
        fork
            begin
                `uvm_info("V_SEQ", "Starting normal sequence", UVM_MEDIUM)
                normal_seq.start(main_sqr);
            end
            begin
                `uvm_info("V_SEQ", "Starting high priority sequence", UVM_MEDIUM)
                h_prio_seq.start(main_sqr);
            end
            begin
                `uvm_info("V_SEQ", "Starting low priority sequence", UVM_MEDIUM)
                l_prio_seq.start(main_sqr);
            end
        join

        `uvm_info("V_SEQ", "Virtual sequence complete", UVM_MEDIUM)
    endtask
endclass
