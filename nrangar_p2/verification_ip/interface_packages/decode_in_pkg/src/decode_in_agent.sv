class decode_in_agent extends uvm_agent;
  `uvm_component_utils( decode_in_agent )
    
    decode_in_configuration diconfig;
    decode_in_driver driver;
    uvm_sequencer #(decode_in_sequence_item) sequencer;
    //decode_in_sequencer sequencer;
    decode_in_monitor monitor;
    decode_in_coverage coverage;
    decode_in_sequence sequenc; 
    uvm_analysis_port #(decode_in_sequence_item) decode_in_ap;


    function new(string name="", uvm_component parent = null);
      super.new(name,parent);
      if(!uvm_config_db #(decode_in_configuration)::get(null, "uvm_test_top.env.agent", "diconfig", diconfig)) begin
      `uvm_fatal("FATAL MSG", "Configuration object is not set properly")
    end
    endfunction

    function void build_phase(uvm_phase phase);
    `uvm_info("AGENT", "decode_in_agent configured as ACTIVE", UVM_MEDIUM)
    decode_in_ap = new("decode_in_ap",this);
    monitor = new("monitor", this);
    driver = new("driver", this);
    sequencer = new("sequencer", this);
    coverage = new("coverage", this);

    endfunction

    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    monitor.monitor_bfm = diconfig.monitor_bfm;
    if(get_is_active() == UVM_ACTIVE)
    driver.seq_item_port.connect(sequencer.seq_item_export);
    monitor.ap.connect(coverage.analysis_export);
    monitor.ap.connect(decode_in_ap);
    endfunction 
    
endclass: decode_in_agent