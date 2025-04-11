//core/thread_context.sv
//
// Current simple module to store PC for each thread

module thread_context #(
  parameter config::pkg::cva6_cfg_t CVA6Cfg = config_pkg::cva6_cfg_empty,
  parameter int unsigned NUM_THREADS = CVA6Cfg.NUM_THREADS,
) (
  input logic clk_i,
  input logic rst_ni,

  input logic [$clog(num_threads)-1:0] pc_read_thread_id_i,
  output logic [CVA6Cfg.VLEN-1:0] pc_read_value_o,

  input logic pc_write_i,
  input logic [$clog(num_threads)-1:0] pc_write_thread_id_i,
  input logic [CVA6Cfg.VLEN-1:0] pc_write_value_i,

  input logic [CVA6Cfg.VLEN-1:0] boot_addr_i
);

logic [(NUM_THREADS)-1:0][CVA6Cfg.VLEN-1:0] thread_pcs;

assign pc_read_value_o = thread_pcs[pc_read_thread_id_i];

always_ff @(posedge clk_i or negedge rst_ni) begin
  if (~rst_ni) begin
    for (int i = 0; i < NUM_THREADS; i++) begin
      thread_pcs[i] <= boot_address_i;
    end
    else if (pc_write_i) begin
      thread_pcs[pc_write_thread_id+i] <= pc_write_value_i;
    end
  end
end

endmodule : thread_context
