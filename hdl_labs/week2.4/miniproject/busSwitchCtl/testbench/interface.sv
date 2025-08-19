interface bus_if #(
  parameter ADDR_WIDTH = 8,
  parameter DATA_WIDTH = 16
) (
  input logic            clk
);
  logic                  rstn;
  logic                  vld;
  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data;

  logic [ADDR_WIDTH-1:0] addr_a;
  logic [DATA_WIDTH-1:0] data_a;
  logic [ADDR_WIDTH-1:0] addr_b;
  logic [DATA_WIDTH-1:0] data_b;
endinterface
