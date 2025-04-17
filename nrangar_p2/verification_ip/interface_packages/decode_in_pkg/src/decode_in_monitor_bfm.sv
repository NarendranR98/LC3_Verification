interface decode_in_monitor_bfm(decode_in_if bus);
task monitoring(output logic mbfm_enable_decode, output [15:0] mbfm_Instr_dout, output [15:0] mbfm_npc_in, output time start_time, output time end_time);
    start_time = $time;
    force mbfm_enable_decode = bus.enable_decode;
    force mbfm_Instr_dout = bus.Instr_dout ;
    force mbfm_npc_in = bus.npc_in;
    @(posedge bus.clock);
    if (bus.reset == 1'b0) begin
        release mbfm_enable_decode;
        release mbfm_Instr_dout;
        release mbfm_npc_in;
        end_time = $time;
    end
endtask
endinterface