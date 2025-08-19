#!/bin/csh

# Check to ensure at least 1 input
if (($#argv == 0) || ($1 == "")) then
    echo "Usage: $0 <design_read|linting|both>"
    exit 1
endif

# Check to ensure the valid 1 input
if (($1 != "sg_design_read") && ($1 != "sg_linting") && ($1 != "sg_both")) then
    echo "Usage: $0 <design_read|linting|both>"
    exit 1
endif

# Run
setenv MODE $1
echo "[==== INFO ====] Running SpyGlass TCL script: $0 $1"
echo "[==== INFO ====] Run MODE: $MODE"
spyglass -shell -tcl $ROOT/scripts/run_lint.tcl
