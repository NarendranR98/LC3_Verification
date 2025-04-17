module hvl_top();
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import decode_test_pkg::*;

    initial run_test("test_top");
endmodule