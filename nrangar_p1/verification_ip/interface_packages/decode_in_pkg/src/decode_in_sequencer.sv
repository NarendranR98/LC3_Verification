class decode_in_sequencer extends uvm_sequencer #(decode_in_sequence_item);
  `uvm_component_utils(decode_in_sequencer)

  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass