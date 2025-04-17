// decode_in_configuration.sv
class decode_out_configuration extends uvm_object;
`uvm_object_utils(decode_out_configuration)

virtual decode_out_monitor_bfm dout_monitor_bfm;
string activity;

  function new(string name = "decode_out_configuration");
    super.new(name);
  endfunction

  function void initialize(string agent_path,string interface_names[],string agent_activity);
    this.activity =  agent_activity;

    if (!uvm_config_db#(virtual decode_out_monitor_bfm)::get(null,agent_path,interface_names[2], dout_monitor_bfm)) begin
      `uvm_fatal("CONFIG", "Unable to get monitor_bfm from config DB")
    end
    uvm_config_db#(decode_out_configuration)::set(null,agent_path,"doconfig",this);
  endfunction

  //  virtual function void initialize(string name, string path_to_agent);

  //     //uvm_config_db#(decode_in_configuration)::set(null, path_to_agent,"decode_cfgrn",this);
  //     uvm_config_db#(decode_in_configuration)::set(null, "uvm_test_top.env.agent","decode_config",this);
  //     uvm_config_db#(virtual decode_in_monitor_bfm)::get(null, "uvm_test_top.dinconfig.monitor_bfm", bfm_monitor);
  //     uvm_config_db#(virtual decode_in_driver_bfm)::get(null, "uvm_test_top.dinconfig.driver_bfm", bfm_driver);
  //  endfunction

  // Function to print configuration details
  function void print_config();
    `uvm_info("CONFIG", $sformatf("monitor_bfm: %p", dout_monitor_bfm), UVM_LOW)
  endfunction

endclass

