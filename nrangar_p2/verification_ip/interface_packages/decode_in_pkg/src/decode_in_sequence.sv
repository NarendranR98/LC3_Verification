class decode_in_sequence extends uvm_sequence#(decode_in_sequence_item);
  `uvm_object_utils(decode_in_sequence)

      decode_in_sequence_item req;
      decode_in_sequence_item rsp;

      function new(string name=""); 
        super.new(name);
      endfunction

      virtual task body();
      req = new("req");
        `uvm_info("SEQUENCE", "Requesting to send transaction to driver",UVM_DEBUG)
      start_item(req);
      // Randomize the transaction
      if(!req.randomize()) `uvm_fatal("SEQ", "my_sequence::body()- randomization failed")
        `uvm_info("SEQUENCE", {"Sending:",req.convert2string()},UVM_DEBUG)
      finish_item(req);
      get_response(rsp);
        `uvm_info("SEQUENCE", {"Received:",rsp.convert2string()},UVM_DEBUG)
      endtask

  endclass 