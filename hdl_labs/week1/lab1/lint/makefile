dirs := sg_design_read sg_linting sg_both

design_read: run_sg_design_read

linting: run_sg_linting

both: run_sg_both

clean:
	\rm -frd gui_command.log sg_shell_command.log mkdir
	\rm -frd sg_design_read.prj sg_linting.prj sg_both.prj
	\rm -frd sg_design_read_sum.rpt sg_linting_sum.rpt sg_both_sum.rpt
	\rm -frd sg_design_read sg_linting sg_both

create:
	$(foreach i, $(dirs), \rm -frd ${ROOT}/lint/$i)
	$(foreach i, $(dirs), \mkdir -p ${ROOT}/lint/$i)

run_sg_design_read:
	\rm -frd sg_design_read sg_design_read.prj
	mkdir sg_design_read
	${ROOT}/lint/run_lint.csh sg_design_read

run_sg_linting:
	\rm -frd sg_linting sg_linting.prj
	mkdir sg_linting
	${ROOT}/lint/run_lint.csh sg_linting

run_sg_both:
	\rm -frd sg_both sg_both.prj
	mkdir sg_both
	${ROOT}/lint/run_lint.csh sg_both
