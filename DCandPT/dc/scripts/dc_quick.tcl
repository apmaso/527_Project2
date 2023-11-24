##########################################################
# Quick and dirty synthesis to netlist with a few reports
#
# Framework for tcl file taken from ECE581 documentation
#
# Written by Alexander Maso
##########################################################



lappend search_path /u/amaso/Documents/ECE527/527_Project2/DCandPT/syn/work
set target_library osu05_stdcells.db
set link_library [concat "*" $target_library]

read_file -format sverilog ../rtl/$top_design.sv
current_design $top_design 
link

#setting timing constraints
create_clock -period 2.36 -name clk [get_ports clk ]
set_input_delay 0.6 -clock clk [remove_from_collection [all_inputs] clk]
#set_input_delay 0.6 -clock clk { A B Cin } 
set_clock_uncertainty 0.5 -hold [all_clocks]
set_clock_uncertainty 0.5 -setup [all_clocks]
set_clock_latency 0.2 -source [get_ports clk]


#compile the design to obtain gate level netlist
compile -ungroup_all
#diaplay the timing report
report_timing
report_timing > ../reports/$top_design.timing.rpt
#reporting all the references(cell) in the design
report_reference
report_reference > ../reports/$top_design.references.rpt

#report_area > ../reports/$top_design.area.rpt
#report_cell > ../reports/$top_design.cell.rpt
#report_power > ../reports/$top_design.power.rpt
#report_timing -delay_type max > ../reports/$top_design.timing.rpt
#report_timing -delay_type min >> ../reports/$top_design.timing.rpt
write -format verilog -hierarchy -output ../outputs/$top_design.netlist
