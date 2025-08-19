class Packet #(
  int ADDR_WIDTH = 8,
  int DATA_WIDTH = 16
);
  rand  bit rstn;
  rand  bit vld;
  randc bit [ADDR_WIDTH-1:0] addr;
  randc bit [DATA_WIDTH-1:0] data;

  bit       [ADDR_WIDTH-1:0] addr_a;
  bit       [DATA_WIDTH-1:0] data_a;
  bit       [ADDR_WIDTH-1:0] addr_b;
  bit       [DATA_WIDTH-1:0] data_b;

  // Print contents of the data packet
  function void print(string tag="");
    $display ("T=%0t %s rstn=%0b vld=%0b addr=0x%0h data=0x%0h => addr_a = 0x%0h data_a = 0x%0h addr_b = 0x%0h data_b = 0x%0h",
        $time, tag, rstn, vld, addr, data, addr_a, data_a, addr_b, data_b);
  endfunction

  function void copy(Packet tmp);
    this.rstn   = tmp.rstn;
    this.vld    = tmp.vld;
    this.addr   = tmp.addr;
    this.data   = tmp.data;
    this.addr_a = tmp.addr_a;
    this.data_a = tmp.data_a;
    this.addr_b = tmp.addr_b;
    this.data_b = tmp.data_b;
  endfunction
endclass

class Packet_with_constraint extends Packet;
  // add constraint to add weightage
  constraint c_rstn {rstn dist {0:=20, 1:=80};}
  constraint c_vld  {vld  dist {0:=20, 1:=80};}
endclass
