#---------------------------------------------------------------------------

TOOL_CMD	= vcs -full64
COMP_OPT	= -sverilog -debug_access+all -fsdb +define+FSDB -timescale=1ns/1ps 
UVM_OPT		= -ntb_opts uvm-1.2

test: clean comp run 

all: clean comp run verdi

comp:
	$(TOOL_CMD) $(COMP_OPT) $(UVM_OPT) -f filelist.f
run:
	./simv -l simv.log 

run_t0:
	./simv +UVM_TESTNAME=my_case0 -l simv.log 
run_t1:
	./simv +UVM_TESTNAME=my_case1 -l simv.log

rung:
	./simv +UVM_NO_RELNOTES -gui=verdi

verdi:
	verdi -sverilog -f filelist.f -ssf *.fsdb $(UVM_OPT) -nologo 

clean:
	rm -rf csrc simv simv.daidir *.fsdb novas.* ucli.key DVEfiles
	rm -rf *.log* *.vpd *.h urgReport verdiLog

dve: 
	dve -full64 &