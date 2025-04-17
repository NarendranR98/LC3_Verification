add wave -noupdate -expand /hdl_top/vif1/clock
add wave -noupdate -expand /hdl_top/vif1/reset
add wave -noupdate  /hdl_top/vif1/npc_in
add wave -noupdate  /hdl_top/vif1/enable_decode
add wave -noupdate  /hdl_top/vif1/Instr_dout
add wave -group Transaction decode_in_pkg...uvm_test_top.agent.monitor.txn_stream -expand
