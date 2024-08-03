SetActiveLib -work
comp -include "$dsn\src\encoder.vhd" 
comp -include "$dsn\src\TestBench\priorityencoder_when_else_TB.vhd" 
asim +access +r TESTBENCH_FOR_priorityencoder_when_else 
wave 
wave -noreg inp
wave -noreg outp
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\priorityencoder_when_else_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_priorityencoder_when_else 
