interface decode_out_if(input clock,input reset);
    logic [1:0] w_control; 
    logic mem_control;
    logic [5:0] e_control;
    logic [15:0] IR;
    logic [15:0] npc_out;
endinterface
