interface decode_in_if(input bit clock, input bit reset);
    logic [15:0] Instr_dout;
    logic [15:0] npc_in;
    bit enable_decode;

    clocking cb@(posedge clock);
    input Instr_dout;
    input npc_in;
    input enable_decode;
  endclocking

  modport mon_mp (clocking cb);
endinterface