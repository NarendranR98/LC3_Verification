// decode_in_sequence_item.sv

class decode_in_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(decode_in_sequence_item)  

  time start_time, end_time;
  rand bit [15:0] Instr_dout;
  rand bit [15:0] npc_in;
  rand bit enable_decode;
  int transaction_view_h;


  constraint valid_instr { (Instr_dout[15:12] inside {4'b0000,4'b1100,4'b0001,4'b0101,4'b1001,4'b0010,4'b0110,4'b1010,4'b1110,4'b0011,4'b0111,4'b1011});}
 
  constraint npc_fixed {npc_in ==16'h3000;}
  
  constraint decode_enabled {enable_decode == 1'b1;}

  function new(string name="decode_in_sequence_item");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf("  Instr_dout: 0x%h   ||  npc_in: 0x%h    ||    enable_decode: 0x%x ", Instr_dout, npc_in, enable_decode);
  endfunction
  
  function void wave_view(int transaction_viewing_stream_h);
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"Transaction",start_time);
      $add_attribute( transaction_view_h, Instr_dout, "Instr_dout" );
      $add_attribute( transaction_view_h, npc_in, "npc_in" );
      $add_attribute( transaction_view_h, enable_decode, "enable_decode" );
      $end_transaction(transaction_view_h,end_time);
      $free_transaction(transaction_view_h);
  endfunction
  
endclass