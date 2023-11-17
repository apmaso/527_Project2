# Framework for tcl file taken from ECE581 documentation
# as well as from the source material for ECE530
#
#
# Written by Alexander Maso

# List all current designs
set this_design [ list_designs ]

# If there are existing designs reset/remove them
if { $this_design != 0 } {
  # To reset the earlier designs
  reset_design
  remove_design -designs
}

if { ! [ info exists top_design ] } {
   set top_design four_bit_select
}

# Source config file for design
source -echo -verbose ./$top_design.design_config.tcl

# Everything in lines 10 - 30 from 530 files
# TODO: Need to look these commands up in man pages
# Analyzing the files for the design
#analyze $rtl_list -autoread -define SYNTHESIS

# Elaborate the FIFO design
#elaborate ${top_design} 

lappend search_path /u/amaso/Documents/ECE527/527_Project2/dc_shell
set target_library osu05_stdcells.db
set link_library [concat "+" $target_library]
link

read_file -format sverilog ../rtl/$top_design.sv
current_design four_bit_select_adder
compile
report_area > ../reports/$top_design.area.rpt
report_cell > ../reports/$top_design.cell.rpt
report_power > ../reports/$top_design.power.rpt
write -format Verilog -hierarchy -output four_bit_select.netlist
link

#compile with ultra features and with scan FFs
#compile_ultra  -scan  -no_autoungroup
#change_names -rules verilog -hierarchy

# output reports
#set stage dc
#report_qor > ../reports/${top_design}.$stage.qor.rpt
#report_constraint -all_viol > ../reports/${top_design}.$stage.constraint.rpt
#report_timing -delay max -input -tran -cross -sig 4 -derate -net -cap  -max_path 10000 -slack_less 0 > ../reports/${top_design}.$stage.timing.max.rpt
#check_timing  > ../reports/${top_design}.$stage.check_timing.rpt
#check_design > ../reports/${top_design}.$stage.check_design.rpt
#check_mv_design  > ../reports/${top_design}.$stage.mvrc.rpt

# output netlist
#write -hier -format verilog -output ../outputs/${top_design}.$stage.vg
#write -hier -format ddc -output ../outputs/${top_design}.$stage.ddc
#save_upf ../outputs/${top_design}.$stage.upf
