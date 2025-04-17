
.PHONY: p2_debug clean

p2_debug:
	qrun -64 -gui -visualizer -onfinish stop -classdebug -uvmcontrol=all -msgmode both -l run.log -f filelist.f -do "set NoQuitOnFinish 1;onbreak {resume}; run -all; do waves.do; coverage save test_top.ucdb;" +UVM_TESTNAME=test_top +UVM_VERBOSITY=UVM_HIGH -debug,livesim -qwavedb=+transaction+signal+memory=1024+report+parameter+class+assertion+uvm_schematic+msg+classmemory=1024+statictaskfunc -top hdl_top -top hvl_top

clean:
	rm certe_dump.xml
	rm design.bin
	rm -rf qrun.out
	rm -rf .visualizer
	rm qwave.db
	rm *.log
	rm -rf work
	rm *.ucdb

