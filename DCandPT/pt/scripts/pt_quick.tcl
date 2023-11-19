##########################################################
# Quick and dirty synthesis to netlist with a few reports
#
# Framework for tcl file taken from ECE581/ECE527 documentation
#
# Written by Alexander Maso
##########################################################


#source -echo -verbose ../../$top_design.design_config.tcl

lappend search_path /u/amaso/Documents/ECE527/527_Project2/DCandPT/pt/work
set target_library osu05_stdcells.db
set link_library [concat "*" $target_library]

read_file -format verilog ../netlist/$top_design.netlist
current_design $top_design
list_libs

link_design $top_design

# Set up our clock
create_clock -name clk -period 10 [get_ports clk]
set_clock_uncertainty 0.5 [all_clocks]
set_clock_latency 0.5 [get_ports clk]

report_timing -delay_type max > ../reports/$top_design.timing.rpt
report_timing -delay_type min >> ../reports/$top_design.timing.rpt
