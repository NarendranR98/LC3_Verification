//import lc3_prediction_pkg::*;
class decode_predictor extends uvm_subscriber #(decode_in_sequence_item);
`uvm_component_utils(decode_predictor)

    uvm_analysis_port #(decode_out_transaction) predictor_ap;

    decode_out_transaction ptrans;
    decode_in_sequence_item intrans;
    function new(string name = "decode_predictor", uvm_component parent = null);
        super.new(name, parent);
        predictor_ap=new("predictor_ap",this);
        endfunction

  virtual function void write(decode_in_sequence_item t);
    intrans = t;
    ptrans  = decode_out_transaction::type_id::create("ptrans");
    decode_model(intrans.Instr_dout, intrans.npc_in, ptrans.IR, ptrans.npc_out, ptrans.e_control, ptrans.w_control, ptrans.mem_control);
    predictor_ap.write(ptrans);  
    //`uvm_info("PREDICTOR",ptrans.convert2string(), UVM_MEDIUM);
  endfunction
endclass