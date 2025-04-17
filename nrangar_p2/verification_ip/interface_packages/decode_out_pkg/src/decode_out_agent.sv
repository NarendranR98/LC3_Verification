class decode_out_agent extends uvm_agent;
`uvm_component_utils( decode_out_agent )
    
    decode_out_transaction transaction;
    decode_out_monitor monitor;
    decode_out_configuration doconfig;
    uvm_analysis_port #(decode_out_transaction) decode_out_ap;

    function new(string name="", uvm_component parent = null);
        super.new(name,parent);
        if(!uvm_config_db #(decode_out_configuration)::get(null, "uvm_test_top.env.agento", "doconfig", doconfig)) begin
      `uvm_fatal("FATAL MSG", "Configuration object is not set properly")
    end
    endfunction

    function void build_phase(uvm_phase phase);
    `uvm_info("AGENT", "decode_out_agent configured as PASSIVE", UVM_MEDIUM)
    monitor = decode_out_monitor::type_id::create("monitor", this);
    decode_out_ap = new("decode_out_ap",this);
    endfunction

    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    monitor.apo.connect(decode_out_ap);
    endfunction 

endclass