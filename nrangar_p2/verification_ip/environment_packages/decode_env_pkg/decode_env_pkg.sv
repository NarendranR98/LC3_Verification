package decode_env_pkg;

  import uvm_pkg::*;      
  import decode_in_pkg::*;
  import decode_out_pkg::*;
  `include "uvm_macros.svh"   
  `include "src/lc3_prediction_typedefs.svh"
  `include "src/decode_model.svh"                
  `include "src/decode_predictor.svh"
  `include "src/decode_scoreboard.svh"
  `include "src/decode_environment.svh"
  `include "src/decode_env_configuration.svh"

endpackage