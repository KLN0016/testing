// Sometimes we simply need to generate N random transactions to random
// locations so a generator would be useful to do just that. In this case
// loop determines how many transactions need to be sent
class generator;
  int 	loop = 100;
  event drv_done, sim_done;
  mailbox drv_mbx;



  task run();
    Packet_with_constraint item = new();

    for (int i = 0; i < loop; i++) begin
      item.randomize();
      $display ("T=%0t [Generator] Loop:%0d/%0d create next item", $time, i+1, loop);
      assert (item.rstn == 1)
        else begin
            $display ("T=%0t [Generator] Loop:%0d/%0d skipped due to failed assertion.", $time, i+1, loop);
            continue;
        end
      drv_mbx.put(item);
      $display ("T=%0t [Generator] Wait for driver to be done", $time);
      @(drv_done);
      $display ("T=%0t [Generator] driver done event triggered", $time);
    end
    #10 ->sim_done; //test transaction completed and send sim_done event
  endtask
endclass
