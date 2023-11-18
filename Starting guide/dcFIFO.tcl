#!/bin/bash
#**************************************************/
#* 16th Aug 2016 */
#* Author: Sumeet Jain */
#* */
#*Script for Design Compiler - Synopsys */
#* */
#* Make changes to this script acc to your design */
#**************************************************/
#set the target library to build the circuit
set target_library gscl45nm.db
#links the main library for DC to obtain default values and settings
set link_library gscl45nm.db
#reading the verilog RTL netlist
read_sverilog SVFIFO.sv
#link the design and library
link
#setting timing constraints
create_clock -period 10 -name clk [get_ports clk ]
set_input_delay 2 -clock clk [remove_from_collection [all_inputs] clk]
set_output delay 2 -clock clk [all_outputs]
set_wire_load_model -name fillCount
set_wire_load_model -name ReadData
set_clock_uncertainty 0.1 [all_clocks]
set_clock_latency 0.5 -source [get_ports clk]
set_load 0.5 [all_outputs]
#compile the design to obtain gate level netlist
compile -ungroup_all
#diaplay the timing report
report_timing
#reporting all the references(cell) in the design
report_reference
#create synthesis file
write -f verilog -h -o SVFIFO_netlist.v