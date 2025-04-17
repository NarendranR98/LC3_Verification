class test_top extends uvm_test;
  `uvm_component_utils(test_top)

  uvm_sequencer #(decode_in_sequence_item) sequencer;
  decode_in_sequence sequenc;
  decode_in_driver driver;
  decode_in_agent agent;
  decode_in_configuration dconfig;

  virtual decode_in_if vif1;
  virtual decode_in_driver_bfm driver_bfm;

  function new(string name="", uvm_component parent=null);
    super.new(name, parent);  
  endfunction

  function void build_phase(uvm_phase phase);
   uvm_config_db#(decode_in_configuration)::set(null,"*","dconfig",dconfig);
    if (!uvm_config_db#(decode_in_configuration)::get(null, "", "dconfig", dconfig)) begin
      `uvm_fatal(get_full_name(), "Virtual interface must be set for: decode_in_config")
    end
    dconfig = decode_in_configuration::type_id::create("dconfig",this);
    sequenc = decode_in_sequence::type_id::create("sequenc", this);
    sequencer = decode_in_sequencer::type_id::create("sequencer", this);
    agent = decode_in_agent::type_id::create("agent",this);
  endfunction


  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this, "Objection raised by test_top");
    sequenc.start(agent.sequencer);
    phase.drop_objection(this, "Objection dropped by test_top");
  endtask
endclass
