class decode_out_monitor extends uvm_monitor;
`uvm_component_utils(decode_out_monitor)

    int transaction_viewing_stream_h;
    uvm_analysis_port #(decode_out_transaction) apo;
    decode_out_transaction transaction;
    decode_out_configuration doconfig; 

    //virtual decode_out_if vof1;
    virtual decode_out_monitor_bfm dout_monitor_bfm;

    function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);                                                   
    super.build_phase(phase);
    apo = new("apo", this);
    if(!uvm_config_db #(decode_out_configuration)::get(null, "uvm_test_top.env.agento", "doconfig", doconfig)) begin
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
        doconfig.dout_monitor_bfm.monitored(transaction.w_control,transaction.mem_control,transaction.e_control,transaction.IR,transaction.npc_out,transaction.start_time,transaction.end_time);
        transaction.add_to_wave(transaction_viewing_stream_h);
        `uvm_info("MONITOR OUT", transaction.convert2string(), UVM_DEBUG);
        //$display(" ");
        apo.write(transaction);
    end
endtask



endclass