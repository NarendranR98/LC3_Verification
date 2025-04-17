import decode_in_pkg::*;
interface decode_in_driver_bfm(decode_in_if bus);
  task signal_op(input [15:0] Instr_dout, input [15:0] npc_in, input enable_decode);
    @(posedge bus.clock);
    bus.Instr_dout = Instr_dout;
    bus.npc_in = npc_in;
    bus.enable_decode = enable_decode;
    //$display("Instr_dout: 0x%x npc_in: 0x%x enable_decode: 0x%x", bus.Instr_dout, bus.npc_in, bus.enable_decode);
  endtask
endinterface