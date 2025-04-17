class decode_in_monitor extends uvm_monitor;

    `uvm_component_utils(decode_in_monitor)

    uvm_analysis_port #(decode_in_sequence_item) ap;
    decode_in_sequence_item transaction;
    decode_in_configuration configuration;
    int enable_transaction_viewing;
    // monitor_bfm
    //virtual decode_in_monitor_bfm monitor_bfm;

    // Storing timestamps
    protected time time_stamp = 0;
    
    // Handle for transaction viewing
    int transaction_viewing_stream_h;

    function new(string name="", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        ap = new("ap", this);
        set_bfm_proxy_handle();
        //configuration = decode_in_configuration::type_id::create("configuration", this);
    endfunction

    virtual function void set_bfm_proxy_handle();
        configuration.monitor_bfm.proxy = this;
    endfunction


    virtual task run_phase(uvm_phase phase);
    super.run_phase(phase); 
        // Ensure proper UVM phase handling
        ->configuration.monitor_bfm.go;
        @(posedge configuration.monitor_bfm.bus.clock) begin
            wait(configuration.monitor_bfm.bus.reset==1'b0);
        time_stamp = $time;
        end
    endtask

    virtual function void notify_transaction(
    input bit [15:0] Instr_dout,
    input bit [15:0] npc_in,
    input bit enable_decode
  );
    
    transaction = decode_in_sequence_item::type_id::create("transaction");
    transaction.start_time = time_stamp;
    transaction.end_time = $time;
    time_stamp=transaction.end_time;
    transaction.Instr_dout=Instr_dout;
    transaction.npc_in=npc_in;
    transaction.enable_decode=enable_decode;  
    analyze(transaction);
  endfunction
        // transaction = decode_in_sequence_item::type_id::create("transaction");
        // // Start the monitoring and capture the start and end times
        // configuration.monitor_bfm.monitoring(transaction.Instr_dout, transaction.npc_in, transaction.enable_decode,transaction.start_time,transaction.end_time);
        // transaction.wave_view(transaction_viewing_stream_h);
        // `uvm_info("MONITOR", transaction.convert2string(), UVM_MEDIUM);
        // ap.write(transaction);
        // Analyze the transaction
        //analyze(trans);


    // virtual function void set_bfm_proxy_handle();
    //     monitor_bfm.proxy = this;
    // endfunction

    protected virtual function void analyze(decode_in_sequence_item t);
        if (configuration.enable_transaction_viewing ==1) begin
        `uvm_info("MONITOR", t.convert2string(), UVM_MEDIUM);
        $display("\n");
       t.wave_view(transaction_viewing_stream_h);
     ap.write(t);
        end
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        if(configuration.enable_transaction_viewing == 1)
            transaction_viewing_stream_h = $create_transaction_stream({"..", get_full_name(), ".", "txn_stream"});
    endfunction

    

endclass
