// The scoreboard is responsible to check data integrity. Since the design
// simple adds inputs to give sum and carry, scoreboard helps to check if the
// output has changed for given set of inputs based on expected logic
class scoreboard;
  mailbox scb_mbx;

  task run();
    forever begin
      Packet item, ref_item;

      $display("T=%0t [Scoreboard] run task and waiting for item", $time);

      scb_mbx.get(item);
      item.print("Scoreboard");

      // Copy contents from received packet into a new packet so
      // just to get the inputs.
      ref_item = new();
      ref_item.copy(item);

      // Model the expected data
      if (!ref_item.rstn) begin
        ref_item.addr_a <= '0;
        ref_item.data_a <= '0;
        ref_item.addr_b <= '0;
        ref_item.data_b <= '0;
      end else begin
        if (ref_item.vld) begin
          if (ref_item.addr >= 0 & ref_item.addr <= 8'h3F) begin
            ref_item.addr_a <= ref_item.addr;
            ref_item.data_a <= ref_item.data;
            ref_item.addr_b <= '0;
            ref_item.data_b <= '0;
          end else begin
            ref_item.addr_a <= '0;
            ref_item.data_a <= '0;
            ref_item.addr_b <= ref_item.addr;
            ref_item.data_b <= ref_item.data;
          end
        end
      end

      // Now, compare the output from item(actual) and ref_item(expected)
      if (ref_item.addr_a != item.addr_a) begin
        $display("T=%0t Scoreboard Error! addr_a mismatch expected=%0h actual=%0h",
            $time, ref_item.addr_a, item.addr_a);
      end else begin
        $display("T=%0t Scoreboard Pass! addr_a match expected=0x%0h actual=%0h",
            $time, ref_item.addr_a, item.addr_a);
      end

      if (ref_item.data_a != item.data_a) begin
        $display("T=%0t Scoreboard Error! data_a mismatch expected=%0h actual=%0h",
            $time, ref_item.data_a, item.data_a);
      end else begin
        $display("T=%0t Scoreboard Pass! data_a match expected=0x%0h actual=%0h",
            $time, ref_item.data_a, item.data_a);
      end

      if (ref_item.addr_b != item.addr_b) begin
        $display("T=%0t Scoreboard Error! addr_b mismatch expected=%0h actual=%0h",
            $time, ref_item.addr_b, item.addr_b);
      end else begin
        $display("T=%0t Scoreboard Pass! addr_b match expected=0x%0h actual=%0h",
            $time, ref_item.addr_b, item.addr_b);
      end

      if (ref_item.data_b != item.data_b) begin
        $display("T=%0t Scoreboard Error! data_b mismatch expected=%0h actual=%0h",
            $time, ref_item.data_b, item.data_b);
      end else begin
        $display("T=%0t Scoreboard Pass! data_b match expected=0x%0h actual=%0h",
            $time, ref_item.data_b, item.data_b);
      end
    end
  endtask
endclass
