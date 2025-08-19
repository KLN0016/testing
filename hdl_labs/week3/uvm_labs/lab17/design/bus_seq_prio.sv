class high_prio_seq extends bus_seq;
  `uvm_object_utils(high_prio_seq)

  int seq_count;
  int seq_index;
  string seq_type;
  string seq_dir;

  bit [7:0] last_write_addr;

  function new(string name = "high_prio_seq");
    super.new(name);
    seq_index = 0;
    seq_type = "high";
  endfunction

  task body();
    bus_tran tr;
    `uvm_info(get_type_name(), "High Priority Sequence", UVM_MEDIUM)
    m_sequencer.lock(this);

    repeat (seq_count) begin
      seq_index++;
      // Write data to a random address
      tr = bus_tran::type_id::create("tr");
      start_item(tr);
      assert(tr.randomize() with { addr[7:4] == 4'hB; write == 1; });
      //assert(tr.randomize() with { write == 1; });
      last_write_addr = tr.addr;  // Store the write address directly
      seq_dir = "WR";
      `uvm_info(get_type_name(), $sformatf("Sent %s %0d/%0d %s seq: addr=0x%2h, data=0x%8h, write=%0b",
                                           seq_dir, seq_index, seq_count, seq_type, tr.addr, tr.data, tr.write),
             UVM_MEDIUM)
      tr.seq_count = this.seq_count;
      tr.seq_index = this.seq_index;
      tr.seq_type = this.seq_type;
      tr.seq_dir = this.seq_dir;
      finish_item(tr);
      // Read the data back from the write adddress
      tr = bus_tran::type_id::create("tr");
      start_item(tr);
      tr.addr = last_write_addr;
      tr.write = 0;
      delay = get_random_delay();
      seq_dir = "RD";
      `uvm_info(get_type_name(), $sformatf("Sent %s %0d/%0d %s seq: addr=0x%2h, data=0x%8h, write=%0b Next seq after %0d",
                                           seq_dir, seq_index, seq_count, seq_type, tr.addr, tr.data, tr.write, delay),
                                           UVM_MEDIUM)
      tr.seq_count = this.seq_count;
      tr.seq_index = this.seq_index;
      tr.seq_type = this.seq_type;
      tr.seq_dir = this.seq_dir;
      #delay;
      finish_item(tr);
    end
    m_sequencer.unlock(this);
  endtask
endclass

class low_prio_seq extends bus_seq;
  `uvm_object_utils(low_prio_seq)

  int seq_count;
  int seq_index;
  string seq_type;
  string seq_dir;

  bit [7:0] last_write_addr;

  function new(string name = "low_prio_seq");
    super.new(name);
    seq_index = 0;
    seq_type = "low";
  endfunction

  task body();
    bus_tran tr;
    `uvm_info(get_type_name(), "Low Priority Sequence", UVM_MEDIUM)
    repeat (seq_count) begin
      seq_index++;
      // Write data to a random address
      tr = bus_tran::type_id::create("tr");
      start_item(tr);
      assert(tr.randomize() with { addr[7:4] == 4'hF; write == 1; });
      //assert(tr.randomize() with { write == 1; });
      last_write_addr = tr.addr;  // Store the write address directly
      seq_dir = "WR";
      `uvm_info(get_type_name(), $sformatf("Sent %s %0d/%0d %s seq: addr=0x%2h, data=0x%8h, write=%0b",
                                           seq_dir, seq_index, seq_count, seq_type, tr.addr, tr.data, tr.write),
             UVM_MEDIUM)
      tr.seq_count = this.seq_count;
      tr.seq_index = this.seq_index;
      tr.seq_type = this.seq_type;
      tr.seq_dir = this.seq_dir;
      finish_item(tr);
      // Read the data back from the write adddress
      tr = bus_tran::type_id::create("tr");
      start_item(tr);
      tr.addr = last_write_addr;
      tr.write = 0;
      delay = get_random_delay();
      seq_dir = "RD";
      `uvm_info(get_type_name(), $sformatf("Sent %s %0d/%0d %s seq: addr=0x%2h, data=0x%8h, write=%0b Next seq after %0d",
                                           seq_dir, seq_index, seq_count, seq_type, tr.addr, tr.data, tr.write, delay),
                                           UVM_MEDIUM)
      tr.seq_count = this.seq_count;
      tr.seq_index = this.seq_index;
      tr.seq_type = this.seq_type;
      tr.seq_dir = this.seq_dir;
      #delay;
      finish_item(tr);
    end
  endtask
endclass

