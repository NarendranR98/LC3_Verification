// decode_in_configuration.sv
class decode_in_configuration extends uvm_object;
`uvm_object_utils(decode_in_configuration)

  virtual decode_in_driver_bfm driver_bfm;
  virtual decode_in_monitor_bfm monitor_bfm;
  string activity;

  function new(string name = "decode_in_configuration");
    super.new(name);
  endfunction

  function void initialize(string agent_path,string interface_names[],string agent_activity);
    this.activity =  agent_activity;
   if (!uvm_config_db#(virtual decode_in_driver_bfm)::get(null,agent_path,interface_names[0], driver_bfm)) begin
      `uvm_fatal("CONFIG", "Unable to get driver_bfm from config DB")
    end
    if (!uvm_config_db#(virtual decode_in_monitor_bfm)::get(null,agent_path,interface_names[1], monitor_bfm)) begin
      `uvm_fatal("CONFIG", "Unable to get monitor_bfm from config DB")
    end
    uvm_config_db#(decode_in_configuration)::set(null,agent_path,"diconfig",this);
  endfunction

endclass

