SetActiveLib -work
comp -include "$dsn\src\traffic_light.vhd" 
comp -include "$dsn\src\TestBench\traffic_light_TB.vhd" 
asim +access +r TESTBENCH_FOR_traffic_light 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg bcd_out
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\traffic_light_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_traffic_light 
