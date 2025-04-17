class decode_in_coverage extends uvm_subscriber #(decode_in_sequence_item);
   `uvm_component_utils( decode_in_coverage )

   bit [15:0] Instr_dout;

    covergroup my_sequence_cg;
      coverpoint Instr_dout[15:12]{
        bins add_op = {4'b0001};
        bins and_op = {4'b0101};
        bins not_op = {4'b1001};
        bins ld_op = {4'b0010};
        bins ldr_op = {4'b0110};
        bins ldi_op = {4'b1010};
        bins lea_op = {4'b1110};
        bins st_op = {4'b0011};
        bins str_op = {4'b0111};
        bins sti_op = {4'b1011};
        bins br_op = {4'b0000};
        bins jmp_op = {4'b1100};
      }
    endgroup

    function new(string name="", uvm_component parent = null); 
      super.new(name,parent);
      my_sequence_cg=new;
    endfunction

    virtual function void write(decode_in_sequence_item t);
      Instr_dout=t.Instr_dout;
      my_sequence_cg.sample();
    endfunction 
  endclass
