SetActiveLib -work
comp -include "$dsn\src\number_processor.vhd" 
comp -include "$dsn\src\TestBench\numberoperations_TB.vhd" 
asim +access +r TESTBENCH_FOR_numberoperations 
wave 
wave -noreg a
wave -noreg b
wave -noreg c
wave -noreg d
wave -noreg e
wave -noreg f
wave -noreg max_num
wave -noreg min_num
wave -noreg sorted_num1
wave -noreg sorted_num2
wave -noreg sorted_num3
wave -noreg sorted_num4
wave -noreg sorted_num5
wave -noreg sorted_num6
wave -noreg most_frequent
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\numberoperations_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_numberoperations 
