class myClass;
	rand bit [3:0] val;
	rand bit [3:0] val1;
	constraint  c1 { val > 3;
	                 val < 12; }

	constraint  c2  {val >= 10; }
endclass

module tb;
	initial begin
		for (int i = 0; i < 10; i++) begin
			myClass cls = new ();
            cls.c1.constraint_mode(0);
            // cls.c2.constraint_mode(0);
            cls.val.rand_mode(0);
            cls.val1.rand_mode(0);
			cls.randomize();
			$display ("itr=%0d val=%0d", i, cls.val);
			$display ("itr=%0d val1=%0d", i, cls.val1);
		end
	end
endmodule

//Constraint blocks are not executed from top to bottom like procedural code,
//but are all active at the same time.
//
//Note that constraints c1 and c2 limits the val values to 10 and 11.
//
