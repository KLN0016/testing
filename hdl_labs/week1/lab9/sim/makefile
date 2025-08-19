dv: clean run_dv

clean:
	\rm -frd novas* mkdir csrc
	\rm -frd ${MODULE}_comp.log ${MODULE}_sim.log ${MODULE}_sim.rpt ${MODULE}_simv ${MODULE}_sim.vcd ${MODULE}_sim.fsdb ${MODULE}_simv.daidir ${MODULE}_ana.log
	\rm -frd ${MODULE}_sim.vcd.vpd
	\rm -frd ucli.key worklib debug.report
	\rm -frd DVEfiles dve_report.* opendatabase.log
	\rm -frd verdiLog inter.fsdb
	\rm -frd seed* sysBusyP*

run_dv:
	${ROOT}/sim/run_sim.csh dv ${MODULE}

NUM_TEST 		= 100
REPORT_FILENAME	= adder_tb.rpt
SEED			= 300
run:
	vcs -debug_acess+all \
		-kdb \
		-l adder_tb.log \
		-R \
		-sverilog \
		+number_of_tests=${NUM_TEST} \
		+report_file=${REPORT_FILENAME} \
		+seed=${SEED} \
		../design/adder.sv \
		../design/adder_tb.sv

