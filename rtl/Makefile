TOP  ?= ha
SEED ?= $(shell echo $$RANDOM)

test:
	@echo ${SEED}

VCS_OPT = 	-full64 \
			-sverilog \
			-kdb \
			-debug_access+all \
		  	-cm line+cond+tgl+fsm+branch+assert

RUN_OPT = +ntb_random_seed=${SEED} \
		  -cm line+cond+tgl+fsm+branch+assert

clean_sim:
	rm -rf csrc *log* simv* ucli.key verdiLog waveform.fsdb novas*
	rm -rf evaluate_result.fsdb* vdCov*

build: clean_sim
	vcs ${VCS_OPT} ${TOP}/${TOP}.sv ${TOP}/${TOP}_tb.sv -l ${TOP}_tb_build.log

run:
	./simv ${RUN_OPT} -l ${TOP}_tb_sim.log

all: build run

elab: clean_sim
	vcs ${VCS_OPT} ${TOP}/${TOP}.sv
	verdi -dbdir simv.daidir &

fsdb:
	verdi -ssf waveform.fsdb &

#To generate coverage reports and analyze the results
#using Unified Report Generator
urgcov:
	urg -dir simv.vdb

# using Verdi Coverage GUI
verdicov:
	verdi -cov -covdir simv.vdb &


# Dummy target to absorb extra argument
%:
	@true
