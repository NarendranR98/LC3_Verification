



interface decode_in_monitor_bfm(decode_in_if  bus);
  bit [15:0] Instr_dout;
  bit [15:0] npc_in;
  bit enable_decode;
  event go;
  
  decode_in_pkg::decode_in_monitor proxy;
  
  initial begin
    @go;
    forever begin 
      @(posedge bus.clock); 
        monitoring(
                Instr_dout,
                npc_in,
                enable_decode
            );
        proxy.notify_transaction(
                Instr_dout,
                npc_in,
                enable_decode
            );
    end
  end

  task monitoring(output bit [15:0] Instr_dout, output bit [15:0] npc_in, output bit enable_decode);
    if (bus.reset == 1'b0) begin
      Instr_dout = bus.Instr_dout;
      npc_in = bus.npc_in;
      enable_decode = bus.enable_decode;
    end
  endtask 
endinterface
