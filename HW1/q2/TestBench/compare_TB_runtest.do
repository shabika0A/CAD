SetActiveLib -work
comp -include "$dsn\src\comparator.vhd" 
comp -include "$dsn\src\TestBench\compare_TB.vhd" 
asim +access +r TESTBENCH_FOR_compare 
wave 
wave -noreg num1
wave -noreg num2
wave -noreg less
wave -noreg equal
wave -noreg greater
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\compare_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_compare 
