module bus_switching_controller (
	input logic             clk,
	input logic             rstn,
	input logic             vld,
	input logic  [8 -1:0]   addr,
	input logic  [16-1:0]   data,

	output logic [8 -1:0]   addr_a,
	output logic [16-1:0]   data_a,
	output logic [8 -1:0]   addr_b,
	output logic [16-1:0]   data_b
);

    always @(posedge clk or negedge rstn) begin
	    if (!rstn) begin
		    addr_a <= '0;
		    addr_b <= '0;
		    data_a <= '0;
		    data_b <= '0;
	    end else begin
		    if (~vld) begin
			    addr_a <= '0;
			    addr_b <= '0;
                data_a <= '0;
			    data_b <= '0;
		    end else begin
                if(addr >= 8'h00 && addr <= 8'h3F) begin
				    addr_a <= addr;
				    data_a <= data;
				    addr_b <= '0;
				    data_b <= '0;
			    end else if (addr >= 8'h40 && addr <= 8'hFF) begin
				    addr_b <= addr;
				    data_b <= data;
				    addr_a <= '0;
				    data_a <= '0;
			    end
		    end
        end
    end
endmodule
