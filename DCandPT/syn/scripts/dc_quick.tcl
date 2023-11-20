##########################################################
# Quick and dirty synthesis to netlist with a few reports
#
# Framework for tcl file taken from ECE581 documentation
#
# Written by Alexander Maso
##########################################################


source -echo -verbose ../../$top_design.design_config.tcl

lappend search_path /u/amaso/Documents/ECE527/527_Project2/DCandPT/syn/work
set target_library osu05_stdcells.db
set link_library [concat "*" $target_library]
link

read_file -format sverilog ../rtl/$top_design.sv
current_design four_bit_select_adder
compile -ungroup_all
report_area > ../reports/$top_design.area.rpt
report_cell > ../reports/$top_design.cell.rpt
report_power > ../reports/$top_design.power.rpt
report_timing -delay_type max > ../reports/$top_design.timing.rpt
report_timing -delay_type min >> ../reports/$top_design.timing.rpt
write -format verilog -hierarchy -output ../outputs/$top_design.netlist
link


