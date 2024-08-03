SetActiveLib -work
comp -include "$dsn\src\complex_operations.vhd" 
comp -include "$dsn\src\TestBench\complex_operations_TB.vhd" 
asim +access +r TESTBENCH_FOR_complex_operations 
wave 
wave -noreg x1_real
wave -noreg x1_imag
wave -noreg x2_real
wave -noreg x2_imag
wave -noreg multiply
wave -noreg add
wave -noreg subtract
wave -noreg result_real
wave -noreg result_imag
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\complex_operations_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_complex_operations 
