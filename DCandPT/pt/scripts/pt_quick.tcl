##########################################################
# Quick and dirty synthesis to netlist with a few reports
#
# Framework for tcl file taken from ECE581/ECE527 documentation
#
# Written by Alexander Maso
##########################################################



lappend search_path /u/amaso/Documents/ECE527/527_Project2/DCandPT/pt/work
set target_library osu05_stdcells.db
set link_library [concat "*" $target_library]

read_file -format verilog ../netlist/$top_design.netlist
current_design $top_design
list_libs

link_design $top_design

#setting timing constraints
create_clock -period 2.81 -name clk [get_ports clk ]
#set_input_delay 0.6 -clock clk [all_inputs]
set_input_delay 0.6 -clock clk { A B Cin }
#set_clock_uncertainty 0.5 -hold [all_clocks]
#set_clock_uncertainty 0.5 -setup [all_clocks]
set_clock_uncertainty 0.5 [all_clocks]
set_clock_latency 0.2 -source [get_ports clk]
#set_load 0.5 [all_outputs]

set timing_report_unconstrained_paths "true"

#get the pins,ports
#all_registers
#get_pins

#diaplay the timing report
report_timing > ../reports/$top_design.timing.rpt
#reporting all the references(cell) in the design
report_reference > ../reports/$top_design.references.rpt

#report_area > ../reports/$top_design.area.rpt
report_cell > ../reports/$top_design.cell.rpt
report_power > ../reports/$top_design.power.rpt

#report_timing -delay_type max
#report_timing -delay_type min
