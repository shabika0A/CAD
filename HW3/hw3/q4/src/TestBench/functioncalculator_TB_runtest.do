SetActiveLib -work
comp -include "$dsn\src\functions.vhd" 
comp -include "$dsn\src\TestBench\functioncalculator_TB.vhd" 
asim +access +r TESTBENCH_FOR_functioncalculator 
wave 
wave -noreg x
wave -noreg f
wave -noreg g
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\functioncalculator_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_functioncalculator 
