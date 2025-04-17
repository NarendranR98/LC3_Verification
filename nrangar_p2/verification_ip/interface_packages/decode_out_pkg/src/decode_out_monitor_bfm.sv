interface decode_out_monitor_bfm(decode_out_if bus);
task monitored(output w_control, output mem_control, output [5:0] e_control, output [15:0] IR, output [15:0] npc_out, output time start_time, output time end_time);
    start_time = $time;
    force w_control = bus.w_control;
    force mem_control = bus.mem_control ;
    force e_control = bus.e_control;
    force IR = bus.IR;
    force npc_out = bus.npc_out;
    @(posedge bus.clock);
    if (bus.reset == 1'b0) begin
        // Capture the signals from the interface `bus` directly
        release w_control;
        release mem_control;
        release e_control;
        release IR;
        release npc_out;
        end_time = $time;
        //$display("[%0t] Monitoring - enable_decode: 0x%0h, Instr_dout: 0x%0h, npc_in: 0x%0h",$time, mbfm_enable_decode, mbfm_Instr_dout, mbfm_npc_in);
    end
endtask
endinterface