class decode_out_transaction  extends uvm_sequence_item;
`uvm_object_utils( decode_out_transaction )

    bit [1:0] w_control;
    bit mem_control;
    bit [5:0] e_control;
    bit [15:0] IR;
    bit [15:0] npc_out;

    function new(string name = "decode_out_transaction");
        super.new( name );
    endfunction
    
    time start_time, end_time;
    int  transaction_view_h;

    virtual function string convert2string();
    return $sformatf(" W_Control: 0x%x | Mem_Control: 0x%x | E_Control: 0x%x | IR: 0x%x | npc_out: 0x%x",w_control, mem_control, e_control, IR, npc_out);
endfunction


    virtual function void add_to_wave(int transaction_viewing_stream_h);
        transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"Transaction",start_time);
        $add_attribute( transaction_view_h, w_control, "w_control" );
        $add_attribute( transaction_view_h, mem_control, "mem_control" );
        $add_attribute( transaction_view_h, e_control, "e_control" );
        $add_attribute( transaction_view_h, IR, "IR" );
        $add_attribute( transaction_view_h, npc_out, "npc_out ");
        $end_transaction(transaction_view_h,end_time);
        $free_transaction(transaction_view_h);
    endfunction

    // function bit compare( decode_out_transaction expected);
    //     if(this.IR != expected.IR || this.w_control != expected.w_control || this.mem_control != expected.mem_control || this.npc_out != expected.npc_out) begin
    //         return 0;
    //     end
    //     else begin
    //         return 1;
    //     end
    // endfunction: compare
endclass