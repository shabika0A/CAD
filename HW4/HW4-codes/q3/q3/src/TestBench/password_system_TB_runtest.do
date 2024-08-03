SetActiveLib -work
comp -include "$dsn\src\q3.vhd" 
comp -include "$dsn\src\TestBench\password_system_TB.vhd" 
asim +access +r TESTBENCH_FOR_password_system 
wave 
wave -noreg Reset
wave -noreg Input
wave -noreg Output
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\password_system_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_password_system 
