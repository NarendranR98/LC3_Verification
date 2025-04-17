class decode_in_monitor extends uvm_monitor;
  `uvm_component_utils(decode_in_monitor)

  int transaction_viewing_stream_h;
  uvm_analysis_port #(decode_in_sequence_item) ap;
  decode_in_sequence_item transaction;
  decode_in_configuration diconfig;

  //virtual decode_in_if vif1;
  virtual decode_in_monitor_bfm monitor_bfm;
  
  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);                                                   
    super.build_phase(phase);
    ap = new("ap", this);
      if(!uvm_config_db #(decode_in_configuration)::get(null, "uvm_test_top.env.agent", "diconfig", diconfig)) begin
      `uvm_fatal("FATAL MSG", "Configuration object is not set properly")
    end
  endfunction 

  virtual function void start_of_simulation_phase(uvm_phase phase);
    transaction_viewing_stream_h = $create_transaction_stream({"..",get_full_name(),".","txn_stream"},"TVM");
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      
      transaction = new("transaction"); 
      diconfig.monitor_bfm.monitoring(transaction.enable_decode,transaction.Instr_dout,transaction.npc_in,transaction.start_time,transaction.end_time);
      transaction.wave_view(transaction_viewing_stream_h);
      `uvm_info("MONITOR", transaction.convert2string(), UVM_DEBUG);
      $display(" ");
      ap.write(transaction);
    end
  endtask
      
  
endclass