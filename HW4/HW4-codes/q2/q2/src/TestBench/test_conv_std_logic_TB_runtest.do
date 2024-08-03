SetActiveLib -work
comp -include "$dsn\src\TestBench\test_conv_std_logic_TB.vhd" 
comp -include "$dsn\src\TestBench\test_conv_std_logic_TB.vhd" 
asim +access +r TESTBENCH_FOR_test_conv_std_logic 
wave 
wave -noreg value
wave -noreg size
wave -noreg result
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\test_conv_std_logic_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_test_conv_std_logic 
