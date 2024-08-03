SetActiveLib -work
comp -include "$dsn\src\encoder_gates.vhd" 
comp -include "$dsn\src\TestBench\priorityencoder_gates_TB.vhd" 
asim +access +r TESTBENCH_FOR_priorityencoder_gates 
wave 
wave -noreg inp
wave -noreg outp
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\priorityencoder_gates_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_priorityencoder_gates 
