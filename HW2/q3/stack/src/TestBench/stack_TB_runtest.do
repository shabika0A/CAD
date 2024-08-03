SetActiveLib -work
comp -include "$dsn\src\stack.vhd" 
comp -include "$dsn\src\TestBench\stack_TB.vhd" 
asim +access +r TESTBENCH_FOR_stack 
wave 
wave -noreg clk
wave -noreg rst
wave -noreg push
wave -noreg pop
wave -noreg full
wave -noreg empty
wave -noreg error
wave -noreg data_in
wave -noreg data_out
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\stack_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_stack 
