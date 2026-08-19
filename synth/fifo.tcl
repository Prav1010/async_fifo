# Vivado out-of-context synthesis script for async_fifo
# Run from the synth/ directory:
#   vivado -mode batch -source fifo.tcl

set proj_name  "async_fifo_synth"
set part_name  "xc7a35tcpg236-1"   ;# Artix-7 (Basys3-class part) — change to match your target device
set rtl_dir    "../rtl"
set report_dir "./reports"

file mkdir $report_dir

# Read RTL sources
read_verilog -sv [glob $rtl_dir/*.v]

# Set the top module
set_property top async_fifo [current_fileset]

# Synthesize out-of-context (no I/O buffer insertion, standalone block synthesis)
synth_design -top async_fifo -part $part_name -mode out_of_context

# Generate reports
report_utilization           -file $report_dir/utilization.rpt
report_timing_summary        -file $report_dir/timing_summary.rpt
report_timing -delay_type max -max_paths 10 -file $report_dir/timing_max_paths.rpt
report_power                 -file $report_dir/power.rpt

puts "=== Synthesis complete ==="
puts "Reports written to $report_dir/"

# Write out the synthesized netlist (optional, for reference)
write_verilog -force $report_dir/async_fifo_synth.v
write_checkpoint -force $report_dir/async_fifo_post_synth.dcp