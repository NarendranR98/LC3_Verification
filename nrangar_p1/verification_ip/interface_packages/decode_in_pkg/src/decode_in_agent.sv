class decode_in_agent extends uvm_agent;
  `uvm_component_utils( decode_in_agent )
    
    decode_in_configuration configuration;
    decode_in_monitor monitor;
    decode_in_driver driver;
    decode_in_sequencer sequencer;
    decode_in_sequence sequenc;
    decode_in_coverage coverage;

    function new(string name="", uvm_component parent = null);
      super.new(name,parent);
      // if (!uvm_config_db#(virtual decode_in_driver_bfm)::get(null, "uvm_test_top", "driver_bfm", driver_bfm)) begin
      // `uvm_fatal(get_full_name(), "Virtual interface must be set for: decode_in_driver_bfm")
      //   end
    //   if(!uvm_config_db#(decode_in_configuration)::get(null, "*", "dconfig", dconfig)) begin
    //   `uvm_fatal(get_full_name(),{"virtual interface must be set for:configuration"})
    // end
    endfunction
    
    function void build_phase(uvm_phase phase);
    `uvm_info("AGENT", "decode_in_agent configured as ACTIVE", UVM_MEDIUM)
    configuration = decode_in_configuration::type_id::create("configuration",this);
    monitor = decode_in_monitor::type_id::create("monitor",this);
    monitor.configuration = configuration;
    coverage = decode_in_coverage::type_id::create("coverage",this);
    driver = decode_in_driver::type_id::create("driver", this);
    sequencer = decode_in_sequencer::type_id::create("sequencer", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(get_is_active())
        driver.seq_item_port.connect(sequencer.seq_item_export);
        monitor.ap.connect(coverage.analysis_export);
    endfunction 


endclass: decode_in_agent