class decode_in_sequence extends uvm_sequence #(decode_in_sequence_item);
 `uvm_object_utils(decode_in_sequence)
    decode_in_sequence_item req;
    decode_in_sequence_item rsp;
    
    function new(string name="decode_in_sequence"); 
        super.new(name);
    endfunction

    task body();
      repeat (50) begin
        req = new("req");
        `uvm_info("SEQUENCE", "Requesting to send transaction to driver",UVM_DEBUG)
        start_item(req);
        if(!req.randomize()) `uvm_fatal("SEQ", "my_sequence::body()- randomization failed")
        `uvm_info("SEQUENCE", {"Sending Transaction to Driver:",req.convert2string()},UVM_DEBUG)
        finish_item(req);
        //get_response(rsp);
        //`uvm_info("SEQUENCE", {"Received Transaction from driver:",rsp.convert2string()},UVM_DEBUG)
      end
    endtask

endclass: decode_in_sequence