SetActiveLib -work
comp -include "$dsn\src\1counter.vhd" 
comp -include "$dsn\src\TestBench\ones_counter_TB.vhd" 
asim +access +r TESTBENCH_FOR_ones_counter 
wave 
wave -noreg data
wave -noreg count
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\ones_counter_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_ones_counter 
