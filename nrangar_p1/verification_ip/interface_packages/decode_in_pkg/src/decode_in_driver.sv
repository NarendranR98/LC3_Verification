class decode_in_driver extends uvm_driver #(decode_in_sequence_item);
`uvm_component_utils( decode_in_driver )

  decode_in_sequence_item req;
  decode_in_sequence_item rsp;
  virtual decode_in_if.mon_mp vif1;
  virtual decode_in_driver_bfm.mon_mp driver_bfm;


  function new(string name="", uvm_component parent = null); 
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    if (!uvm_config_db#(virtual decode_in_driver_bfm)::get(null, "", "driver_bfm", driver_bfm)) begin
      `uvm_fatal(get_full_name(), "Virtual interface must be set for: decode_in_driver_bfm")
        end
  endfunction

  task run_phase(uvm_phase phase);
    forever
      begin : forever_loop
        `uvm_info("DRIVER", "Requesting a transaction from the sequencer",UVM_DEBUG)
        seq_item_port.get_next_item(req);
        `uvm_info("DRIVER", {"Received:",req.convert2string()},UVM_MEDIUM)
        driver_bfm.signal_op(req.Instr_dout,req.npc_in,req.enable_decode); 
        // rsp = new("rsp");
        // rsp.set_id_info(req);
        // `uvm_info("DRIVER", "Sending transaction back to sequence through sequencer",UVM_DEBUG);
        seq_item_port.item_done(rsp);
      end 
  endtask

endclass