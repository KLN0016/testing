class driver;
  virtual bus_if m_bus_vif;
  event drv_done;
  mailbox drv_mbx;

  task run();
    $display ("T=%0t [Driver] starting ...", $time);

    // Try to get a new transaction every time and then assign
    // packet contents to the interface. But do this only if the
    // design is ready to accept new transactions
    forever begin
      Packet item;

      $display ("T=%0t [Driver] waiting for item ...", $time);
      drv_mbx.get(item);
      @ (posedge m_bus_vif.clk);
	    item.print("Driver");
      m_bus_vif.rstn  <= item.rstn;
      m_bus_vif.vld   <= item.vld;
      m_bus_vif.addr  <= item.addr;
      m_bus_vif.data  <= item.data;

      $display("T=%0t [Driver] trigger the drv_done event", $time);
      ->drv_done;
    end
  endtask
endclass
