`timescale 1ns / 10ps

module hdl_top();
  import uvm_pkg::*;
  import decode_in_pkg::*;
  `include "uvm_macros.svh"

  bit clock = 1'b0;
  initial forever #5ns clock = ~clock;

  bit reset = 1'b1; // active high reset
  initial #3ns reset = ~reset;
  
  // wire [15:0] Instr_dout;
  // wire [15:0] npc_in;
  // wire enable_decode;

  // Decode decode (
  //   .clock(clock),
  //   .reset(reset),
  //   .enable_decode(enable_decode),
  //   .dout(Instr_dout),
  //   .npc_in(npc_in)
  // );
  // Instantiate the interface
  decode_in_if vif1(.clock(clock), .reset(reset));
  decode_in_driver_bfm driver_bfm(vif1);
  decode_in_monitor_bfm monitor_bfm(vif1);

  Decode decode (
    .clock(vif1.clock),
    .reset(vif1.reset),
    .enable_decode(vif1.enable_decode),
    .dout(vif1.Instr_dout),
    .npc_in(vif1.npc_in)
  );
  
  initial begin
    // Configure the virtual interface for UVM
    uvm_config_db#(virtual decode_in_if)::set(null, "*", "vif1", vif1);
    uvm_config_db#(virtual decode_in_driver_bfm)::set(null, "*", "driver_bfm", driver_bfm);
    uvm_config_db#(virtual decode_in_monitor_bfm)::set(null, "*", "monitor_bfm", monitor_bfm);

  end
endmodule