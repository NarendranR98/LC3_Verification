`uvm_analysis_imp_decl(_expected)
`uvm_analysis_imp_decl(_actual)
class decode_scoreboard extends uvm_component;
	`uvm_component_utils(decode_scoreboard)

	uvm_analysis_imp_expected#(decode_out_transaction, decode_scoreboard) expected;
	uvm_analysis_imp_actual#(decode_out_transaction, decode_scoreboard) actual;

	decode_out_transaction expected_results[$];
	decode_out_transaction actual_transaction;
	decode_out_transaction expected_transaction;
	int transaction_count,actual_transaction_count;
	int match,mismatch;

	function new(string name="", uvm_component parent=null);
	    super.new(name, parent);
    endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		expected = new("expected", this);
		actual = new("actual", this);
	endfunction

	// Process actual transaction and compare with expected
	virtual function void write_actual(decode_out_transaction t);
		actual_transaction = t;
        actual_transaction_count++;
		//`uvm_info("ACTUAL TRANSACTION", $sformatf("ACTUAL: %s", actual_transaction.convert2string()), UVM_MEDIUM)
	endfunction

	// Store expected transaction
	function void write_expected(decode_out_transaction t);
		expected_results.push_back(t);
		transaction_count++;
	endfunction

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			wait(expected_results.size()!=0 && actual_transaction!=null);
			expected_transaction = expected_results.pop_front();
			`uvm_info(get_full_name(), $sformatf("EXPECTED: %s", expected_transaction.convert2string()), UVM_MEDIUM)
			`uvm_info(get_full_name(), $sformatf("ACTUAL: %s", actual_transaction.convert2string()), UVM_MEDIUM)
			if(actual_transaction.compare(expected_transaction)) begin
				`uvm_info("SCOREBOARD", "TRANSACTION MATCH", UVM_MEDIUM)
				$display("");
				match++;
			end
			else begin
				mismatch++;
				`uvm_info("SCOREBOARD", "TRANSACTION MISMATCH", UVM_MEDIUM)
				$display("");
			end
		end
	endtask: run_phase

	// Report summary at the end of the test
	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		$display("----------------------------------------------------------------------------------------");
		`uvm_info(get_full_name(), $sformatf("EXPECTED TRANSACTIONS:         %0d", transaction_count), UVM_MEDIUM)
		`uvm_info(get_full_name(), $sformatf("ACTUAL TRANSACTIONS:           %0d", transaction_count), UVM_MEDIUM)
		`uvm_info(get_full_name(), $sformatf("MATCHED TRANSACTIONS:          %0d", match), UVM_MEDIUM)
		`uvm_info(get_full_name(), $sformatf("MISMATCHED TRANSACTIONS:       %0d", mismatch), UVM_MEDIUM)
	endfunction

endclass
