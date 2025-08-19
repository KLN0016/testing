class Packet;
  rand bit [3:0] queue [$]; // Declare a unbounded queue with "rand"

  // Constrain size of queue to 4
  constraint c_array { queue.size() <= 4; }


endclass

module tb;
  Packet pkt;

  // Create a new packet, randomize it and display contents
  initial begin
    pkt = new();

    for (int i=0;i<5;i++) begin
        pkt.randomize();

        // Tip : Use %p to display arrays
        $display("queue = %p", pkt.queue);
    end
  end
endmodule
