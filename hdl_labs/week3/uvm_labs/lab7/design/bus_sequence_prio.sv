class high_prio_seq extends bus_sequence;
   `uvm_object_utils(high_prio_seq)

   function new(string name = "high_prio_seq");
      super.new(name);
   endfunction

   task body();
      bus_transaction req;
      `uvm_info(get_type_name(), "High Priority Sequence", UVM_MEDIUM)
      m_sequencer.lock(this); // lock
      `uvm_info("DRIVER", "LOCK HIGH PRIORITY", UVM_LOW)
      repeat (3) begin
         req = bus_transaction::type_id::create("req");
         start_item(req);
         assert(req.randomize() with { addr[7:4] == 4'hF; write == 0; });
         finish_item(req);
      end
      m_sequencer.unlock(this); // unlock
      `uvm_info("DRIVER", "UNLOCK HIGH PRIORITY", UVM_LOW)
   endtask
endclass

class low_prio_seq extends bus_sequence;
   `uvm_object_utils(low_prio_seq)

   function new(string name = "low_prio_seq");
      super.new(name);
   endfunction

   task body();
      bus_transaction req;
      `uvm_info(get_type_name(), "Low Priority Sequence", UVM_MEDIUM)
      m_sequencer.grab(this); // grab
      `uvm_info("DRIVER", "GRAB LOW PRIORITY", UVM_LOW)
      repeat (2) begin
         req = bus_transaction::type_id::create("req");
         start_item(req);
         assert(req.randomize() with { addr[7:4] == 4'hE; write == 0; });
         finish_item(req);
      end
      m_sequencer.ungrab(this); // grab
      `uvm_info("DRIVER", "UNGRAB LOW PRIORITY", UVM_LOW)
   endtask
endclass
