module tb_top;
	event eventA; 		// Declare an event handle called  "eventA"

	initial begin
		fork
			waitForTrigger (eventA);    // Task waits for eventA to happen
			#5 ->eventA;                // Triggers eventA
		join
	end

	// The event is passed as an argument to this task. It simply waits for the event
	// to be triggered
	task waitForTrigger (event eventA);
		$display ("[%0t] Waiting for EventA to be triggered", $time);
	    //wait (eventA.triggered);
		@eventA;
		$display ("[%0t] EventA has triggered", $time);
	endtask

    event event_name;
    initial begin
        #10
        //-> event_name;
        ->>event_name; // race condition if I just used ->
        #10
        //-> event_name;
        ->>event_name; // race condition if I just used ->
    end
    always @(event_name) #1 $display($time,,"@(event_name)");
    always @(event_name.triggered)#1 $display($time,,"@(event_name.triggered)");
endmodule
