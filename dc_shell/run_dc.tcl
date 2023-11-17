# Framework for tcl file taken from ECE581 documentation
#
#
#
# Written by Alexander Maso

lappend search_path /u/amaso/Documents/ECE527/527_Project2/dc_shell
set target_library osu05_stdcells.db
set link_library [concat "+" $target_library]
link

read_file -format sverilog 4BitCSelectAdder.sv
current_design four_bit_select_adder
compile
report_area
report_cell
report_power
write -format Verilog -hierarchy -output 4BitCSelectAdder.netlist
link
