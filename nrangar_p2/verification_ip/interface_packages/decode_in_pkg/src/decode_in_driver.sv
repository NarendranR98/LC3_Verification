class decode_in_driver extends uvm_driver #(decode_in_sequence_item);
  `uvm_component_utils(decode_in_driver)
      decode_in_sequence_item req;
      decode_in_sequence_item rsp;
      //virtual decode_in_if vif1;
      virtual decode_in_driver_bfm driver_bfm; 
      decode_in_configuration diconfig;
  
      function new(string name="", uvm_component parent = null); 
        super.new(name,parent);
      endfunction
      
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(decode_in_configuration)::get(null, "uvm_test_top.env.agent", "diconfig", diconfig)) begin
      `uvm_fatal("FATAL MSG", "Configuration object is not set properly")
    end
  endfunction

    virtual task run_phase(uvm_phase phase);
    forever
        begin : forever_loop
          seq_item_port.get_next_item(req);
          `uvm_info("DRIVER", {"Received:",req.convert2string()},UVM_DEBUG) 
          diconfig.driver_bfm.signal_op(req.enable_decode,req.Instr_dout,req.npc_in);
          `uvm_info("DRIVER",req.convert2string(),UVM_DEBUG)
          rsp = new("rsp");
          rsp.set_id_info(req);
          seq_item_port.item_done(req);
        end 
    endtask
  endclass