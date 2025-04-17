class decode_in_configuration extends uvm_object;
    `uvm_object_utils(decode_in_configuration)
    
    virtual decode_in_if vif1;
    virtual decode_in_driver_bfm.mon_mp driver_bfm;
    virtual decode_in_monitor_bfm.mon_ap monitor_bfm;
    int enable_transaction_viewing=1;
    
    function new(string name = "decode_in_configuration");
        super.new(name);
        if(!uvm_config_db#(virtual decode_in_if)::get(null, "uvm_test_top", "vif1", vif1)) begin
      `uvm_fatal(get_full_name(),{"virtual interface must be set for:","decode_in_f"})
    end
        if(!uvm_config_db#(virtual decode_in_driver_bfm)::get(null, "uvm_test_top", "driver_bfm", driver_bfm)) begin
      `uvm_fatal(get_full_name(),{"virtual interface must be set for:","decode_in_driver_bfm"})
    end
        if(!uvm_config_db#(virtual decode_in_monitor_bfm)::get(null, "uvm_test_top", "monitor_bfm", monitor_bfm)) begin
      `uvm_fatal(get_full_name(),{"virtual interface must be set for:","decode_in_monitor_bfm"})
    end

    endfunction
endclass