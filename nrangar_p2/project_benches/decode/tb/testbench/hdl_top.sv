`timescale 1ns / 10ps

module hdl_top();
  import uvm_pkg::*;
  import decode_in_pkg::*;
  import decode_out_pkg::*;
  `include "uvm_macros.svh"

bit clock;
  initial clock = 1'b0;
  
  bit reset;
  initial reset = 1'b1;
  
  initial
    begin
      #20ns reset = ~reset;
      forever #5ns clock = ~clock;
    end

    decode_in_if vif1(.clock(clock),.reset(reset));
    decode_out_if vof1(.clock(clock),.reset(reset));

  Decode Decode (
        .clock(clock),
        .reset(reset),
        .enable_decode(vif1.enable_decode),
        .dout(vif1.Instr_dout),
        .npc_in(vif1.npc_in),
        .W_Control(vof1.w_control),
        .Mem_Control(vof1.mem_control),
        .E_Control(vof1.e_control),
        .IR(vof1.IR),
        .npc_out(vof1.npc_out)
    );

  decode_in_driver_bfm driver_bfm(vif1);
  decode_in_monitor_bfm monitor_bfm(vif1);

  decode_out_monitor_bfm dout_monitor_bfm(vof1);
  
  initial begin
  uvm_config_db#(virtual decode_in_driver_bfm)::set(null, "uvm_test_top.env.agent", "drv_bfm_in", driver_bfm);
  uvm_config_db#(virtual decode_in_monitor_bfm)::set(null, "uvm_test_top.env.agent", "mon_bfm_in", monitor_bfm);

  uvm_config_db#(virtual decode_out_monitor_bfm)::set(null, "uvm_test_top.env.agento", "mon_bfm_out", dout_monitor_bfm);
  end

endmodule

