
import decode_test_pkg::*;
class test_top extends uvm_test;
  `uvm_component_utils(test_top)

  decode_in_sequence sequenc;
  decode_env_configuration env_config;
  decode_environment env;
  
  string environment_path = "uvm_test_top.env";
  string interface_activities[2] = {"ACTIVE", "PASSIVE"};
  string interface_names[3] = {"drv_bfm_in","mon_bfm_in", "mon_bfm_out"};

  // Constructor
  function new(string name="", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    sequenc = new("sequenc");
    env = new("env", this);
    env_config = new("decode_env_config");
    env_config.initialize(environment_path, interface_names, interface_activities);
  endfunction 

  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this, "Objection raised by test_top");
    repeat (50) sequenc.start(env.agent.sequencer);
    //phase.phase_done.set_drain_time(this, 10ns);
    phase.drop_objection(this, "Objection dropped by test_top");
  endtask

endclass
