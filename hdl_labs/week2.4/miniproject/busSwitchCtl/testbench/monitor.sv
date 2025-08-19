// The monitor has a virtual interface handle with which it can monitor
// the events happening on the interface. It sees new transactions and then
// captures information into a packet and sends it to the scoreboard
// using another mailbox.
class monitor;
  virtual bus_if 	m_bus_vif;

  mailbox scb_mbx; 		// Mailbox connected to scoreboard

  task run();
    $display ("T=%0t [Monitor] starting ...", $time);

    // Check forever at every clock edge to see if there is a
    // valid transaction and if yes, capture info into a class
    // object and send it to the scoreboard when the transaction
    // is over.
    forever begin
	  Packet m_pkt = new();

      @(posedge m_bus_vif.clk);
      #1;
        m_pkt.rstn 	  = m_bus_vif.rstn;
        m_pkt.vld 	  = m_bus_vif.vld;
      	m_pkt.addr 	  = m_bus_vif.addr;
        m_pkt.data 	  = m_bus_vif.data;
      	m_pkt.addr_a  = m_bus_vif.addr_a;
        m_pkt.data_a 	= m_bus_vif.data_a;
      	m_pkt.addr_b	= m_bus_vif.addr_b;
        m_pkt.data_b 	= m_bus_vif.data_b;
        m_pkt.print("Monitor");
        scb_mbx.put(m_pkt);
    end
  endtask
endclass
