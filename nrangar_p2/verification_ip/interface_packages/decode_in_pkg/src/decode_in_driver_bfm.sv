interface decode_in_driver_bfm(decode_in_if bus);
  task signal_op(input logic enable_decode_dbfm, input [15:0] Instr_dout_dbfm, input [15:0] npc_in_dbfm);
    wait(bus.reset == 1'b0);
    
    force bus.enable_decode = enable_decode_dbfm;
    force bus.Instr_dout = Instr_dout_dbfm;
    force bus.npc_in = npc_in_dbfm;

    @(posedge bus.clock);
    release bus.enable_decode;
    release bus.Instr_dout;
    release bus.npc_in;
    
  endtask
endinterface



