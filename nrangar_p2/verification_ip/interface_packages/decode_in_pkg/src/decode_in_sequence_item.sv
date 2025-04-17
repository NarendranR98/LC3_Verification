class decode_in_sequence_item extends uvm_sequence_item;

  rand bit [15:0] Instr_dout;
  rand bit [15:0] npc_in;
  rand bit enable_decode;

  constraint valid_instr { (Instr_dout[15:12] inside {4'b0000,4'b1100,4'b0001,4'b0101,4'b1001,4'b0010,4'b0110,4'b1010,4'b1110,4'b0011,4'b0111,4'b1011});}
  
  //constraint npc_fixed {npc_in ==16'h3000;}
  
  constraint decode_enabled {enable_decode == 1'b1;}

  time start_time, end_time;
  int  transaction_view_h;

      function new(string name=""); 
        super.new(name);
      endfunction

    virtual function string convert2string();
      return $sformatf("enable_decode:0x%x Instr_dout:0x%x  npc_in:0x%x",enable_decode,Instr_dout,npc_in);
    endfunction

    virtual function void wave_view(int transaction_viewing_stream_h);
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"transaction",start_time);
      $add_attribute(transaction_view_h,enable_decode,"enable_decode");
      $add_attribute(transaction_view_h,Instr_dout,"Instr_dout");
      $add_attribute(transaction_view_h,npc_in,"npc_in");
      $end_transaction(transaction_view_h,end_time);
      $free_transaction(transaction_view_h);
    endfunction

  endclass