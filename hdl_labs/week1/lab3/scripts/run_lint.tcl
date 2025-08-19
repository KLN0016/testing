# run_lint.tcl - SpyGlass TCL script for linting

# Get the first argument passed from makefile
#set input [lindex $argv 0]
#puts "Input from run_lint.csh: $input"

# Create a project
new_project $env(MODE) -projectwdir $env(ROOT)/lint/$env(MODE) -force

# Add RTL files
set_option enableSV yes
read_file -type verilog $env(ROOT)/design/mux2to1.sv $env(ROOT)/design/mux2to1_all.sv
#read_file -type verilog $env(ROOT)/.design/mux2to1.sv $env(ROOT)/.design/mux2to1_all.sv
set_option top mux2to1_all
set_option auto_save yes

# Run basic Design Read check
if { $env(MODE) eq "sg_design_read" || $env(MODE) eq "sg_both" } {
    current_goal Design_Read
    link_design -force
}

# Run Linting check
if { $env(MODE) eq "sg_linting" || $env(MODE) eq "sg_both" } {
    current_goal lint/lint_rtl
    run_goal
}

# Generate summary report
waive -severity {Warning}
report_waiver -verbose
write_report summary > $env(MODE)_sum.rpt

# Save the project
save_project
#exit
