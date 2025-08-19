class bus_monitor extends uvm_component;
   `uvm_component_utils(bus_monitor)

   // Analysis port implementation to receive transactions
   uvm_analysis_imp #(bus_transaction, bus_monitor) ap_implementation;

   // put port for consumer
   uvm_put_port #(bus_transaction) put_port; // lab10

   // ap_port for scoreboard and coverage lab12
   uvm_analysis_port #(bus_transaction) ap_port; // lab12

   function new(string name, uvm_component parent);
      super.new(name, parent);
      ap_implementation = new("ap_implementation", this);
      put_port          = new("put_port", this);  // lab10
      ap_port           = new("ap_port", this);   // lab12
   endfunction

   function void write(bus_transaction tr);
      `uvm_info("MONITOR",
                $sformatf("Observed transaction: addr=0x%2h, data=0x%8h, write=%0b",
                          tr.addr, tr.data, tr.write),
                UVM_LOW)
      ap_port.write(tr);
      fork // lab10
      //  do_put(tr);
        put_port.put(tr);
      join_none
   endfunction

   task do_put(bus_transaction tr); // lab10
      put_port.put(tr);
   endtask
endclass

