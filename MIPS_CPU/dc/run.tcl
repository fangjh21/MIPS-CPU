set target_library { /data3/course_lib_umc18/synopsys/tt_1v8_25c.db }
set link_library {* /data3/course_lib_umc18/synopsys/tt_1v8_25c.db  /soft1/synopsys/dc/libraries/syn/dw_foundation.sldb}
set symbol_library { /data3/course_lib_umc18/umc18.sdb }
set synthetic_library { /soft1/synopsys/dc/libraries/syn/dw_foundation.sldb}
remove_design -all
# specify your verilog files here (please list all RTL files)
set FILE_LIST { "src/TOP.v" "src/alu.v" "src/branch_forward.v" "src/compare.v" "src/control.v" "src/dff.v" "src/EX_MEM.v" "src/forward.v" "src/hazard.v" "src/ID_EX.v"  "src/IF_ID.v" "src/MEM_WB.v" "src/mux.v"  "src/registers.v" }
# specify your top module here
set TOP_CELL top
#reset_design

analyze -format verilog $FILE_LIST
elaborate $TOP_CELL
current_design $TOP_CELL
link
uniquify
check_design

# specify your clock port here
set CLK {"clk"}
# specify your clock period here (in nanosecend)
set CLK_PERIOD 4

create_clock [get_ports $CLK] -period $CLK_PERIOD
set_dont_touch_network [all_clocks]
set_clock_uncertainty [expr $CLK_PERIOD * 0.001] [all_clocks]
set_clock_transition 0.01 [all_clocks]

set all_in_except_clk [remove_from_collection [all_inputs] [get_ports $CLK]]

set_input_delay [expr $CLK_PERIOD * 0.0] -clock $CLK $all_in_except_clk

set_max_area 0

set_operating_conditions -max "tt_1v8_25c" -max_library "tt_1v8_25c" 

set auto_wire_load_selection false

compile_ultra

sh rm  -r output/
sh mkdir output
#write -hierarchy -format db -output "output/${TOP_CELL}_map.db"
write -hierarchy -format ddc -output "output/${TOP_CELL}_map.ddc"
write -hierarchy -format verilog -output "output/${TOP_CELL}_map.v"
write_sdf "output/${TOP_CELL}.sdf"
write_sdc "output/${TOP_CELL}.sdc"

sh mkdir reports
report_timing > "reports/${TOP_CELL}_timing.rpt"
report_timing -delay min >> "reports/${TOP_CELL}_timing.rpt"
report_area > "reports/${TOP_CELL}_area.rpt"
report_power > "reports/${TOP_CELL}_power.rpt"
